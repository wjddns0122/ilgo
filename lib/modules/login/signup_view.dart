import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/app_routes.dart';
import '../../core/responsive.dart';
import '../../core/theme.dart';
import '../../data/services/auth_service.dart';
import '../../data/services/profile_service.dart';
import 'auth_widgets.dart';

/// Email + password signup screen. Register only — an existing account logs in
/// on [Routes.login]. On success the account is created and the flow advances
/// to the signup-complete → onboarding screens.
class SignupView extends StatefulWidget {
  const SignupView({super.key});

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _confirm = TextEditingController();
  bool _obscure = true;
  bool _obscureConfirm = true;
  bool _busy = false;

  @override
  void initState() {
    super.initState();
    // Prefill the email when arriving from the login screen.
    final args = Get.arguments;
    if (args is String && args.trim().isNotEmpty) _email.text = args.trim();
  }

  bool get _mismatch =>
      _confirm.text.isNotEmpty && _confirm.text != _password.text;

  bool get _valid =>
      _email.text.trim().isNotEmpty &&
      _password.text.length >= 6 &&
      _confirm.text == _password.text;

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    _confirm.dispose();
    super.dispose();
  }

  Future<void> _signup() async {
    if (!_valid || _busy) return;
    final email = _email.text.trim();
    final pw = _password.text;

    setState(() => _busy = true);
    try {
      await Get.find<AuthService>().register(email, pw);
      await Get.find<ProfileService>().syncFromServer();
      if (!mounted) return;
      Get.toNamed(Routes.signupComplete, arguments: email);
    } on DioException catch (e) {
      if (mounted) setState(() => _busy = false);
      final code = e.response?.statusCode ?? 0;
      if (code == 400 || code == 409 || code == 422) {
        Get.snackbar(
          '가입 실패',
          '이미 가입된 이메일이에요.',
          snackPosition: SnackPosition.BOTTOM,
          mainButton: TextButton(
            onPressed: () {
              if (Get.isSnackbarOpen) Get.closeCurrentSnackbar();
              _toLogin(email);
            },
            child: const Text('로그인 하기'),
          ),
        );
      } else {
        _genericError();
      }
    } catch (_) {
      if (mounted) setState(() => _busy = false);
      _genericError();
    }
  }

  void _genericError() {
    Get.snackbar('가입 실패', '잠시 후 다시 시도해 주세요.',
        snackPosition: SnackPosition.BOTTOM);
  }

  // Back to login. If we were pushed from login, pop; otherwise replace.
  void _toLogin(String email) {
    if (Navigator.canPop(context)) {
      Get.back();
    } else {
      Get.offNamed(Routes.login, arguments: email);
    }
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
                Expanded(
                  child: CustomScrollView(
                    slivers: [
                      // Floating header: hides on scroll-down, snaps back on
                      // scroll-up.
                      SliverAppBar(
                        floating: true,
                        snap: true,
                        automaticallyImplyLeading: false,
                        backgroundColor: AppColors.paper,
                        surfaceTintColor: Colors.transparent,
                        elevation: 0,
                        scrolledUnderElevation: 0,
                        toolbarHeight: context.rs(46),
                        leadingWidth: context.rs(60),
                        leading: canPop
                            ? Padding(
                                padding: EdgeInsets.only(left: context.rs(20)),
                                child: authBackButton(context, canPop: true),
                              )
                            : null,
                      ),
                      SliverPadding(
                        padding:
                            EdgeInsets.symmetric(horizontal: context.rs(28)),
                        sliver: SliverToBoxAdapter(
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
                                fontSize: context.rs(20),
                                color: AppColors.stone),
                          ),
                          SizedBox(height: context.rs(24)),
                          authTobagiGreeting(
                              context, '천천히 해도 괜찮아. 내가 같이 있을게.'),
                          SizedBox(height: context.rs(24)),
                          authLabel(context, '이메일'),
                          SizedBox(height: context.rs(10)),
                          authField(
                            context,
                            controller: _email,
                            hint: 'name@example.com',
                            keyboardType: TextInputType.emailAddress,
                            onChanged: (_) => setState(() {}),
                          ),
                          SizedBox(height: context.rs(18)),
                          authLabel(context, '비밀번호'),
                          SizedBox(height: context.rs(10)),
                          authField(
                            context,
                            controller: _password,
                            hint: '••••••••',
                            obscure: _obscure,
                            onChanged: (_) => setState(() {}),
                            suffix: authObscureToggle(
                              context,
                              obscure: _obscure,
                              onToggle: () =>
                                  setState(() => _obscure = !_obscure),
                            ),
                          ),
                          SizedBox(height: context.rs(8)),
                          Text(
                            '6자 이상 넣어주세요.',
                            style: GoogleFonts.notoSansKr(
                                fontSize: context.rs(15),
                                color: AppColors.stone),
                          ),
                          SizedBox(height: context.rs(18)),
                          authLabel(context, '비밀번호 확인'),
                          SizedBox(height: context.rs(10)),
                          authField(
                            context,
                            controller: _confirm,
                            hint: '••••••••',
                            obscure: _obscureConfirm,
                            onChanged: (_) => setState(() {}),
                            suffix: authObscureToggle(
                              context,
                              obscure: _obscureConfirm,
                              onToggle: () => setState(
                                  () => _obscureConfirm = !_obscureConfirm),
                            ),
                          ),
                          SizedBox(height: context.rs(8)),
                          Text(
                            _mismatch ? '비밀번호가 서로 달라요.' : '한 번 더 넣어주세요.',
                            style: GoogleFonts.notoSansKr(
                              fontSize: context.rs(15),
                              color:
                                  _mismatch ? AppColors.riskRed : AppColors.stone,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(context.rs(28), context.rs(8),
                      context.rs(28), context.rs(24)),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      authPrimaryButton(
                        context,
                        label: '회원가입',
                        enabled: _valid,
                        busy: _busy,
                        onTap: _signup,
                      ),
                      SizedBox(height: context.rs(4)),
                      authSwitchLink(
                        context,
                        leading: '이미 계정이 있으신가요?',
                        action: '로그인',
                        onTap: () => _toLogin(_email.text.trim()),
                      ),
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
}
