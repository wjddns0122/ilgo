import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/responsive.dart';
import '../../core/theme.dart';
import 'analyze_controller.dart';

/// Analyzing / loading screen (Figma node 1:583).
/// Cycles through 4 phases with a pulsing badge + animated transitions while
/// the analysis runs. The controller replaces this route with the result on
/// success; on error we show a retry view.
class AnalyzeView extends StatefulWidget {
  const AnalyzeView({super.key});

  @override
  State<AnalyzeView> createState() => _AnalyzeViewState();
}

class _AnalyzePhase {
  const _AnalyzePhase(this.icon, this.label);
  final IconData icon;
  final String label;
}

const _phases = <_AnalyzePhase>[
  _AnalyzePhase(Icons.description_outlined, '글자를 읽고 있어요'),
  _AnalyzePhase(Icons.menu_book_outlined, '뜻을 풀고 있어요'),
  _AnalyzePhase(Icons.shield_outlined, '위험을 살피고 있어요'),
  _AnalyzePhase(Icons.checklist_rtl, '할 일을 정리하고 있어요'),
];

class _AnalyzeViewState extends State<AnalyzeView>
    with TickerProviderStateMixin {
  final AnalyzeController controller = Get.find<AnalyzeController>();

  int _step = 0;
  Timer? _timer;
  late final AnimationController _pulse;
  late final AnimationController _spark;

  @override
  void initState() {
    super.initState();
    _pulse = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1800))
      ..repeat();
    _spark = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 2800))
      ..repeat();
    _startCycling();
  }

  void _startCycling() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(milliseconds: 900), (t) {
      if (!mounted) return;
      if (controller.error.value != null) {
        t.cancel();
        _timer = null;
        return;
      }
      setState(() => _step = (_step + 1) % _phases.length);
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pulse.dispose();
    _spark.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.paper,
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: kOnbMaxWidth),
            child: Obx(() => controller.error.value != null
                ? _error(context, controller.error.value!)
                : _loading(context)),
          ),
        ),
      ),
    );
  }

  Widget _loading(BuildContext context) {
    final phase = _phases[_step];
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: context.rs(28)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _badge(context, phase.icon),
          SizedBox(height: context.rs(40)),
          Text(
            '읽고가 읽고 있어요',
            style: GoogleFonts.notoSansKr(
              fontSize: context.rs(22.4),
              height: 1.5,
              fontWeight: FontWeight.w700,
              letterSpacing: -0.224,
              color: AppColors.ink,
            ),
          ),
          SizedBox(height: context.rs(24)),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 400),
            transitionBuilder: (child, anim) => FadeTransition(
              opacity: anim,
              child: SlideTransition(
                position: Tween(
                        begin: const Offset(0, 0.4), end: Offset.zero)
                    .animate(anim),
                child: child,
              ),
            ),
            child: Text(
              phase.label,
              key: ValueKey(_step),
              textAlign: TextAlign.center,
              style: GoogleFonts.notoSansKr(
                fontSize: context.rs(16),
                height: 1.5,
                color: AppColors.stone,
              ),
            ),
          ),
          SizedBox(height: context.rs(24)),
          _progressPills(context),
        ],
      ),
    );
  }

  Widget _badge(BuildContext context, IconData icon) {
    final ring = context.rs(150);
    final circle = context.rs(112);
    return SizedBox(
      width: context.rs(160),
      height: context.rs(160),
      child: Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.none,
        children: [
          // Static outer ring.
          Container(
            width: ring,
            height: ring,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.hairline),
            ),
          ),
          // Expanding + fading pulse ring.
          AnimatedBuilder(
            animation: _pulse,
            builder: (_, _) {
              final t = _pulse.value; // 0..1
              return Transform.scale(
                scale: 1 + t * 0.35,
                child: Opacity(
                  opacity: (1 - t) * 0.5,
                  child: Container(
                    width: circle,
                    height: circle,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.forest),
                    ),
                  ),
                ),
              );
            },
          ),
          // Center circle with the phase icon.
          Container(
            width: circle,
            height: circle,
            decoration: const BoxDecoration(
              color: AppColors.sand,
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 400),
              transitionBuilder: (child, anim) => FadeTransition(
                opacity: anim,
                child: ScaleTransition(scale: anim, child: child),
              ),
              child: Icon(
                icon,
                key: ValueKey(_step),
                size: context.rs(44),
                color: AppColors.forest,
              ),
            ),
          ),
          // Twinkling sparkle, top-right.
          Positioned(
            top: context.rs(2),
            right: context.rs(6),
            child: ScaleTransition(
              scale: Tween(begin: 0.7, end: 1.1).animate(
                CurvedAnimation(parent: _spark, curve: Curves.easeInOut),
              ),
              child: RotationTransition(
                turns: Tween(begin: -0.04, end: 0.04).animate(
                  CurvedAnimation(parent: _spark, curve: Curves.easeInOut),
                ),
                child: Icon(Icons.auto_awesome,
                    size: context.rs(30), color: AppColors.forest),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _progressPills(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (var i = 0; i < _phases.length; i++) ...[
          if (i > 0) SizedBox(width: context.rs(6)),
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
            width: (i == _step ? 22 : 8) * context.scale,
            height: context.rs(6),
            decoration: BoxDecoration(
              color: i == _step ? AppColors.forest : AppColors.hairline,
              borderRadius: BorderRadius.circular(999),
            ),
          ),
        ],
      ],
    );
  }

  Widget _error(BuildContext context, String message) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: context.rs(28)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline,
              size: context.rs(72), color: AppColors.riskRed),
          SizedBox(height: context.rs(20)),
          Text(
            message,
            textAlign: TextAlign.center,
            style: GoogleFonts.notoSansKr(
              fontSize: context.rs(20),
              height: 1.5,
              fontWeight: FontWeight.w700,
              color: AppColors.ink,
            ),
          ),
          SizedBox(height: context.rs(32)),
          SizedBox(
            width: double.infinity,
            child: Material(
              color: AppColors.forest,
              borderRadius: BorderRadius.circular(8),
              child: InkWell(
                borderRadius: BorderRadius.circular(8),
                onTap: () {
                  setState(() => _step = 0);
                  _startCycling();
                  controller.retry();
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: context.rs(16), horizontal: context.rs(24)),
                  child: Center(
                    child: Text(
                      '다시 시도',
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
          ),
          SizedBox(height: context.rs(8)),
          SizedBox(
            width: double.infinity,
            child: Material(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(8),
              child: InkWell(
                borderRadius: BorderRadius.circular(8),
                onTap: () => Get.back(),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: context.rs(14), horizontal: context.rs(24)),
                  child: Center(
                    child: Text(
                      '돌아가기',
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
          ),
        ],
      ),
    );
  }
}
