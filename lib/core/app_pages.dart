import 'package:get/get.dart';

import '../modules/analyze/analyze_view.dart';
import '../modules/analyze/connection_failed_view.dart';
import '../modules/analyze/not_a_document_view.dart';
import '../modules/analyze/unreadable_view.dart';
import '../modules/login/login_view.dart';
import '../modules/login/signup_view.dart';
import '../modules/login/signup_complete_view.dart';
import '../modules/splash/splash_view.dart';
import '../modules/camera/camera_view.dart';
import '../modules/camera/confirm_view.dart';
import '../modules/result/calendar_added_view.dart';
import '../modules/result/listen_tts_view.dart';
import '../modules/result/reply_detail_view.dart';
import '../modules/result/risk_detail_view.dart';
import '../modules/home/home_view.dart';
import '../modules/library/library_view.dart';
import '../modules/onboarding/language_view.dart';
import '../modules/onboarding/mode_view.dart';
import '../modules/onboarding/permission_view.dart';
import '../modules/onboarding/text_size_view.dart';
import '../modules/onboarding/onboarding_view.dart';
import '../modules/result/result_view.dart';
import '../modules/help/help_view.dart';
import '../modules/settings/language_view.dart';
import '../modules/settings/settings_view.dart';
import '../modules/settings/text_size_view.dart';
import 'app_routes.dart';

/// Route table. All controllers/repositories are provided globally by
/// [AppBinding] (set as initialBinding), so no per-page bindings are needed.
abstract class AppPages {
  static final routes = <GetPage<dynamic>>[
    GetPage(name: Routes.splash, page: () => const SplashView()),
    GetPage(name: Routes.login, page: () => const LoginView()),
    GetPage(name: Routes.signup, page: () => const SignupView()),
    GetPage(
        name: Routes.signupComplete, page: () => const SignupCompleteView()),
    GetPage(name: Routes.onboarding, page: () => const OnboardingView()),
    GetPage(name: Routes.onboardingMode, page: () => const OnboardingModeView()),
    GetPage(
        name: Routes.onboardingLanguage,
        page: () => const OnboardingLanguageView()),
    GetPage(
        name: Routes.onboardingTextSize,
        page: () => const OnboardingTextSizeView()),
    GetPage(
        name: Routes.onboardingPermission,
        page: () => const OnboardingPermissionView()),
    GetPage(name: Routes.home, page: () => const HomeView()),
    GetPage(name: Routes.camera, page: () => const CameraView()),
    GetPage(name: Routes.confirmCapture, page: () => const ConfirmView()),
    GetPage(name: Routes.analyze, page: () => const AnalyzeView()),
    GetPage(name: Routes.unreadable, page: () => const UnreadableView()),
    GetPage(
        name: Routes.notADocument, page: () => const NotADocumentView()),
    GetPage(
        name: Routes.connectionFailed,
        page: () => const ConnectionFailedView()),
    GetPage(name: Routes.result, page: () => const ResultView()),
    GetPage(
        name: Routes.calendarAdded, page: () => const CalendarAddedView()),
    GetPage(name: Routes.listenTts, page: () => const ListenTtsView()),
    GetPage(name: Routes.replyDetail, page: () => const ReplyDetailView()),
    GetPage(name: Routes.riskDetail, page: () => const RiskDetailView()),
    GetPage(name: Routes.library, page: () => const LibraryView()),
    GetPage(name: Routes.settings, page: () => const SettingsView()),
    GetPage(name: Routes.help, page: () => const HelpView()),
    GetPage(name: Routes.language, page: () => const LanguageView()),
    GetPage(name: Routes.textSize, page: () => const TextSizeView()),
  ];
}
