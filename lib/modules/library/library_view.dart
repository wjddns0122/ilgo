import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/deadline.dart';
import '../../core/responsive.dart';
import '../../core/theme.dart';
import '../../data/models/analysis_summary.dart';
import 'library_controller.dart';

/// Archive / library screen (Figma node 1:1333). Saved analyses sorted by
/// upcoming deadline, with a traffic-light dot and deadline chip.
class LibraryView extends GetView<LibraryController> {
  const LibraryView({super.key});

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
                _header(context),
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: context.rs(28)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: context.rs(24)),
                          Text(
                            '지금까지 읽어드린 글이에요. 다가오는 기한 순서로 보여드려요.',
                            style: GoogleFonts.notoSansKr(
                              fontSize: context.rs(16),
                              height: 1.5,
                              color: AppColors.stone,
                            ),
                          ),
                          SizedBox(height: context.rs(24)),
                          _body(context),
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
    return Padding(
      padding: EdgeInsets.fromLTRB(
        context.rs(15),
        context.rs(15),
        context.rs(28),
        context.rs(8),
      ),
      child: Row(
        children: [
          SizedBox(
            width: context.rs(22),
            height: context.rs(22),
            child: IconButton(
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
              iconSize: context.rs(22),
              icon: const Icon(Icons.arrow_back, color: AppColors.ink),
              onPressed: () => Get.back(),
            ),
          ),
          SizedBox(width: context.rs(16)),
          Text(
            '내 보관함',
            style: GoogleFonts.notoSansKr(
              fontSize: context.rs(18.4),
              height: 1.5,
              fontWeight: FontWeight.w700,
              letterSpacing: -0.184,
              color: AppColors.forest,
            ),
          ),
        ],
      ),
    );
  }

  Widget _body(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) {
        return Padding(
          padding: EdgeInsets.only(top: context.rs(40)),
          child: const Center(child: CircularProgressIndicator()),
        );
      }
      if (controller.error.value != null) {
        return Padding(
          padding: EdgeInsets.only(top: context.rs(40)),
          child: Center(
            child: Text(
              controller.error.value!,
              style: GoogleFonts.notoSansKr(
                fontSize: context.rs(15),
                color: AppColors.stone,
              ),
            ),
          ),
        );
      }
      final items = controller.items;
      if (items.isEmpty) {
        return Padding(
          padding: EdgeInsets.only(top: context.rs(40)),
          child: Center(
            child: Text(
              '아직 보관된 글이 없어요.',
              style: GoogleFonts.notoSansKr(
                fontSize: context.rs(16),
                color: AppColors.stone,
              ),
            ),
          ),
        );
      }
      return Column(
        children: [
          Container(height: 1, color: AppColors.hairline),
          for (final item in items) ...[
            _dismissibleRow(context, item),
            Container(height: 1, color: AppColors.hairline),
          ],
        ],
      );
    });
  }

  /// Swipe-left to delete a saved analysis (with a confirm dialog).
  Widget _dismissibleRow(BuildContext context, AnalysisSummary item) {
    return Dismissible(
      key: ValueKey(item.id),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        color: AppColors.riskRedBg,
        padding: EdgeInsets.only(right: context.rs(24)),
        child: Icon(Icons.delete_outline,
            color: AppColors.riskRed, size: context.rs(26)),
      ),
      confirmDismiss: (_) => _confirmDelete(context),
      onDismissed: (_) => controller.remove(item.id),
      child: _ArchiveRow(summary: item, onTap: () => controller.open(item.id)),
    );
  }

  Future<bool> _confirmDelete(BuildContext context) async {
    final ok = await Get.dialog<bool>(
      AlertDialog(
        backgroundColor: AppColors.paper,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(
          '이 기록을 지울까요?',
          style: GoogleFonts.notoSansKr(
            fontSize: context.rs(19),
            fontWeight: FontWeight.w700,
            color: AppColors.ink,
          ),
        ),
        content: Text(
          '지우면 되돌릴 수 없어요.',
          style: GoogleFonts.notoSansKr(
            fontSize: context.rs(16),
            height: 1.5,
            color: AppColors.stone,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(result: false),
            child: Text(
              '취소',
              style: GoogleFonts.notoSansKr(
                fontSize: context.rs(16),
                fontWeight: FontWeight.w600,
                color: AppColors.stone,
              ),
            ),
          ),
          TextButton(
            onPressed: () => Get.back(result: true),
            child: Text(
              '지우기',
              style: GoogleFonts.notoSansKr(
                fontSize: context.rs(16),
                fontWeight: FontWeight.w700,
                color: AppColors.riskRed,
              ),
            ),
          ),
        ],
      ),
    );
    return ok ?? false;
  }
}

/// One archive row: signal dot + type·date + deadline chip + summary + arrow.
class _ArchiveRow extends StatelessWidget {
  const _ArchiveRow({required this.summary, required this.onTap});

  final AnalysisSummary summary;
  final VoidCallback onTap;

  Color _dotColor(String? level) {
    switch (level) {
      case 'red':
        return const Color(0xFFB04A3A);
      case 'yellow':
        return AppColors.riskYellow;
      default:
        return const Color(0xFF3B7A57);
    }
  }

  IconData _docIcon() => summary.docType == '메시지'
      ? Icons.image_outlined
      : Icons.description_outlined;

  String _metaLine() {
    final type = summary.docType ?? '기록';
    final d = DateTime.tryParse(summary.createdAt)?.toLocal();
    if (d == null) return type;
    return '$type · ${d.month}월 ${d.day}일';
  }

  String? _deadlineLabel() {
    final raw = summary.cardDeadline;
    if (raw == null || raw.isEmpty) return null;
    final d = DateTime.tryParse(raw);
    if (d == null) return null;
    final base = '${d.year}년 ${d.month}월 ${d.day}일까지';
    final dday = Deadline.dDayLabel(raw);
    return dday == null ? base : '$dday · $base';
  }

  @override
  Widget build(BuildContext context) {
    final deadline = _deadlineLabel();
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
                _docIcon(),
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
                      Flexible(
                        child: Text(
                          _metaLine(),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.notoSansKr(
                            fontSize: context.rs(12.8),
                            color: AppColors.stone,
                          ),
                        ),
                      ),
                      if (deadline != null) ...[
                        SizedBox(width: context.rs(8)),
                        Expanded(
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: _deadlineChip(context, deadline),
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

  Widget _deadlineChip(BuildContext context, String label) {
    final urgent = Deadline.isUrgent(summary.cardDeadline);
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: context.rs(10),
        vertical: context.rs(2),
      ),
      decoration: BoxDecoration(
        color: urgent ? AppColors.riskRedBg : AppColors.sand,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        label,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: GoogleFonts.notoSansKr(
          fontSize: context.rs(11.52),
          fontWeight: urgent ? FontWeight.w700 : FontWeight.w400,
          color: urgent ? AppColors.riskRed : AppColors.forest,
        ),
      ),
    );
  }
}
