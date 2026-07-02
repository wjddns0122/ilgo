import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/app_routes.dart';
import '../../core/responsive.dart';
import '../../core/theme.dart';

/// First-run intro screen. Implemented from Figma (file vQjZTBlx…, node 1:55):
/// cream paper background, deep-green brand, three feature rows, one CTA.
/// Responsive: content capped at [kOnbMaxWidth] and scaled on narrow phones.
class OnboardingView extends StatelessWidget {
  const OnboardingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.paper,
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: kOnbMaxWidth),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: context.rs(28)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: context.rs(10)),
                          _brand(context),
                          SizedBox(height: context.rs(32)),
                          _heading(context),
                          SizedBox(height: context.rs(16)),
                          Text(
                            '고지서·안내문·메시지를 사진 한 장으로 찍으면, 당신이 읽을 수 있는 말로 풀어 요약해 드려요.',
                            style: GoogleFonts.notoSansKr(
                              fontSize: context.rs(16),
                              height: 1.7,
                              color: AppColors.stone,
                            ),
                          ),
                          SizedBox(height: context.rs(32)),
                          Container(height: 1, color: AppColors.hairline),
                          SizedBox(height: context.rs(32)),
                          _feature(
                            context,
                            icon: Icons.auto_awesome,
                            title: '핵심을 한 문장으로',
                            subtitle: '긴 글을 읽기 쉬운 한 마디로 풀어드려요.',
                          ),
                          SizedBox(height: context.rs(24)),
                          _feature(
                            context,
                            icon: Icons.shield_outlined,
                            title: '위험은 신호등으로',
                            subtitle: '사기·기한·부당한 요구를 색으로 알려드려요.',
                          ),
                          SizedBox(height: context.rs(24)),
                          _feature(
                            context,
                            icon: Icons.check_rounded,
                            title: '할 일을 차례대로',
                            subtitle: '무엇을 해야 하는지 순서대로 정리해드려요.',
                          ),
                          SizedBox(height: context.rs(24)),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: context.rs(8)),
                  _startButton(context),
                  SizedBox(height: context.rs(32)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _brand(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: [
        Text(
          '읽고',
          style: GoogleFonts.notoSansKr(
            fontSize: context.rs(21.6),
            fontWeight: FontWeight.w700,
            letterSpacing: -0.216,
            color: AppColors.forest,
          ),
        ),
        SizedBox(width: context.rs(10)),
        Text(
          'ILGEO',
          style: GoogleFonts.notoSansKr(
            fontSize: context.rs(11.2),
            letterSpacing: 2.8,
            color: AppColors.stone,
          ),
        ),
        SizedBox(width: context.rs(8)),
        Text(
          '· 읽기 도우미',
          style: GoogleFonts.notoSansKr(
            fontSize: context.rs(11.5),
            color: AppColors.stone,
          ),
        ),
      ],
    );
  }

  Widget _heading(BuildContext context) {
    return Text(
      '어려운 한 통의 편지를,\n쉬운 한 마디로.',
      style: GoogleFonts.notoSansKr(
        fontSize: context.rs(30.4),
        height: 1.4,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.304,
        color: AppColors.ink,
      ),
    );
  }

  Widget _feature(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: context.rs(26),
          child: Icon(icon, size: context.rs(24), color: AppColors.forest),
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
    );
  }

  Widget _startButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Material(
        color: AppColors.forest,
        borderRadius: BorderRadius.circular(8),
        child: InkWell(
          borderRadius: BorderRadius.circular(8),
          onTap: _start,
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: context.rs(16),
              horizontal: context.rs(24),
            ),
            child: Center(
              child: Text(
                '시작하기',
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

  // Intro CTA → mode selection (온보딩 1/3). 프로필 저장·완료는 모드 화면에서.
  void _start() => Get.toNamed(Routes.onboardingMode);
}
