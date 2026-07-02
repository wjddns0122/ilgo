import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/app_routes.dart';
import '../../core/responsive.dart';
import '../../core/theme.dart';

/// Risk detail (Figma node 30:1592): explains *why* a risk was flagged
/// green/yellow/red, with step-by-step guidance.
///
/// The long explanation + steps will be supplied by the backend later. For now
/// we render the risk message + the analysis to-dos, with TODOs where the
/// richer content will plug in.
class RiskDetailView extends StatelessWidget {
  const RiskDetailView({super.key});

  ({Color color, String label}) _look(String level) {
    switch (level) {
      case 'green':
        return (color: const Color(0xFF3B7A57), label: '안심');
      case 'yellow':
        return (color: const Color(0xFFC0902A), label: '주의');
      default:
        return (color: const Color(0xFFB04A3A), label: '위험');
    }
  }

  @override
  Widget build(BuildContext context) {
    final args = Get.arguments;
    final level = (args is Map && args['level'] is String) ? args['level'] as String : 'yellow';
    final type = (args is Map && args['type'] is String) ? args['type'] as String : '';
    final message = (args is Map && args['message'] is String) ? args['message'] as String : '';
    final steps = (args is Map && args['steps'] is List)
        ? List<String>.from(args['steps'] as List)
        : <String>[];
    final detail = (args is Map && args['detail'] is String)
        ? args['detail'] as String
        : '';
    final body = detail.isNotEmpty ? detail : message;
    final look = _look(level);

    return Scaffold(
      backgroundColor: AppColors.paper,
      body: Column(
        children: [
          _header(context, look, type, message),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.fromLTRB(
                    context.rs(28), context.rs(24), context.rs(28), context.rs(24)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      body.isEmpty ? '자세한 설명을 준비하고 있어요.' : body,
                      style: GoogleFonts.notoSansKr(
                        fontSize: context.rs(20),
                        height: 1.65,
                        color: AppColors.ink,
                      ),
                    ),
                    if (steps.isNotEmpty) ...[
                      SizedBox(height: context.rs(24)),
                      Text(
                        '이럴 때 이렇게 하세요',
                        style: GoogleFonts.notoSansKr(
                          fontSize: context.rs(16),
                          fontWeight: FontWeight.w700,
                          color: AppColors.stone,
                        ),
                      ),
                      SizedBox(height: context.rs(16)),
                      for (var i = 0; i < steps.length; i++)
                        _step(context, i + 1, steps[i]),
                    ],
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(
                context.rs(28), context.rs(8), context.rs(28), context.rs(24)),
            child: _helpButton(context),
          ),
        ],
      ),
    );
  }

  Widget _header(BuildContext context, ({Color color, String label}) look,
      String type, String message) {
    final chipLabel = type.isEmpty ? look.label : '${look.label} · $type';
    return Container(
      width: double.infinity,
      color: look.color,
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: EdgeInsets.fromLTRB(
              context.rs(24), context.rs(12), context.rs(28), context.rs(28)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  SizedBox(
                    width: context.rs(28),
                    height: context.rs(28),
                    child: IconButton(
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                      iconSize: context.rs(24),
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () => Get.back(),
                    ),
                  ),
                  SizedBox(width: context.rs(12)),
                  _chip(context, chipLabel),
                ],
              ),
              SizedBox(height: context.rs(20)),
              Text(
                message.isEmpty ? '위험을 살펴봤어요' : message,
                style: GoogleFonts.notoSansKr(
                  fontSize: context.rs(30),
                  height: 1.4,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _chip(BuildContext context, String label) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: context.rs(14), vertical: context.rs(5)),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: context.rs(12),
            height: context.rs(12),
            decoration:
                const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
          ),
          SizedBox(width: context.rs(9)),
          Text(
            label,
            style: GoogleFonts.notoSansKr(
              fontSize: context.rs(17),
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _step(BuildContext context, int n, String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: context.rs(16)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: context.rs(32),
            height: context.rs(32),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: AppColors.forest,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Text(
              '$n',
              style: GoogleFonts.notoSansKr(
                fontSize: context.rs(17),
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(width: context.rs(16)),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(top: context.rs(2)),
              child: Text(
                text,
                style: GoogleFonts.notoSansKr(
                  fontSize: context.rs(19),
                  height: 1.5,
                  color: AppColors.ink,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _helpButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Material(
        color: AppColors.forest,
        borderRadius: BorderRadius.circular(10),
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: () => Get.toNamed(Routes.help),
          child: Container(
            height: context.rs(72),
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.call, size: context.rs(22), color: Colors.white),
                SizedBox(width: context.rs(10)),
                Text(
                  '도움받을 곳 보기',
                  style: GoogleFonts.notoSansKr(
                    fontSize: context.rs(20),
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

}
