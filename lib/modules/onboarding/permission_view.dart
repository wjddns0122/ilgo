import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../core/app_routes.dart';
import '../../core/responsive.dart';
import '../../core/theme.dart';
import '../../data/services/profile_service.dart';
import '../../widgets/onb_header.dart';

/// Onboarding step 3/3 — camera + calendar permission request (Figma node 1:364).
/// Requesting is best-effort: permission can be granted later from 설정.
/// Responsive.
class OnboardingPermissionView extends StatelessWidget {
  const OnboardingPermissionView({super.key});

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
                OnbHeader(step: 4, total: 4, onBack: () => Get.back()),
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: context.rs(28)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: context.rs(24)),
                          Text(
                            '두 가지 권한을\n부탁드립니다.',
                            style: GoogleFonts.notoSansKr(
                              fontSize: context.rs(25.6),
                              height: 1.5,
                              fontWeight: FontWeight.w700,
                              letterSpacing: -0.256,
                              color: AppColors.ink,
                            ),
                          ),
                          SizedBox(height: context.rs(32)),
                          _permission(
                            context,
                            icon: Icons.photo_camera_outlined,
                            title: '카메라',
                            subtitle: '종이 고지서와 안내문을 찍기 위해 필요해요.',
                          ),
                          Container(height: 1, color: AppColors.hairline),
                          _permission(
                            context,
                            icon: Icons.calendar_month_outlined,
                            title: '캘린더',
                            subtitle: '납부·집합 같은 기한을 일정에 넣기 위해 필요해요.',
                          ),
                          SizedBox(height: context.rs(24)),
                          _privacyNote(context),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(
                      context.rs(28), context.rs(8), context.rs(28), context.rs(32)),
                  child: Column(
                    children: [
                      _primaryButton(context),
                      SizedBox(height: context.rs(8)),
                      _ghostButton(context),
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

  Widget _permission(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: context.rs(20)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: context.rs(26),
            child: Icon(icon, size: context.rs(26), color: AppColors.forest),
          ),
          SizedBox(width: context.rs(16)),
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
                    fontSize: context.rs(14.4),
                    height: 1.6,
                    color: AppColors.stone,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _privacyNote(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
          horizontal: context.rs(20), vertical: context.rs(16)),
      decoration: BoxDecoration(
        color: AppColors.sand,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        '마이크와 위치는 사용하지 않습니다. 사진은 이해를 위한 처리에만 쓰입니다.',
        style: GoogleFonts.notoSansKr(
          fontSize: context.rs(13.6),
          height: 1.6,
          color: AppColors.stone,
        ),
      ),
    );
  }

  Widget _primaryButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Material(
        color: AppColors.forest,
        borderRadius: BorderRadius.circular(8),
        child: InkWell(
          borderRadius: BorderRadius.circular(8),
          onTap: _allowAndStart,
          child: Padding(
            padding: EdgeInsets.symmetric(
                vertical: context.rs(16), horizontal: context.rs(24)),
            child: Center(
              child: Text(
                '허용하고 시작하기',
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

  Widget _ghostButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(8),
        child: InkWell(
          borderRadius: BorderRadius.circular(8),
          onTap: _finish,
          child: Padding(
            padding: EdgeInsets.symmetric(
                vertical: context.rs(14), horizontal: context.rs(24)),
            child: Center(
              child: Text(
                '나중에 할게요',
                style: GoogleFonts.notoSansKr(
                  fontSize: context.rs(16),
                  height: 1.5,
                  color: AppColors.stone,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _allowAndStart() async {
    // Best-effort: system dialogs appear here. Denial is non-blocking.
    await [Permission.camera, Permission.calendarWriteOnly].request();
    await _finish();
  }

  Future<void> _finish() async {
    await Get.find<ProfileService>().completeOnboarding();
    Get.offAllNamed(Routes.home);
  }
}
