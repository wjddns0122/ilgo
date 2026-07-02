import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../core/app_routes.dart';
import '../../core/help_recommend.dart';
import '../../core/responsive.dart';
import '../../core/theme.dart';
import '../../data/models/tobagi.dart';
import '../../widgets/tobagi_image.dart';

/// Risk detail (Figma node 30:1592): explains *why* a risk was flagged
/// green/yellow/red, with step-by-step guidance and help CTAs.
///
/// Help is shown in two tiers ([recommendedHelp]):
///  - ① 지금 확인 — verify before acting (e.g. 사기 → 118, 임금 → 1350).
///  - ② 벌써 당했다면 — collapsible; if already harmed, report + freeze payment
///    + relief channels (e.g. 112 · 1332 · 132). Guidance tone only.
class RiskDetailView extends StatefulWidget {
  const RiskDetailView({super.key});

  @override
  State<RiskDetailView> createState() => _RiskDetailViewState();
}

class _RiskDetailViewState extends State<RiskDetailView> {
  bool _victimExpanded = false;

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

  /// Dial a number (opens the phone app with it pre-filled — never auto-calls).
  Future<void> _dial(String raw) async {
    final digits = raw.replaceAll(RegExp(r'[^0-9+]'), '');
    if (digits.isEmpty) return;
    try {
      final ok = await launchUrl(
        Uri(scheme: 'tel', path: digits),
        mode: LaunchMode.externalApplication,
      );
      if (!ok) _dialError(raw);
    } catch (_) {
      _dialError(raw);
    }
  }

  void _dialError(String raw) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('전화 앱을 열 수 없어요. 번호를 직접 눌러주세요: $raw')),
    );
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
    final docType = (args is Map && args['doc_type'] is String)
        ? args['doc_type'] as String
        : null;
    final body = detail.isNotEmpty ? detail : message;
    final look = _look(level);
    final rec = recommendedHelp(type);

    return Scaffold(
      backgroundColor: AppColors.paper,
      body: Column(
        children: [
          _header(context, look, type, message),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.fromLTRB(
                    context.rs(28), context.rs(24), context.rs(28), context.rs(28)),
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
                    SizedBox(height: context.rs(28)),
                    _helpSection(context, rec, type, docType),
                  ],
                ),
              ),
            ),
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

  // ── Help CTAs ─────────────────────────────────────────────────────────

  Widget _helpSection(
      BuildContext context, RiskHelp rec, String type, String? docType) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '도움받을 곳',
          style: GoogleFonts.notoSansKr(
            fontSize: context.rs(22),
            fontWeight: FontWeight.w800,
            color: AppColors.ink,
          ),
        ),
        SizedBox(height: context.rs(6)),
        Text(
          '혼자 판단하지 않아도 돼요. 아래에 확인해보세요.',
          style: GoogleFonts.notoSansKr(
            fontSize: context.rs(17),
            color: AppColors.stone,
          ),
        ),
        if (rec.tier1.isNotEmpty) ...[
          SizedBox(height: context.rs(8)),
          _tierLabel(context, '① 지금 확인'),
          for (final c in rec.tier1) _contactCard(context, c),
        ],
        if (rec.victim != null) ...[
          SizedBox(height: context.rs(8)),
          _victimSection(context, rec.victim!),
        ],
        SizedBox(height: context.rs(16)),
        _fullHelpButton(context, type, docType),
      ],
    );
  }

  Widget _tierLabel(BuildContext context, String text) {
    return Padding(
      padding: EdgeInsets.only(top: context.rs(8), bottom: context.rs(10)),
      child: Text(
        text,
        style: GoogleFonts.notoSansKr(
          fontSize: context.rs(16),
          fontWeight: FontWeight.w700,
          color: AppColors.stone,
        ),
      ),
    );
  }

  /// A tel: CTA card. Emergency numbers (112) use the danger colour.
  Widget _contactCard(BuildContext context, HelpContactRef c) {
    final color = c.emergency ? const Color(0xFFB04A3A) : AppColors.forest;
    final subtitle = [c.org, c.phone].where((s) => s.isNotEmpty).join(' · ');
    return Padding(
      padding: EdgeInsets.only(bottom: context.rs(12)),
      child: Material(
        color: color,
        borderRadius: BorderRadius.circular(14),
        child: InkWell(
          borderRadius: BorderRadius.circular(14),
          onTap: () => _dial(c.phone),
          child: Container(
            padding: EdgeInsets.symmetric(
                horizontal: context.rs(20), vertical: context.rs(16)),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        c.title,
                        style: GoogleFonts.notoSansKr(
                          fontSize: context.rs(20),
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                        ),
                      ),
                      if (subtitle.isNotEmpty) ...[
                        SizedBox(height: context.rs(2)),
                        Text(
                          subtitle,
                          style: GoogleFonts.notoSansKr(
                            fontSize: context.rs(16),
                            color: Colors.white.withValues(alpha: 0.85),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                SizedBox(width: context.rs(12)),
                Icon(Icons.call, color: Colors.white, size: context.rs(24)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// "② 벌써 당했다면" — collapsed by default; taps expand the relief guidance.
  Widget _victimSection(BuildContext context, VictimHelp v) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.hairline),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            borderRadius: BorderRadius.circular(14),
            onTap: () => setState(() => _victimExpanded = !_victimExpanded),
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: context.rs(18), vertical: context.rs(16)),
              child: Row(
                children: [
                  Icon(Icons.error_outline,
                      color: const Color(0xFFB04A3A), size: context.rs(22)),
                  SizedBox(width: context.rs(10)),
                  Expanded(
                    child: Text(
                      '② 벌써 당했다면',
                      style: GoogleFonts.notoSansKr(
                        fontSize: context.rs(19),
                        fontWeight: FontWeight.w700,
                        color: AppColors.ink,
                      ),
                    ),
                  ),
                  Icon(
                    _victimExpanded ? Icons.expand_less : Icons.expand_more,
                    color: AppColors.stone,
                    size: context.rs(26),
                  ),
                ],
              ),
            ),
          ),
          if (_victimExpanded)
            Padding(
              padding: EdgeInsets.fromLTRB(
                  context.rs(18), 0, context.rs(18), context.rs(16)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TobagiImage(tobagiAsset(TobagiState.victim), size: 52),
                      SizedBox(width: context.rs(12)),
                      Expanded(
                        child: Text(
                          v.guide,
                          style: GoogleFonts.notoSansKr(
                            fontSize: context.rs(18),
                            height: 1.6,
                            color: AppColors.ink,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: context.rs(14)),
                  for (final c in v.contacts) _contactCard(context, c),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _fullHelpButton(BuildContext context, String type, String? docType) {
    return SizedBox(
      width: double.infinity,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: () => Get.toNamed(
            Routes.help,
            arguments: {'risk_type': type, 'doc_type': docType},
          ),
          child: Container(
            height: context.rs(60),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: AppColors.forest, width: 1.5),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.support_agent,
                    size: context.rs(22), color: AppColors.forest),
                SizedBox(width: context.rs(10)),
                Text(
                  '도움받을 곳 전체 보기',
                  style: GoogleFonts.notoSansKr(
                    fontSize: context.rs(19),
                    fontWeight: FontWeight.w700,
                    color: AppColors.forest,
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
