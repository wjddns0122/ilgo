import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/app_routes.dart';
import '../../core/responsive.dart';
import '../../core/theme.dart';
import '../../data/services/profile_service.dart';
import '../../widgets/onb_header.dart';
import '../../widgets/text_size_picker.dart';

/// Onboarding step 3/4 — pick a comfortable text size, shown right after the
/// mode/language choice so 저문해·발달장애 users set a readable size before they
/// meet their first document. Reuses [TextSizePicker]; saves to
/// [ProfileService.textScale] (same key as settings) and moves to permissions.
class OnboardingTextSizeView extends StatefulWidget {
  const OnboardingTextSizeView({super.key});

  @override
  State<OnboardingTextSizeView> createState() => _OnboardingTextSizeViewState();
}

class _OnboardingTextSizeViewState extends State<OnboardingTextSizeView> {
  final ProfileService _profile = Get.find<ProfileService>();
  late double _scale = _profile.textScale.value;

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
                OnbHeader(step: 3, total: 4, onBack: () => Get.back()),
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: context.rs(28)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: context.rs(24)),
                          Text(
                            '글씨 크기를 정해요.',
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
                            '편하게 읽을 수 있는 크기로 맞춰요. 설정에서 언제든 바꿀 수 있어요.',
                            style: GoogleFonts.notoSansKr(
                              fontSize: context.rs(16),
                              height: 1.6,
                              color: AppColors.stone,
                            ),
                          ),
                          SizedBox(height: context.rs(28)),
                          TextSizePicker(
                            initialScale: _profile.textScale.value,
                            onChanged: (s) => _scale = s,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(context.rs(28), context.rs(20),
                      context.rs(28), context.rs(32)),
                  child: _nextButton(context),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _nextButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Material(
        color: AppColors.forest,
        borderRadius: BorderRadius.circular(8),
        child: InkWell(
          borderRadius: BorderRadius.circular(8),
          onTap: _next,
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
    await _profile.setTextScale(_scale);
    Get.toNamed(Routes.onboardingPermission);
  }
}
