import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/deadline.dart';
import '../../core/responsive.dart';
import '../../core/theme.dart';
import '../../data/models/analysis_summary.dart';

/// In-app "기한 알림" (설정 토글로 켜고 끔): analyses due within a week,
/// shown once per app session when home opens. Tapping a row opens it.
class DeadlineAlertDialog extends StatelessWidget {
  const DeadlineAlertDialog({
    super.key,
    required this.items,
    required this.onOpen,
  });

  final List<AnalysisSummary> items;
  final void Function(String id) onOpen;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.paper,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: EdgeInsets.all(context.rs(24)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.notifications_active_outlined,
                  size: context.rs(24),
                  color: AppColors.forest,
                ),
                SizedBox(width: context.rs(10)),
                Text(
                  '기한이 다가와요',
                  style: GoogleFonts.notoSansKr(
                    fontSize: context.rs(20),
                    fontWeight: FontWeight.w700,
                    color: AppColors.ink,
                  ),
                ),
              ],
            ),
            SizedBox(height: context.rs(16)),
            for (final item in items) _row(context, item),
            SizedBox(height: context.rs(16)),
            SizedBox(
              width: double.infinity,
              child: Material(
                color: AppColors.forest,
                borderRadius: BorderRadius.circular(10),
                child: InkWell(
                  borderRadius: BorderRadius.circular(10),
                  onTap: () => Navigator.of(context).pop(),
                  child: Container(
                    height: context.rs(56),
                    alignment: Alignment.center,
                    child: Text(
                      '확인',
                      style: GoogleFonts.notoSansKr(
                        fontSize: context.rs(18),
                        fontWeight: FontWeight.w700,
                        color: AppColors.paper,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _row(BuildContext context, AnalysisSummary item) {
    final label = Deadline.dDayLabel(item.cardDeadline) ?? '';
    final urgent = Deadline.isUrgent(item.cardDeadline, within: 3);
    return InkWell(
      onTap: () => onOpen(item.id),
      borderRadius: BorderRadius.circular(10),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: context.rs(10)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: context.rs(10),
                vertical: context.rs(3),
              ),
              decoration: BoxDecoration(
                color: urgent ? AppColors.riskRedBg : AppColors.sand,
                borderRadius: BorderRadius.circular(999),
              ),
              child: Text(
                label,
                style: GoogleFonts.notoSansKr(
                  fontSize: context.rs(13),
                  fontWeight: FontWeight.w700,
                  color: urgent ? AppColors.riskRed : AppColors.forest,
                ),
              ),
            ),
            SizedBox(width: context.rs(12)),
            Expanded(
              child: Text(
                item.summaryOneLine ?? '',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.notoSansKr(
                  fontSize: context.rs(15),
                  height: 1.5,
                  color: AppColors.ink,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
