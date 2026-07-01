import 'package:dio/dio.dart';

import 'config.dart';
import 'device_id.dart';

/// Builds a Dio configured with timeouts + the anonymous device header.
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
      handler.next(options);
    },
  ));
  return dio;
}
