import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/app_routes.dart';
import '../../core/responsive.dart';
import '../../core/theme.dart';
import '../../data/services/auth_service.dart';
import '../../data/services/profile_service.dart';

/// Splash screen (Figma node 30:751): brand mark + tagline. After a short
/// delay it routes to onboarding (first run) or home.
class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  Timer? _timer;
  double _opacity = 0;

  @override
  void initState() {
    super.initState();
    // Fade in, then route away.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) setState(() => _opacity = 1);
    });
    _timer = Timer(const Duration(milliseconds: 2000), _next);
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  Future<void> _next() async {
    // Restore a saved session; if valid go straight to home (onboarding is
    // only for brand-new signups), otherwise go to login.
    final ok = await Get.find<AuthService>().restoreSession();
    if (!mounted) return;
    if (ok) {
      await Get.find<ProfileService>().syncFromServer();
      _go(Get.find<ProfileService>().forceOnboarding);
    } else {
      Get.offAllNamed(Routes.login);
    }
  }

  void _go(bool onboarding) =>
      Get.offAllNamed(onboarding ? Routes.onboarding : Routes.home);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.paper,
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: kOnbMaxWidth),
            child: AnimatedOpacity(
              opacity: _opacity,
              duration: const Duration(milliseconds: 600),
              curve: Curves.easeOut,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _logo(context),
                  SizedBox(height: context.rs(24)),
                  Text(
                    '어려운 글,\n읽고가 쉽게\n풀어드려요',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.notoSansKr(
                      fontSize: context.rs(30),
                      height: 1.45,
                      fontWeight: FontWeight.w700,
                      letterSpacing: -0.3,
                      color: AppColors.ink,
                    ),
                  ),
                  SizedBox(height: context.rs(20)),
                  Text(
                    '이메일만 있으면\n바로 시작할 수 있어요.',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.notoSansKr(
                      fontSize: context.rs(20),
                      height: 1.6,
                      color: AppColors.stone,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _logo(BuildContext context) {
    final s = context.rs(180);
    return Image.asset(
      'assets/images/applogo.png',
      width: s,
      height: s,
      errorBuilder: (_, _, _) => Container(
        width: s,
        height: s,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: AppColors.forest,
          borderRadius: BorderRadius.circular(s * 0.22),
        ),
        child: Text(
          '읽고',
          style: GoogleFonts.notoSansKr(
            fontSize: s * 0.3,
            fontWeight: FontWeight.w800,
            color: AppColors.paper,
          ),
        ),
      ),
    );
  }
}
