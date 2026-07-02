import 'package:shared_preferences/shared_preferences.dart';

/// Persists JWT access/refresh tokens locally (shared_preferences).
class TokenStore {
  const TokenStore._();

  static const _kAccess = 'access_token';
  static const _kRefresh = 'refresh_token';

  static String? _accessCache;
  static String? _refreshCache;
  static bool _loaded = false;

  static Future<void> _ensure() async {
    if (_loaded) return;
    final prefs = await SharedPreferences.getInstance();
    _accessCache = prefs.getString(_kAccess);
    _refreshCache = prefs.getString(_kRefresh);
    _loaded = true;
  }

  static Future<String?> access() async {
    await _ensure();
    return _accessCache;
  }

  static Future<String?> refresh() async {
    await _ensure();
    return _refreshCache;
  }

  static Future<bool> hasSession() async {
    await _ensure();
    return (_accessCache != null && _accessCache!.isNotEmpty);
  }

  static Future<void> save(
      {required String? access, required String? refresh}) async {
    final prefs = await SharedPreferences.getInstance();
    _accessCache = access;
    _refreshCache = refresh;
    _loaded = true;
    if (access == null || access.isEmpty) {
      await prefs.remove(_kAccess);
    } else {
      await prefs.setString(_kAccess, access);
    }
    if (refresh == null || refresh.isEmpty) {
      await prefs.remove(_kRefresh);
    } else {
      await prefs.setString(_kRefresh, refresh);
    }
  }

  static Future<void> clear() async {
    final prefs = await SharedPreferences.getInstance();
    _accessCache = null;
    _refreshCache = null;
    _loaded = true;
    await prefs.remove(_kAccess);
    await prefs.remove(_kRefresh);
  }
}
