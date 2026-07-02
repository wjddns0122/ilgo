import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/responsive.dart';
import '../../core/theme.dart';
import 'analyze_controller.dart';

/// Edge-case screen (Figma node 30:1262): network/connectivity failure during
/// analysis. The captured photo is kept, so "다시 시도" re-runs the last request.
class ConnectionFailedView extends StatelessWidget {
  const ConnectionFailedView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.paper,
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: kOnbMaxWidth),
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                  context.rs(28), context.rs(24), context.rs(28), context.rs(24)),
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(height: context.rs(40)),
                          _badge(context),
                          SizedBox(height: context.rs(20)),
                          Text(
                            '잠시 연결이\n끊겼어요',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.notoSansKr(
                              fontSize: context.rs(31),
                              height: 1.35,
                              fontWeight: FontWeight.w700,
                              color: AppColors.ink,
                            ),
                          ),
                          SizedBox(height: context.rs(16)),
                          Text(
                            '인터넷을 확인하고\n다시 시도해주세요.',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.notoSansKr(
                              fontSize: context.rs(18),
                              height: 1.6,
                              color: AppColors.stone,
                            ),
                          ),
                          SizedBox(height: context.rs(28)),
                          _safeNote(context),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: context.rs(16)),
                  _retryButton(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _badge(BuildContext context) {
    final s = context.rs(112);
    return Container(
      width: s,
      height: s,
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        color: Color(0xFFF0DDD8), // soft blush
        shape: BoxShape.circle,
      ),
      child: Icon(Icons.wifi_off_rounded, size: context.rs(52), color: AppColors.ink),
    );
  }

  Widget _safeNote(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
          horizontal: context.rs(24), vertical: context.rs(20)),
      decoration: BoxDecoration(
        color: const Color(0xFFE8F0EA),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFCBDCCF)),
      ),
      child: Row(
        children: [
          Icon(Icons.inventory_2_outlined,
              size: context.rs(28), color: AppColors.forest),
          SizedBox(width: context.rs(16)),
          Expanded(
            child: Text(
              '찍은 사진은 안전하게\n보관되어 있어요.',
              style: GoogleFonts.notoSansKr(
                fontSize: context.rs(18),
                height: 1.4,
                fontWeight: FontWeight.w600,
                color: AppColors.forest,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _retryButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Material(
        color: AppColors.forest,
        borderRadius: BorderRadius.circular(10),
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: () => Get.find<AnalyzeController>().retry(),
          child: Container(
            height: context.rs(72),
            alignment: Alignment.center,
            child: Text(
              '다시 시도',
              style: GoogleFonts.notoSansKr(
                fontSize: context.rs(20),
                fontWeight: FontWeight.w700,
                color: AppColors.paper,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
