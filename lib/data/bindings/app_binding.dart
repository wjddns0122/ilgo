import 'package:get/get.dart';

import '../../core/config.dart';
import '../../core/dio_client.dart';
import '../../modules/analyze/analyze_controller.dart';
import '../../modules/home/home_controller.dart';
import '../../modules/library/library_controller.dart';
import '../../modules/settings/settings_controller.dart';
import '../../data/services/auth_service.dart';
import '../api/ilgo_api.dart';
import '../repositories/analysis_repository.dart';
import '../repositories/api_analysis_repository.dart';
import '../repositories/mock_analysis_repository.dart';

/// Root dependency injection. The `USE_MOCK` flag decides which
/// [AnalysisRepository] implementation the entire app receives — the only
/// line that changes between mock and live.
class AppBinding extends Bindings {
  @override
  void dependencies() {
    // Repository: mock (assets) or live (retrofit+dio).
    if (Config.useMock) {
      Get.put<AnalysisRepository>(MockAnalysisRepository(), permanent: true);
    } else {
      final api = IlgoApi(buildDio(), baseUrl: Config.baseUrl);
      Get.put<IlgoApi>(api, permanent: true);
      Get.put<AuthService>(AuthService(api), permanent: true);
      Get.put<AnalysisRepository>(ApiAnalysisRepository(api), permanent: true);
    }

    // Analysis state must survive home → loading → result navigation.
    Get.put(AnalyzeController(Get.find<AnalysisRepository>()),
        permanent: true);

    // Per-screen controllers. fenix: true so they survive `offAllNamed`
    // (which disposes the initial-route bindings) and are recreated on demand.
    Get.lazyPut(() => HomeController(), fenix: true);
    Get.lazyPut(() => LibraryController(Get.find<AnalysisRepository>()),
        fenix: true);
    Get.lazyPut(() => SettingsController(), fenix: true);
  }
}
