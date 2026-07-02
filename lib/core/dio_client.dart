import 'package:dio/dio.dart';

import 'config.dart';
import 'device_id.dart';
import 'token_store.dart';

/// Builds a Dio configured with timeouts, the anonymous device header, JWT
/// bearer auth, and automatic access-token refresh on 401.
Dio buildDio() {
  final dio = Dio(BaseOptions(
    baseUrl: Config.baseUrl,
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 30),
    contentType: 'application/json',
  ));

  dio.interceptors.add(InterceptorsWrapper(
    onRequest: (options, handler) async {
      options.headers['X-Device-Id'] = await DeviceId.get();
      final token = await TokenStore.access();
      if (token != null && token.isNotEmpty) {
        options.headers['Authorization'] = 'Bearer $token';
      }
      handler.next(options);
    },
    onError: (err, handler) async {
      final isAuthCall = err.requestOptions.path.contains('/auth/');
      if (err.response?.statusCode == 401 && !isAuthCall) {
        final refreshed = await _tryRefresh();
        if (refreshed) {
          try {
            final token = await TokenStore.access();
            final req = err.requestOptions;
            req.headers['Authorization'] = 'Bearer $token';
            final retried = await dio.fetch<dynamic>(req);
            return handler.resolve(retried);
          } catch (_) {
            // fall through to the original error
          }
        } else {
          await TokenStore.clear(); // session dead → app routes to login
        }
      }
      handler.next(err);
    },
  ));
  return dio;
}

/// Exchanges the refresh token for a new access token. Uses a bare Dio so it
/// never re-enters the auth interceptor. Returns true on success.
Future<bool> _tryRefresh() async {
  final refresh = await TokenStore.refresh();
  if (refresh == null || refresh.isEmpty) return false;
  try {
    final bare = Dio(BaseOptions(
      baseUrl: Config.baseUrl,
      connectTimeout: const Duration(seconds: 10),
      contentType: 'application/json',
    ));
    final res = await bare.post<Map<String, dynamic>>(
      '/auth/refresh',
      data: {'refresh_token': refresh},
    );
    final data = res.data ?? const {};
    final access = data['access_token'] as String?;
    if (access == null || access.isEmpty) return false;
    await TokenStore.save(
      access: access,
      refresh: (data['refresh_token'] as String?) ?? refresh,
    );
    return true;
  } catch (_) {
    return false;
  }
}
