import 'package:get/get.dart';

import '../../data/models/enums.dart';
import '../../data/services/profile_service.dart';

/// Settings: change output mode (쉬운 한국어 / 모국어) and language.
class SettingsController extends GetxController {
  ProfileService get _profile => Get.find<ProfileService>();

  OutputMode get mode => _profile.mode.value;
  String get lang => _profile.lang.value;

  Future<void> setMode(OutputMode mode) async {
    // Easy-Korean implies Korean output; native demo implies English.
    await _profile.setProfile(
      outputMode: mode,
      language: mode == OutputMode.easyKorean ? 'ko' : 'en',
    );
  }

  Future<void> setLang(String lang) => _profile.setProfile(language: lang);
}
