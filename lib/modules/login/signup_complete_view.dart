import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/app_routes.dart';
import '../../core/config.dart' as app_config;
import '../../core/responsive.dart';
import '../../core/theme.dart';
import '../../dev_flags.dart';
import '../../data/services/profile_service.dart';

/// Signup-complete screen (Figma node 30:831): deep-green celebration with a
/// check badge + email. Auto-advances into the app after a short pause.
class SignupCompleteView extends StatefulWidget {
  const SignupCompleteView({super.key});

  @override
  State<SignupCompleteView> createState() => _SignupCompleteViewState();
}

const _brightGreen = Color(0xFF3B7A57);
const _lightGreen = Color(0xFFB9D6C6);

class _SignupCompleteViewState extends State<SignupCompleteView> {
  Timer? _timer;
  double _opacity = 0;

  String get _email {
    final args = Get.arguments;
    return (args is String && args.trim().isNotEmpty)
        ? args.trim()
        : 'name@example.com';
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) setState(() => _opacity = 1);
    });
    _timer = Timer(const Duration(milliseconds: 2500), _next);
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _next() {
    final onboarded = Get.find<ProfileService>().onboarded;
    final toOnboarding = DevFlags.forceOnboarding ||
        app_config.Config.forceOnboarding ||
        !onboarded;
    Get.offAllNamed(toOnboarding ? Routes.onboarding : Routes.home);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.forest,
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: kOnbMaxWidth),
            child: AnimatedOpacity(
              opacity: _opacity,
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeOut,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: context.rs(28)),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _checkBadge(context),
                    SizedBox(height: context.rs(20)),
                    Text(
                      '가입이\n끝났어요',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.notoSansKr(
                        fontSize: context.rs(36),
                        height: 1.35,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: context.rs(16)),
                    Text(
                      '이제 어려운 글을\n읽고가 쉽게 풀어드릴게요.',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.notoSansKr(
                        fontSize: context.rs(20),
                        height: 1.6,
                        color: _lightGreen,
                      ),
                    ),
                    SizedBox(height: context.rs(48)),
                    _emailChip(context),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _checkBadge(BuildContext context) {
    final s = context.rs(132);
    return Container(
      width: s,
      height: s,
      decoration: const BoxDecoration(color: _brightGreen, shape: BoxShape.circle),
      child: Icon(Icons.check_rounded, color: Colors.white, size: s * 0.5),
    );
  }

  Widget _emailChip(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
          horizontal: context.rs(22), vertical: context.rs(20)),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Container(
            width: context.rs(46),
            height: context.rs(46),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.9),
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.mail_outline,
                size: context.rs(22), color: AppColors.forest),
          ),
          SizedBox(width: context.rs(16)),
          Expanded(
            child: Text(
              _email,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.notoSansKr(
                fontSize: context.rs(19),
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
