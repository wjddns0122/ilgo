import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/app_routes.dart';
import '../../core/deadline.dart';
import '../../core/responsive.dart';
import '../../core/theme.dart';
import '../../data/models/analysis_summary.dart';
import '../../data/models/tobagi.dart';
import '../../widgets/tobagi_image.dart';
import 'home_controller.dart';

/// Main screen (Figma node 1:2095): capture actions + recent records.
class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

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
                Obx(
                  () => AnimatedSize(
                    duration: const Duration(milliseconds: 220),
                    curve: Curves.easeOut,
                    alignment: Alignment.topCenter,
                    child: controller.headerVisible.value
                        ? _header(context)
                        : const SizedBox(width: double.infinity),
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    controller: controller.scrollController,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: context.rs(28)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '무엇을 읽어드릴까요?',
                            style: GoogleFonts.notoSansKr(
                              fontSize: context.rs(27.2),
                              height: 1.5,
                              fontWeight: FontWeight.w700,
                              letterSpacing: -0.272,
                              color: AppColors.ink,
                            ),
                          ),
                          SizedBox(height: context.rs(12)),
                          Text(
                            '쉽게 알고 싶은 글을 사진으로 담아주세요.',
                            style: GoogleFonts.notoSansKr(
                              fontSize: context.rs(16),
                              color: AppColors.stone,
                            ),
                          ),
                          SizedBox(height: context.rs(24)),
                          Row(
                            children: [
                              const TobagiImage(tobagiPhotoAsset, size: 64),
                              SizedBox(width: context.rs(12)),
                              Expanded(
                                child: Text(
                                  '오늘도 어려운 글 있으면 나한테 찍어줘.',
                                  style: GoogleFonts.notoSansKr(
                                    fontSize: context.rs(15),
                                    height: 1.5,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.forest,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: context.rs(24)),
                          _ActionCard(
                            icon: Icons.photo_camera_outlined,
                            title: '종이 찍기',
                            subtitle: '고지서 · 안내문 촬영',
                            onTap: () => Get.toNamed(Routes.camera),
                          ),
                          SizedBox(height: context.rs(16)),
                          _ActionCard(
                            icon: Icons.image_outlined,
                            title: '화면 캡처 넣기',
                            subtitle: '카톡 · 문자 · 공지 캡처',
                            onTap: controller.fromGallery,
                          ),
                          SizedBox(height: context.rs(40)),
                          _recentHeader(context),
                          SizedBox(height: context.rs(16)),
                          Container(height: 1, color: AppColors.hairline),
                          _recentList(context),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _header(BuildContext context) {
    final now = DateTime.now();
    return Padding(
      padding: EdgeInsets.fromLTRB(
        context.rs(28),
        context.rs(15),
        context.rs(28),
        context.rs(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '읽고 · ${now.month}월 ${now.day}일',
            style: GoogleFonts.notoSansKr(
              fontSize: context.rs(18.4),
              height: 1.5,
              fontWeight: FontWeight.w700,
              letterSpacing: -0.184,
              color: AppColors.forest,
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                iconSize: context.rs(24),
                icon: const Icon(Icons.settings_outlined, color: AppColors.ink),
                tooltip: '설정',
                onPressed: () => Get.toNamed(Routes.settings),
              ),
              SizedBox(width: context.rs(16)),
              IconButton(
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                iconSize: context.rs(24),
                icon: const Icon(
                  Icons.inventory_2_outlined,
                  color: AppColors.ink,
                ),
                tooltip: '보관함',
                onPressed: () => Get.toNamed(Routes.library),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _recentHeader(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.history, size: context.rs(18), color: AppColors.stone),
        SizedBox(width: context.rs(8)),
        Text(
          '최근 기록',
          style: GoogleFonts.notoSansKr(
            fontSize: context.rs(13.12),
            letterSpacing: 0.26,
            color: AppColors.stone,
          ),
        ),
      ],
    );
  }

  Widget _recentList(BuildContext context) {
    return Obx(() {
      final items = controller.recent;
      if (items.isEmpty) {
        return Padding(
          padding: EdgeInsets.symmetric(vertical: context.rs(20)),
          child: Text(
            '아직 기록이 없어요.',
            style: GoogleFonts.notoSansKr(
              fontSize: context.rs(14),
              color: AppColors.stone,
            ),
          ),
        );
      }
      return Column(
        children: [
          for (final item in items) ...[
            _RecentRow(
              summary: item,
              onTap: () => controller.openRecord(item.id),
            ),
            Container(height: 1, color: AppColors.hairline),
          ],
        ],
      );
    });
  }
}

/// A large primary action card (종이 찍기 / 화면 캡처 넣기).
class _ActionCard extends StatelessWidget {
  const _ActionCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
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
          padding: EdgeInsets.all(context.rs(25)),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppColors.hairline),
          ),
          child: Row(
            children: [
              Icon(icon, size: context.rs(30), color: AppColors.forest),
              SizedBox(width: context.rs(20)),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: GoogleFonts.notoSansKr(
                        fontSize: context.rs(16.8),
                        height: 1.5,
                        fontWeight: FontWeight.w700,
                        letterSpacing: -0.168,
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
              SizedBox(width: context.rs(12)),
              Icon(
                Icons.arrow_forward,
                size: context.rs(20),
                color: AppColors.stone,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// One "최근 기록" row.
class _RecentRow extends StatelessWidget {
  const _RecentRow({required this.summary, required this.onTap});

  final AnalysisSummary summary;
  final VoidCallback onTap;

  Color _dotColor(String? level) {
    switch (level) {
      case 'red':
        return AppColors.riskRed;
      case 'yellow':
        return AppColors.riskYellow;
      default:
        return const Color(0xFF3B7A57);
    }
  }

  String _metaLine() {
    final type = summary.docType ?? '기록';
    final d = DateTime.tryParse(summary.createdAt)?.toLocal();
    if (d == null) return type;
    return '$type · ${d.month}월 ${d.day}일';
  }

  @override
  Widget build(BuildContext context) {
    final dLabel = Deadline.dDayLabel(summary.cardDeadline);
    final urgent = Deadline.isUrgent(summary.cardDeadline);
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: context.rs(20)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(top: context.rs(2)),
              child: Icon(
                Icons.description_outlined,
                size: context.rs(24),
                color: AppColors.stone,
              ),
            ),
            SizedBox(width: context.rs(16)),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: context.rs(12),
                        height: context.rs(12),
                        decoration: BoxDecoration(
                          color: _dotColor(summary.topRiskLevel),
                          shape: BoxShape.circle,
                        ),
                      ),
                      SizedBox(width: context.rs(8)),
                      Text(
                        _metaLine(),
                        style: GoogleFonts.notoSansKr(
                          fontSize: context.rs(12.8),
                          color: AppColors.stone,
                        ),
                      ),
                      if (dLabel != null) ...[
                        SizedBox(width: context.rs(8)),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: context.rs(8),
                            vertical: context.rs(1),
                          ),
                          decoration: BoxDecoration(
                            color: urgent
                                ? AppColors.riskRedBg
                                : AppColors.sand,
                            borderRadius: BorderRadius.circular(999),
                          ),
                          child: Text(
                            dLabel,
                            style: GoogleFonts.notoSansKr(
                              fontSize: context.rs(11.5),
                              fontWeight: FontWeight.w700,
                              color: urgent
                                  ? AppColors.riskRed
                                  : AppColors.forest,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                  SizedBox(height: context.rs(6)),
                  Text(
                    summary.summaryOneLine ?? '',
                    style: GoogleFonts.notoSansKr(
                      fontSize: context.rs(16),
                      height: 1.5,
                      color: AppColors.ink,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: context.rs(12)),
            Padding(
              padding: EdgeInsets.only(top: context.rs(4)),
              child: Icon(
                Icons.arrow_forward,
                size: context.rs(18),
                color: AppColors.stone,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
