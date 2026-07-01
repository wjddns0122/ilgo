import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'core/app_pages.dart';
import 'core/app_routes.dart';
import 'core/config.dart';
import 'core/theme.dart';
import 'dev_flags.dart';
import 'data/bindings/app_binding.dart';
import 'data/services/profile_service.dart';
import 'data/services/tts_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // App-wide services (persisted profile + text-to-speech) available everywhere.
  final profile = await Get.putAsync(() => ProfileService().init());
  await Get.putAsync(() => TtsService().init());

  final showOnboarding =
      DevFlags.forceOnboarding || Config.forceOnboarding || !profile.onboarded;
  runApp(IlgoApp(
    initialRoute: showOnboarding ? Routes.onboarding : Routes.home,
  ));
}

class IlgoApp extends StatelessWidget {
  const IlgoApp({super.key, required this.initialRoute});

  final String initialRoute;

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: '읽고',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(),
      initialBinding: AppBinding(),
      initialRoute: initialRoute,
      getPages: AppPages.routes,
    );
  }
}
