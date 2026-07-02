import 'package:get/get.dart';

import '../../data/models/enums.dart';
import '../../data/services/profile_service.dart';

/// Settings: output mode, language, text size, alarm — all backed by
/// [ProfileService] (persisted).
class SettingsController extends GetxController {
  ProfileService get profile => Get.find<ProfileService>();

  OutputMode get mode => profile.mode.value;

  String get modeLabel =>
      mode == OutputMode.nativeLang ? '내 언어로' : '쉬운 한국어';

  Future<void> setMode(OutputMode m) => profile.setProfile(
        outputMode: m,
        // Easy Korean forces ko; native keeps the chosen language (default en).
        language: m == OutputMode.easyKorean
            ? 'ko'
            : (profile.lang.value == 'ko' ? 'en' : profile.lang.value),
      );

  Future<void> setLang(String code) => profile.setProfile(language: code);

  Future<void> setTextScale(double scale) => profile.setTextScale(scale);

  Future<void> setAlarm(bool on) => profile.setDeadlineAlarm(on);
}
