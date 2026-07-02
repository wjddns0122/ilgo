import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/app_routes.dart';
import '../../core/responsive.dart';
import '../../core/theme.dart';
import '../../data/services/auth_service.dart';
import '../../data/services/profile_service.dart';

/// Email + password login screen (Figma node 30:769).
/// "시작하기" registers a new account (or logs in if the email exists).
class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _email = TextEditingController();
  final _password = TextEditingController();
  bool _obscure = true;
  bool _busy = false;

  bool get _valid =>
      _email.text.trim().isNotEmpty && _password.text.length >= 6;

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  Future<void> _start() async {
    if (!_valid || _busy) return;
    final email = _email.text.trim();
    final pw = _password.text;

    setState(() => _busy = true);
    try {
      final isNew = await Get.find<AuthService>().startWithEmail(email, pw);
      await Get.find<ProfileService>().syncFromServer();
      if (!mounted) return;
      if (isNew) {
        Get.toNamed(Routes.signupComplete, arguments: email);
      } else {
        _toApp();
      }
    } catch (_) {
      if (mounted) setState(() => _busy = false);
      Get.snackbar('로그인 실패', '이메일·비밀번호를 확인해 주세요.',
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  // Existing account (logged in, not a new signup) → home. Onboarding is
  // reserved for brand-new signups (handled via the signup-complete screen).
  void _toApp() {
    final onboarding = Get.find<ProfileService>().forceOnboarding;
    Get.offAllNamed(onboarding ? Routes.onboarding : Routes.home);
  }

  @override
  Widget build(BuildContext context) {
    final canPop = Navigator.canPop(context);
    return Scaffold(
      backgroundColor: AppColors.paper,
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: kOnbMaxWidth),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(
                      context.rs(20), context.rs(12), context.rs(20), 0),
                  child: SizedBox(
                    width: context.rs(34),
                    height: context.rs(34),
                    child: canPop
                        ? IconButton(
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                            iconSize: context.rs(28),
                            icon: const Icon(Icons.arrow_back_ios_new,
                                color: AppColors.ink),
                            onPressed: () => Get.back(),
                          )
                        : null,
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: context.rs(28)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: context.rs(8)),
                          Text(
                            '이메일로\n시작할게요',
                            style: GoogleFonts.notoSansKr(
                              fontSize: context.rs(30),
                              height: 1.35,
                              fontWeight: FontWeight.w700,
                              letterSpacing: -0.3,
                              color: AppColors.ink,
                            ),
                          ),
                          SizedBox(height: context.rs(12)),
                          Text(
                            '이메일과 비밀번호만 있으면 돼요.',
                            style: GoogleFonts.notoSansKr(
                                fontSize: context.rs(20), color: AppColors.stone),
                          ),
                          SizedBox(height: context.rs(32)),
                          _label(context, '이메일'),
                          SizedBox(height: context.rs(10)),
                          _field(
                            context,
                            controller: _email,
                            hint: 'name@example.com',
                            keyboardType: TextInputType.emailAddress,
                          ),
                          SizedBox(height: context.rs(18)),
                          _label(context, '비밀번호'),
                          SizedBox(height: context.rs(10)),
                          _field(
                            context,
                            controller: _password,
                            hint: '••••••••',
                            obscure: _obscure,
                            suffix: IconButton(
                              iconSize: context.rs(24),
                              icon: Icon(
                                _obscure
                                    ? Icons.visibility_outlined
                                    : Icons.visibility_off_outlined,
                                color: AppColors.stone,
                              ),
                              onPressed: () =>
                                  setState(() => _obscure = !_obscure),
                            ),
                          ),
                          SizedBox(height: context.rs(8)),
                          Text(
                            '6자 이상 넣어주세요.',
                            style: GoogleFonts.notoSansKr(
                                fontSize: context.rs(15), color: AppColors.stone),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(
                      context.rs(28), context.rs(8), context.rs(28), context.rs(24)),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _startButton(context),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _label(BuildContext context, String text) {
    return Text(
      text,
      style: GoogleFonts.notoSansKr(
        fontSize: context.rs(18),
        fontWeight: FontWeight.w700,
        color: AppColors.stone,
      ),
    );
  }

  Widget _field(
    BuildContext context, {
    required TextEditingController controller,
    required String hint,
    bool obscure = false,
    Widget? suffix,
    TextInputType? keyboardType,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.hairline),
      ),
      padding: EdgeInsets.only(left: context.rs(20), right: context.rs(8)),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              obscureText: obscure,
              keyboardType: keyboardType,
              onChanged: (_) => setState(() {}),
              style: GoogleFonts.notoSansKr(
                  fontSize: context.rs(19), color: AppColors.ink),
              decoration: InputDecoration(
                isDense: true,
                border: InputBorder.none,
                hintText: hint,
                hintStyle: GoogleFonts.notoSansKr(
                    fontSize: context.rs(19), color: AppColors.stone),
                contentPadding: EdgeInsets.symmetric(vertical: context.rs(20)),
              ),
            ),
          ),
          ?suffix,
        ],
      ),
    );
  }

  Widget _startButton(BuildContext context) {
    final enabled = _valid && !_busy;
    return SizedBox(
      width: double.infinity,
      child: Material(
        color:
            enabled ? AppColors.forest : AppColors.forest.withValues(alpha: 0.4),
        borderRadius: BorderRadius.circular(10),
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: enabled ? _start : null,
          child: Container(
            height: context.rs(64),
            alignment: Alignment.center,
            child: _busy
                ? SizedBox(
                    width: context.rs(24),
                    height: context.rs(24),
                    child: const CircularProgressIndicator(
                        strokeWidth: 2.5, color: Colors.white),
                  )
                : Text(
                    '시작하기',
                    style: GoogleFonts.notoSansKr(
                      fontSize: context.rs(20),
                      fontWeight: FontWeight.w700,
                      color: AppColors.paper,
                    ),
                  ),
          ),
        ),
      ),
    );
  }

}
