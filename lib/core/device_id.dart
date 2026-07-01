import 'package:shared_preferences/shared_preferences.dart';

/// Anonymous per-device identifier (no login). Generated once on first launch
/// and persisted locally. Sent as the `X-Device-Id` header.
class DeviceId {
  const DeviceId._();

  static const _key = 'device_id';
  static String? _cached;

  static Future<String> get() async {
    if (_cached != null) return _cached!;
    final prefs = await SharedPreferences.getInstance();
    var id = prefs.getString(_key);
    if (id == null || id.isEmpty) {
      id = _generate();
      await prefs.setString(_key, id);
    }
    _cached = id;
    return id;
  }

  /// Lightweight UUID-v4-ish string without pulling in a uuid dependency.
  static String _generate() {
    final now = DateTime.now().microsecondsSinceEpoch;
    final rand = now ^ (now >> 13) ^ 0x5DEECE66D;
    String hex(int v, int len) => (v & ((1 << (len * 4)) - 1)).toRadixString(16).padLeft(len, '0');
    return 'dev-${hex(now, 8)}-${hex(rand, 4)}-${hex(now >> 16, 4)}-${hex(rand >> 8, 12)}';
  }
}
