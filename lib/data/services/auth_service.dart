import 'package:get/get.dart';

import '../../core/token_store.dart';
import '../api/ilgo_api.dart';
import '../models/auth.dart';

/// Email/password auth against the backend (JWT). Persists tokens via
/// [TokenStore] and exposes the current [user].
class AuthService extends GetxService {
  AuthService(this._api);

  final IlgoApi _api;

  final user = Rxn<UserSummary>();

  bool get isLoggedIn => user.value != null;

  /// Restore a saved session by validating the stored token against /auth/me.
  Future<bool> restoreSession() async {
    if (!await TokenStore.hasSession()) return false;
    try {
      final me = await _api.me();
      user.value = me.user;
      return true;
    } catch (_) {
      await TokenStore.clear();
      user.value = null;
      return false;
    }
  }

  Future<void> register(String email, String password) async {
    await _store(await _api.register({'email': email, 'password': password}));
  }

  Future<void> login(String email, String password) async {
    await _store(await _api.login({'email': email, 'password': password}));
  }

  Future<void> logout() async {
    final refresh = await TokenStore.refresh();
    try {
      await _api.logout({'refresh_token': refresh});
    } catch (_) {
      // best-effort; clear locally regardless
    }
    await TokenStore.clear();
    user.value = null;
  }

  Future<void> _store(AuthResponse res) async {
    await TokenStore.save(access: res.accessToken, refresh: res.refreshToken);
    user.value = res.user;
  }
}
