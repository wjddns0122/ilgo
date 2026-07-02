import 'dart:async';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/config.dart';
import '../../dev_flags.dart';
import '../api/ilgo_api.dart';
import '../models/enums.dart';
import 'auth_service.dart';

/// Persists the user's chosen output mode + language and the onboarding flag.
/// Registered app-wide so any screen/controller can read the current profile.
class ProfileService extends GetxService {
  static const _kMode = 'output_mode';
  static const _kLang = 'lang';
  static const _kOnboarded = 'onboarded';
  static const _kTextScale = 'text_scale';
  static const _kAlarm = 'deadline_alarm';

  /// Language code → Korean label, shown in settings.
  static const langLabels = <String, String>{
    'ko': '한국어',
    'km': '크메르어',
    'vi': '베트남어',
    'ne': '네팔어',
    'en': '영어',
    'zh': '중국어',
    'th': '태국어',
    'id': '인도네시아어',
  };

  /// Text-size preset label → scale factor.
  static const textScalePresets = <String, double>{
    '작게': 0.9,
    '보통': 1.0,
    '크게': 1.15,
    '아주 크게': 1.3,
  };

  late SharedPreferences _prefs;

  final mode = OutputMode.easyKorean.obs;
  final lang = 'ko'.obs;
  final textScale = 1.0.obs;
  final deadlineAlarm = true.obs;

  Future<ProfileService> init() async {
    _prefs = await SharedPreferences.getInstance();
    mode.value = OutputMode.fromWire(_prefs.getString(_kMode) ?? 'easy_korean');
    lang.value = _prefs.getString(_kLang) ?? 'ko';
    textScale.value = _prefs.getDouble(_kTextScale) ?? 1.0;
    deadlineAlarm.value = _prefs.getBool(_kAlarm) ?? true;
    return this;
  }

  bool get onboarded => _prefs.getBool(_kOnboarded) ?? false;

  /// Dev-only force flag (ignores signup/onboarding state).
  bool get forceOnboarding => DevFlags.forceOnboarding || Config.forceOnboarding;

  /// Whether the app should route to onboarding rather than home.
  /// Used in mock/offline mode (no accounts) — real mode keys off signup.
  bool get shouldOnboard => forceOnboarding || !onboarded;

  Future<void> completeOnboarding() => _prefs.setBool(_kOnboarded, true);

  String get langLabel => langLabels[lang.value] ?? lang.value;

  /// Current text-size preset label (nearest match).
  String get textScaleLabel => textScalePresets.entries
      .firstWhere((e) => e.value == textScale.value,
          orElse: () => const MapEntry('보통', 1.0))
      .key;

  IlgoApi? get _api =>
      Get.isRegistered<IlgoApi>() ? Get.find<IlgoApi>() : null;

  bool get _authed =>
      Get.isRegistered<AuthService>() && Get.find<AuthService>().isLoggedIn;

  /// Pull the server profile after login / session restore.
  Future<void> syncFromServer() async {
    final api = _api;
    if (api == null || !_authed) return;
    try {
      final p = await api.getProfile();
      if (p.outputMode != null) {
        mode.value = OutputMode.fromWire(p.outputMode!);
        await _prefs.setString(_kMode, p.outputMode!);
      }
      if (p.lang != null) {
        lang.value = p.lang!;
        await _prefs.setString(_kLang, p.lang!);
      }
      if (p.textScale != null) {
        textScale.value = p.textScale!;
        await _prefs.setDouble(_kTextScale, p.textScale!);
      }
      if (p.deadlineAlarm != null) {
        deadlineAlarm.value = p.deadlineAlarm!;
        await _prefs.setBool(_kAlarm, p.deadlineAlarm!);
      }
    } catch (_) {
      // keep local values if the server is unreachable
    }
  }

  Future<void> _push() async {
    final api = _api;
    if (api == null || !_authed) return;
    try {
      await api.putProfile({
        'output_mode': mode.value.wire,
        'lang': lang.value,
        'text_scale': textScale.value,
        'deadline_alarm': deadlineAlarm.value,
      });
    } catch (_) {
      // best-effort; local value already saved
    }
  }

  Future<void> setProfile({OutputMode? outputMode, String? language}) async {
    if (outputMode != null) {
      mode.value = outputMode;
      await _prefs.setString(_kMode, outputMode.wire);
    }
    if (language != null) {
      lang.value = language;
      await _prefs.setString(_kLang, language);
    }
    unawaited(_push());
  }

  Future<void> setTextScale(double scale) async {
    textScale.value = scale;
    await _prefs.setDouble(_kTextScale, scale);
    unawaited(_push());
  }

  Future<void> setDeadlineAlarm(bool on) async {
    deadlineAlarm.value = on;
    await _prefs.setBool(_kAlarm, on);
    unawaited(_push());
  }
}
