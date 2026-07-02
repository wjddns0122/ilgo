import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../core/app_routes.dart';
import '../../data/models/enums.dart';
import '../../data/services/auth_service.dart';
import '../../data/services/profile_service.dart';

/// Settings: output mode, language, text size, alarm — all backed by
/// [ProfileService] (persisted).
class SettingsController extends GetxController {
  ProfileService get profile => Get.find<ProfileService>();

  /// Actual camera permission state (null while loading / unknown).
  final cameraGranted = Rxn<bool>();

  @override
  void onInit() {
    super.onInit();
    refreshPermission();
  }

  Future<void> refreshPermission() async {
    try {
      final status = await Permission.camera.status;
      cameraGranted.value = status.isGranted || status.isLimited;
    } catch (_) {
      cameraGranted.value = null; // e.g. unsupported platform
    }
  }

  /// Open OS app settings, then re-check once the user comes back.
  Future<void> openPermissionSettings() async {
    await openAppSettings();
    await refreshPermission();
  }

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

  /// Sign out: revoke the session on the server (best-effort), clear tokens,
  /// then send the user back to the login screen.
  Future<void> logout() async {
    if (Get.isRegistered<AuthService>()) {
      await Get.find<AuthService>().logout();
    }
    Get.offAllNamed(Routes.login);
  }
}
