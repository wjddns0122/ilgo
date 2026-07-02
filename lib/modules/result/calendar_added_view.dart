import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/responsive.dart';
import '../../core/theme.dart';

/// Calendar-added confirmation (Figma node 30:1456): deep-green celebration
/// with the created event card. Shown after "캘린더에 추가" succeeds.
class CalendarAddedView extends StatelessWidget {
  const CalendarAddedView({super.key});

  String _arg(String key, String fallback) {
    final args = Get.arguments;
    if (args is Map && args[key] is String && (args[key] as String).isNotEmpty) {
      return args[key] as String;
    }
    return fallback;
  }

  @override
  Widget build(BuildContext context) {
    final month = _arg('month', '8월');
    final day = _arg('day', '15');
    final title = _arg('title', '건강보험료 납부');
    final subtitle = _arg('subtitle', '6만 8천 원 · 오전 알림');

    return Scaffold(
      backgroundColor: AppColors.forest,
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: kOnbMaxWidth),
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                  context.rs(28), context.rs(24), context.rs(28), context.rs(24)),
              child: Column(
                children: [
                  const Spacer(flex: 2),
                  _checkBadge(context),
                  SizedBox(height: context.rs(20)),
                  Text(
                    '캘린더에\n넣었어요',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.notoSansKr(
                      fontSize: context.rs(35),
                      height: 1.35,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: context.rs(16)),
                  Text(
                    '기한을 잊지 않게\n하루 전에 알려드릴게요.',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.notoSansKr(
                      fontSize: context.rs(20),
                      height: 1.6,
                      color: const Color(0xFFB9D6C6),
                    ),
                  ),
                  SizedBox(height: context.rs(40)),
                  _eventCard(context, month, day, title, subtitle),
                  const Spacer(flex: 3),
                  _confirmButton(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _checkBadge(BuildContext context) {
    final s = context.rs(120);
    return Container(
      width: s,
      height: s,
      decoration: const BoxDecoration(
        color: Color(0xFF3B7A57),
        shape: BoxShape.circle,
      ),
      child: Icon(Icons.check_rounded, color: AppColors.forest, size: s * 0.5),
    );
  }

  Widget _eventCard(BuildContext context, String month, String day,
      String title, String subtitle) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(context.rs(24)),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(22),
      ),
      child: Row(
        children: [
          Container(
            width: context.rs(72),
            height: context.rs(82),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: const Color(0xFFE8F0EA),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  month,
                  style: GoogleFonts.notoSansKr(
                    fontSize: context.rs(15),
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFFB04A3A),
                  ),
                ),
                Text(
                  day,
                  style: GoogleFonts.notoSansKr(
                    fontSize: context.rs(30),
                    fontWeight: FontWeight.w700,
                    color: AppColors.forest,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: context.rs(20)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.notoSansKr(
                    fontSize: context.rs(21),
                    fontWeight: FontWeight.w700,
                    color: AppColors.ink,
                  ),
                ),
                SizedBox(height: context.rs(4)),
                Text(
                  subtitle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.notoSansKr(
                    fontSize: context.rs(17),
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

  Widget _confirmButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Material(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(10),
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: () => Get.back(),
          child: Container(
            height: context.rs(72),
            alignment: Alignment.center,
            child: Text(
              '확인',
              style: GoogleFonts.notoSansKr(
                fontSize: context.rs(20),
                fontWeight: FontWeight.w700,
                color: AppColors.forest,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
