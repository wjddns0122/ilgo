import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../core/app_routes.dart';
import '../core/responsive.dart';
import '../core/theme.dart';

/// Onboarding header: back button + tappable "n / total" stepper.
/// Reused across the 3 onboarding setup steps (Figma node 1:153). Responsive.
///
/// Tapping a step segment navigates to that step's screen. By default it maps
/// 1→mode, 2→language, 3→permission; pass [onStepTap] to override.
class OnbHeader extends StatelessWidget {
  const OnbHeader({
    super.key,
    required this.step,
    this.total = 3,
    this.onBack,
    this.onStepTap,
  });

  final int step;
  final int total;
  final VoidCallback? onBack;
  final void Function(int step)? onStepTap;

  void _handleStepTap(int target) {
    if (target == step) return; // already here
    if (onStepTap != null) {
      onStepTap!(target);
      return;
    }
    switch (target) {
      case 1:
        Get.toNamed(Routes.onboardingMode);
      case 2:
        Get.toNamed(Routes.onboardingLanguage);
      case 3:
        Get.toNamed(Routes.onboardingPermission);
    }
  }

  @override
  Widget build(BuildContext context) {
    final s = context.scale;
    return Padding(
      padding: EdgeInsets.fromLTRB(context.rs(28), context.rs(20), context.rs(28), context.rs(8)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: context.rs(22),
            height: context.rs(22),
            child: IconButton(
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
              iconSize: context.rs(22),
              icon: const Icon(Icons.arrow_back, color: AppColors.ink),
              onPressed: onBack,
            ),
          ),
          Row(
            children: [
              Text(
                '$step / $total',
                style: GoogleFonts.notoSansKr(
                  fontSize: context.rs(16),
                  color: AppColors.stone,
                ),
              ),
              SizedBox(width: context.rs(12)),
              Row(
                children: [
                  for (var i = 1; i <= total; i++) ...[
                    if (i > 1) SizedBox(width: context.rs(6)),
                    _pill(active: i == step, s: s, onTap: () => _handleStepTap(i)),
                  ],
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _pill({
    required bool active,
    required double s,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Padding(
        // Transparent vertical padding enlarges the tap target beyond the 4px pill.
        padding: EdgeInsets.symmetric(vertical: 10 * s),
        child: Container(
          width: (active ? 24 : 12) * s,
          height: 4 * s,
          decoration: BoxDecoration(
            color: active ? AppColors.forest : AppColors.hairline,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
      ),
    );
  }
}
