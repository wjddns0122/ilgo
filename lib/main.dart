import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'core/app_pages.dart';
import 'core/app_routes.dart';
import 'core/theme.dart';
import 'data/bindings/app_binding.dart';
import 'data/services/profile_service.dart';
import 'data/services/tts_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // App-wide services (persisted profile + text-to-speech) available everywhere.
  await Get.putAsync(() => ProfileService().init());
  await Get.putAsync(() => TtsService().init());

  // Splash decides where to go next (onboarding vs home).
  runApp(const IlgoApp(initialRoute: Routes.splash));
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
      // Apply the user's text-size preference app-wide.
      builder: (context, child) => Obx(
        () => MediaQuery(
          data: MediaQuery.of(context).copyWith(
            textScaler:
                TextScaler.linear(Get.find<ProfileService>().textScale.value),
          ),
          child: child ?? const SizedBox.shrink(),
        ),
      ),
    );
  }
}
