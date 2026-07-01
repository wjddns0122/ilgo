import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/app_routes.dart';
import '../../core/responsive.dart';
import '../../core/theme.dart';
import '../../data/models/enums.dart';
import '../../data/services/profile_service.dart';
import '../../widgets/onb_header.dart';

/// Onboarding step 1/3 — output mode selection (Figma node 1:150). Responsive.
class OnboardingModeView extends StatefulWidget {
  const OnboardingModeView({super.key});

  @override
  State<OnboardingModeView> createState() => _OnboardingModeViewState();
}

class _OnboardingModeViewState extends State<OnboardingModeView> {
  OutputMode? _selected;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.paper,
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: kOnbMaxWidth),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                OnbHeader(step: 1, onBack: () => Get.back()),
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: context.rs(28)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: context.rs(24)),
                          Text(
                            '어떻게 읽어드릴까요?',
                            style: GoogleFonts.notoSansKr(
                              fontSize: context.rs(25.6),
                              height: 1.5,
                              fontWeight: FontWeight.w700,
                              letterSpacing: -0.256,
                              color: AppColors.ink,
                            ),
                          ),
                          SizedBox(height: context.rs(12)),
                          Text(
                            '읽기 편한 방식을 하나 골라주세요.',
                            style: GoogleFonts.notoSansKr(
                              fontSize: context.rs(16),
                              fontWeight: FontWeight.w700,
                              color: AppColors.stone,
                            ),
                          ),
                          SizedBox(height: context.rs(32)),
                          _ModeCard(
                            badge: '가',
                            title: '쉬운 한국어',
                            subtitle: '큰 글씨와 짧은 문장으로 풀어드려요.',
                            selected: _selected == OutputMode.easyKorean,
                            onTap: () => setState(
                                () => _selected = OutputMode.easyKorean),
                          ),
                          SizedBox(height: context.rs(16)),
                          _ModeCard(
                            badge: 'A가',
                            title: '내 언어로',
                            subtitle: '모국어로 풀이하고 한국어 답장을 도와드려요.',
                            selected: _selected == OutputMode.nativeLang,
                            onTap: () => setState(
                                () => _selected = OutputMode.nativeLang),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(
                      context.rs(28), context.rs(20), context.rs(28), context.rs(32)),
                  child: Column(
                    children: [
                      _nextButton(context),
                      SizedBox(height: context.rs(8)),
                      Text(
                        '설정에서 언제든 바꿀 수 있어요.',
                        style: GoogleFonts.notoSansKr(
                          fontSize: context.rs(13),
                          color: AppColors.stone,
                        ),
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

  Widget _nextButton(BuildContext context) {
    final enabled = _selected != null;
    return SizedBox(
      width: double.infinity,
      child: Material(
        color:
            enabled ? AppColors.forest : AppColors.forest.withValues(alpha: 0.4),
        borderRadius: BorderRadius.circular(8),
        child: InkWell(
          borderRadius: BorderRadius.circular(8),
          onTap: enabled ? _next : null,
          child: Padding(
            padding: EdgeInsets.symmetric(
                vertical: context.rs(16), horizontal: context.rs(24)),
            child: Center(
              child: Text(
                '다음',
                style: GoogleFonts.notoSansKr(
                  fontSize: context.rs(16),
                  height: 1.5,
                  color: AppColors.paper,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _next() async {
    final mode = _selected!;
    final profile = Get.find<ProfileService>();
    await profile.setProfile(outputMode: mode);
    if (mode == OutputMode.nativeLang) {
      // 내 언어로 → 언어 선택(2/3).
      Get.toNamed(Routes.onboardingLanguage);
    } else {
      // 쉬운 한국어 → 언어 선택 불필요, 바로 권한(3/3).
      await profile.setProfile(language: 'ko');
      Get.toNamed(Routes.onboardingPermission);
    }
  }
}

class _ModeCard extends StatelessWidget {
  const _ModeCard({
    required this.badge,
    required this.title,
    required this.subtitle,
    required this.selected,
    required this.onTap,
  });

  final String badge;
  final String title;
  final String subtitle;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.card,
      borderRadius: BorderRadius.circular(8),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: EdgeInsets.all(context.rs(21)),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: selected ? AppColors.forest : AppColors.hairline,
              width: selected ? 2 : 1,
            ),
          ),
          child: Row(
            children: [
              Container(
                width: context.rs(56),
                height: context.rs(56),
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  color: AppColors.sand,
                  shape: BoxShape.circle,
                ),
                child: Text(
                  badge,
                  style: GoogleFonts.notoSansKr(
                    fontSize: context.rs(19.2),
                    height: 1.5,
                    fontWeight: FontWeight.w700,
                    letterSpacing: -0.192,
                    color: AppColors.forest,
                  ),
                ),
              ),
              SizedBox(width: context.rs(20)),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: GoogleFonts.notoSansKr(
                        fontSize: context.rs(16),
                        height: 1.5,
                        fontWeight: FontWeight.w700,
                        letterSpacing: -0.16,
                        color: AppColors.ink,
                      ),
                    ),
                    SizedBox(height: context.rs(4)),
                    Text(
                      subtitle,
                      style: GoogleFonts.notoSansKr(
                        fontSize: context.rs(14.08),
                        height: 1.5,
                        color: AppColors.stone,
                      ),
                    ),
                  ],
                ),
              ),
              if (selected) ...[
                SizedBox(width: context.rs(8)),
                Icon(Icons.check_circle,
                    color: AppColors.forest, size: context.rs(24)),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
