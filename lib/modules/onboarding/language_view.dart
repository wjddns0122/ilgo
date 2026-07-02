import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/app_routes.dart';
import '../../core/responsive.dart';
import '../../core/theme.dart';
import '../../data/services/profile_service.dart';
import '../../widgets/onb_header.dart';

/// A selectable native language (Figma node 1:253).
class _Lang {
  const _Lang(this.code, this.badge, this.name, this.native);
  final String code; // ISO 639-1
  final String badge; // short script sample
  final String name; // Korean label
  final String native; // endonym
}

const _languages = <_Lang>[
  _Lang('km', 'ខ្ម', '크메르어', 'ភាសាខ្មែរ'),
  _Lang('vi', 'Vi', '베트남어', 'Tiếng Việt'),
  _Lang('ne', 'ने', '네팔어', 'नेपाली'),
  _Lang('en', 'En', '영어', 'English'),
];

/// Onboarding step 2/3 (native path) — mother-tongue selection. Responsive.
class OnboardingLanguageView extends StatefulWidget {
  const OnboardingLanguageView({super.key});

  @override
  State<OnboardingLanguageView> createState() => _OnboardingLanguageViewState();
}

class _OnboardingLanguageViewState extends State<OnboardingLanguageView> {
  String? _selected;

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
                OnbHeader(step: 2, total: 4, onBack: () => Get.back()),
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: context.rs(28)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: context.rs(24)),
                          Text(
                            '어떤 언어로 읽어드릴까요?',
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
                            '모국어를 하나 골라주세요.',
                            style: GoogleFonts.notoSansKr(
                              fontSize: context.rs(16),
                              color: AppColors.stone,
                            ),
                          ),
                          SizedBox(height: context.rs(32)),
                          _grid(context),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(
                      context.rs(28), context.rs(8), context.rs(28), context.rs(32)),
                  child: _nextButton(context),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _grid(BuildContext context) {
    final gap = context.rs(16);
    return Column(
      children: [
        for (var row = 0; row < _languages.length; row += 2) ...[
          if (row > 0) SizedBox(height: gap),
          IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(child: _card(context, _languages[row])),
                SizedBox(width: gap),
                Expanded(
                  child: row + 1 < _languages.length
                      ? _card(context, _languages[row + 1])
                      : const SizedBox(),
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }

  Widget _card(BuildContext context, _Lang lang) {
    final selected = _selected == lang.code;
    return Material(
      color: AppColors.card,
      borderRadius: BorderRadius.circular(8),
      child: InkWell(
        onTap: () => setState(() => _selected = lang.code),
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
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: context.rs(48),
                    height: context.rs(48),
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      color: AppColors.sand,
                      shape: BoxShape.circle,
                    ),
                    // No forced font family → allows system glyph fallback for
                    // Khmer / Devanagari scripts that Noto Sans KR lacks.
                    child: Text(
                      lang.badge,
                      style: TextStyle(
                        fontSize: context.rs(16.8),
                        height: 1.5,
                        color: AppColors.forest,
                      ),
                    ),
                  ),
                  SizedBox(height: context.rs(12)),
                  Text(
                    lang.name,
                    style: GoogleFonts.notoSansKr(
                      fontSize: context.rs(16),
                      height: 1.5,
                      fontWeight: FontWeight.w700,
                      letterSpacing: -0.16,
                      color: AppColors.ink,
                    ),
                  ),
                  SizedBox(height: context.rs(2)),
                  Text(
                    lang.native,
                    style: TextStyle(
                      fontSize: context.rs(13.12),
                      height: 1.5,
                      color: AppColors.stone,
                    ),
                  ),
                ],
              ),
              if (selected)
                Positioned(
                  top: 0,
                  right: 0,
                  child: Icon(Icons.check_circle,
                      color: AppColors.forest, size: context.rs(22)),
                ),
            ],
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
    await Get.find<ProfileService>().setProfile(language: _selected!);
    Get.toNamed(Routes.onboardingTextSize); // 글씨 크기(3/4)
  }
}
