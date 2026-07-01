import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/enums.dart';

/// Persists the user's chosen output mode + language and the onboarding flag.
/// Registered app-wide so any screen/controller can read the current profile.
class ProfileService extends GetxService {
  static const _kMode = 'output_mode';
  static const _kLang = 'lang';
  static const _kOnboarded = 'onboarded';

  late SharedPreferences _prefs;

  final mode = OutputMode.easyKorean.obs;
  final lang = 'ko'.obs;

  Future<ProfileService> init() async {
    _prefs = await SharedPreferences.getInstance();
    mode.value = OutputMode.fromWire(_prefs.getString(_kMode) ?? 'easy_korean');
    lang.value = _prefs.getString(_kLang) ?? 'ko';
    return this;
  }

  bool get onboarded => _prefs.getBool(_kOnboarded) ?? false;

  Future<void> completeOnboarding() => _prefs.setBool(_kOnboarded, true);

  Future<void> setProfile({OutputMode? outputMode, String? language}) async {
    if (outputMode != null) {
      mode.value = outputMode;
      await _prefs.setString(_kMode, outputMode.wire);
    }
    if (language != null) {
      lang.value = language;
      await _prefs.setString(_kLang, language);
    }
  }
}
