import 'package:get/get.dart';

import '../modules/analyze/analyze_view.dart';
import '../modules/home/home_view.dart';
import '../modules/library/library_view.dart';
import '../modules/onboarding/onboarding_view.dart';
import '../modules/result/result_view.dart';
import '../modules/settings/settings_view.dart';
import 'app_routes.dart';

/// Route table. All controllers/repositories are provided globally by
/// [AppBinding] (set as initialBinding), so no per-page bindings are needed.
abstract class AppPages {
  static final routes = <GetPage<dynamic>>[
    GetPage(name: Routes.onboarding, page: () => const OnboardingView()),
    GetPage(name: Routes.home, page: () => const HomeView()),
    GetPage(name: Routes.analyze, page: () => const AnalyzeView()),
    GetPage(name: Routes.result, page: () => const ResultView()),
    GetPage(name: Routes.library, page: () => const LibraryView()),
    GetPage(name: Routes.settings, page: () => const SettingsView()),
  ];
}
