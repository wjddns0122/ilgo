import 'package:add_2_calendar/add_2_calendar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../core/app_routes.dart';
import '../../core/help_recommend.dart';
import '../../core/responsive.dart';
import '../../core/theme.dart';
import '../../data/models/action_item.dart';
import '../../data/models/analysis.dart';
import '../../data/models/cards.dart';
import '../../data/models/reply_draft.dart';
import '../../data/models/risk.dart';
import '../../widgets/tobagi_easy_view.dart';
import '../analyze/analyze_controller.dart';

/// Result screen — easy-Korean 고지서 layout (Figma node 1:828).
/// Two tabs: 풀이 (explanation) and 핵심·할 일 (key facts + to-dos).
class ResultView extends StatefulWidget {
  const ResultView({super.key});

  @override
  State<ResultView> createState() => _ResultViewState();
}

/// Design-specific risk styling (safe/caution/danger).
class _RiskLook {
  const _RiskLook(this.color, this.label);
  final Color color;
  final String label;

  static _RiskLook of(String level) {
    switch (level) {
      case 'green':
        return const _RiskLook(Color(0xFF3B7A57), '안심');
      case 'red':
        return const _RiskLook(Color(0xFFB04A3A), '위험');
      default:
        return const _RiskLook(Color(0xFFC0902A), '주의');
    }
  }
}

class _ResultViewState extends State<ResultView> {
  final AnalyzeController controller = Get.find<AnalyzeController>();

  int _tab = 0; // 0 = 풀이, 1 = 핵심·할 일
  bool _showOriginal = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.paper,
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: kOnbMaxWidth),
            child: Obx(() {
              final a = controller.result.value;
              if (a == null) {
                return const Center(child: CircularProgressIndicator());
              }
              return SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(
                    context.rs(28),
                    0,
                    context.rs(28),
                    context.rs(24),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _header(context, a),
                      SizedBox(height: context.rs(26)),
                      _summary(context, a),
                      SizedBox(height: context.rs(20)),
                      TobagiEasyView(a),
                      SizedBox(height: context.rs(28)),
                      _risks(context, a.risks),
                      SizedBox(height: context.rs(32)),
                      _tabs(context, a),
                      SizedBox(height: context.rs(24)),
                      _tabContent(context, a),
                      SizedBox(height: context.rs(28)),
                      _feedbackCard(context),
                    ],
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }

  // ── Header ────────────────────────────────────────────────────────────
  Widget _header(BuildContext context, Analysis a) {
    final d = DateTime.tryParse(a.createdAt)?.toLocal();
    final date = d != null ? '${d.month}월 ${d.day}일' : '';
    final meta = [
      a.docType,
      if (date.isNotEmpty) date,
    ].whereType<String>().join(' · ');
    return Padding(
      padding: EdgeInsets.only(top: context.rs(15), bottom: context.rs(8)),
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
              onPressed: () => Get.back(),
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                meta,
                style: GoogleFonts.notoSansKr(
                  fontSize: context.rs(13.12),
                  color: AppColors.stone,
                ),
              ),
              SizedBox(width: context.rs(14)),
              SizedBox(
                width: context.rs(22),
                height: context.rs(22),
                child: IconButton(
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  iconSize: context.rs(20),
                  tooltip: '공유',
                  icon: const Icon(Icons.ios_share, color: AppColors.ink),
                  onPressed: () => _share(context, a),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ── Share ─────────────────────────────────────────────────────────────
  /// Offer two share flavours: a plain result, or a "help request" that asks a
  /// family member / colleague to check together (stronger social framing).
  Future<void> _share(BuildContext context, Analysis a) async {
    await showModalBottomSheet<void>(
      context: context,
      backgroundColor: AppColors.paper,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: ctx.rs(8)),
            _shareOption(
              ctx,
              Icons.volunteer_activism,
              '도움 요청으로 공유',
              '가족·동료에게 "같이 확인해줘"',
              () {
                Navigator.of(ctx).pop();
                SharePlus.instance
                    .share(ShareParams(text: _helpRequestText(a)));
              },
            ),
            _shareOption(
              ctx,
              Icons.ios_share,
              '결과 공유',
              '요약과 핵심만',
              () {
                Navigator.of(ctx).pop();
                SharePlus.instance.share(ShareParams(text: _shareText(a)));
              },
            ),
            SizedBox(height: ctx.rs(12)),
          ],
        ),
      ),
    );
  }

  Widget _shareOption(
    BuildContext context,
    IconData icon,
    String title,
    String subtitle,
    VoidCallback onTap,
  ) {
    return ListTile(
      onTap: onTap,
      leading: Icon(icon, color: AppColors.forest, size: context.rs(26)),
      title: Text(
        title,
        style: GoogleFonts.notoSansKr(
          fontSize: context.rs(17),
          fontWeight: FontWeight.w700,
          color: AppColors.ink,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: GoogleFonts.notoSansKr(
          fontSize: context.rs(13.6),
          color: AppColors.stone,
        ),
      ),
    );
  }

  /// "도움 요청" template — summary + top risk + 1–2 to-dos + recommended
  /// contact. Never includes the original text or the image (privacy).
  String _helpRequestText(Analysis a) {
    final b = StringBuffer('[읽고] 제가 받은 글을 쉽게 정리했어요.\n\n');
    final summary = a.summaryOneLine?.trim();
    b.writeln(
        '요약: ${(summary != null && summary.isNotEmpty) ? summary : (a.docType ?? '분석 결과')}');
    final top = _topRisk(a);
    if (top != null) {
      b.writeln('위험: ${_RiskLook.of(top.level).label} · ${top.type} — ${top.message}');
    }
    if (a.actions.isNotEmpty) {
      b.writeln();
      b.writeln('해야 할 일:');
      final n = a.actions.length < 2 ? a.actions.length : 2;
      for (var i = 0; i < n; i++) {
        b.writeln('${i + 1}. ${a.actions[i].text}');
      }
    }
    final rec = recommendedHelp(top?.type ?? '');
    if (rec.tier1.isNotEmpty) {
      final c = rec.tier1.first;
      b.writeln();
      b.writeln('도움받을 곳: ${c.title} ${c.phone}');
    }
    b.writeln();
    b.write('혹시 같이 확인해줄 수 있나요?');
    return b.toString();
  }

  /// Highest-severity risk (red > yellow/unknown > green), or null.
  Risk? _topRisk(Analysis a) {
    if (a.risks.isEmpty) return null;
    int sev(String l) => l == 'red' ? 3 : (l == 'green' ? 1 : 2);
    return a.risks.reduce((x, y) => sev(y.level) > sev(x.level) ? y : x);
  }

  String _shareText(Analysis a) {
    final b = StringBuffer('[읽고] ${a.docType ?? '분석 결과'}\n');
    final summary = a.summaryOneLine;
    if (summary != null && summary.trim().isNotEmpty) b.writeln(summary);
    final pairs = a.cards == null
        ? const <(String, String)>[]
        : _keyPairs(a.cards!);
    if (pairs.isNotEmpty) {
      b.writeln();
      for (final p in pairs) {
        b.writeln('${p.$1}: ${p.$2}');
      }
    }
    if (a.actions.isNotEmpty) {
      b.writeln();
      b.writeln('할 일');
      for (var i = 0; i < a.actions.length; i++) {
        b.writeln('${i + 1}. ${a.actions[i].text}');
      }
    }
    if (a.consequence != null && a.consequence!.trim().isNotEmpty) {
      b.writeln();
      b.writeln('안 하면: ${a.consequence}');
    }
    return b.toString().trimRight();
  }

  // ── Feedback (👍/👎) ────────────────────────────────────────────────────
  Widget _feedbackCard(BuildContext context) {
    final sent = controller.feedbackSent.value;
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: context.rs(20),
        vertical: context.rs(18),
      ),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.hairline),
      ),
      child: sent
          ? Row(
              children: [
                Icon(Icons.favorite, size: context.rs(20), color: AppColors.forest),
                SizedBox(width: context.rs(10)),
                Expanded(
                  child: Text(
                    '고마워요! 더 잘 읽어드릴게요.',
                    style: GoogleFonts.notoSansKr(
                      fontSize: context.rs(16),
                      fontWeight: FontWeight.w600,
                      color: AppColors.forest,
                    ),
                  ),
                ),
              ],
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '이 풀이가 도움이 됐어요?',
                  style: GoogleFonts.notoSansKr(
                    fontSize: context.rs(17),
                    fontWeight: FontWeight.w700,
                    color: AppColors.ink,
                  ),
                ),
                SizedBox(height: context.rs(14)),
                Row(
                  children: [
                    Expanded(
                      child: _fbButton(context, Icons.thumb_up_alt_outlined,
                          '도움됐어요', () => controller.submitFeedback(true)),
                    ),
                    SizedBox(width: context.rs(12)),
                    Expanded(
                      child: _fbButton(context, Icons.thumb_down_alt_outlined,
                          '아쉬워요', () => _askReason(context)),
                    ),
                  ],
                ),
              ],
            ),
    );
  }

  Widget _fbButton(
    BuildContext context,
    IconData icon,
    String label,
    VoidCallback onTap,
  ) {
    return OutlinedButton.icon(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.forest,
        side: const BorderSide(color: AppColors.forest),
        padding: EdgeInsets.symmetric(vertical: context.rs(13)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      onPressed: onTap,
      icon: Icon(icon, size: context.rs(18)),
      label: Text(
        label,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: GoogleFonts.notoSansKr(
          fontSize: context.rs(15),
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  /// 👎 → optional free-text reason, then submit.
  void _askReason(BuildContext context) {
    final reason = TextEditingController();
    Get.dialog(
      AlertDialog(
        backgroundColor: AppColors.paper,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(
          '무엇이 아쉬웠나요?',
          style: GoogleFonts.notoSansKr(
            fontSize: context.rs(19),
            fontWeight: FontWeight.w700,
            color: AppColors.ink,
          ),
        ),
        content: TextField(
          controller: reason,
          minLines: 1,
          maxLines: 3,
          style: GoogleFonts.notoSansKr(
              fontSize: context.rs(16), color: AppColors.ink),
          decoration: InputDecoration(
            hintText: '예: 금액이 실제와 달라요 (안 써도 돼요)',
            hintStyle: GoogleFonts.notoSansKr(
                fontSize: context.rs(14), color: AppColors.stone),
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Get.back();
              controller.submitFeedback(false);
            },
            child: Text(
              '그냥 보내기',
              style: GoogleFonts.notoSansKr(
                  fontSize: context.rs(15), color: AppColors.stone),
            ),
          ),
          TextButton(
            onPressed: () {
              final text = reason.text;
              Get.back();
              controller.submitFeedback(false, reason: text);
            },
            child: Text(
              '보내기',
              style: GoogleFonts.notoSansKr(
                fontSize: context.rs(15),
                fontWeight: FontWeight.w700,
                color: AppColors.forest,
              ),
            ),
          ),
        ],
      ),
    ).then((_) => reason.dispose());
  }

  // ── Summary + listen ──────────────────────────────────────────────────
  Widget _summary(BuildContext context, Analysis a) {
    final english = a.outputMode == 'native';
    final speakText = a.explainedText ?? a.summaryOneLine ?? '';
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '한 문장으로',
          style: GoogleFonts.notoSansKr(
            fontSize: context.rs(12.48),
            letterSpacing: 1.0,
            color: AppColors.stone,
          ),
        ),
        SizedBox(height: context.rs(12)),
        Text(
          a.summaryOneLine ?? '',
          style: GoogleFonts.notoSansKr(
            fontSize: context.rs(25.6),
            height: 1.5,
            fontWeight: FontWeight.w700,
            letterSpacing: -0.256,
            color: AppColors.ink,
          ),
        ),
        SizedBox(height: context.rs(16)),
        _listenPill(context, speakText, english ? a.lang : 'ko', a.docType),
      ],
    );
  }

  Widget _listenPill(
    BuildContext context,
    String text,
    String lang,
    String? docType,
  ) {
    return GestureDetector(
      onTap: () => Get.toNamed(
        Routes.listenTts,
        arguments: {'text': text, 'lang': lang, 'title': docType ?? ''},
      ),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: context.rs(17),
          vertical: context.rs(9),
        ),
        decoration: BoxDecoration(
          color: AppColors.card,
          borderRadius: BorderRadius.circular(999),
          border: Border.all(color: AppColors.hairline),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.volume_up,
              size: context.rs(18),
              color: AppColors.forest,
            ),
            SizedBox(width: context.rs(8)),
            Text(
              '소리로 듣기',
              style: GoogleFonts.notoSansKr(
                fontSize: context.rs(13.6),
                color: AppColors.forest,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── Risk banners ──────────────────────────────────────────────────────
  Widget _risks(BuildContext context, List<Risk> risks) {
    if (risks.isEmpty) return const SizedBox.shrink();
    return Column(
      children: [
        for (var i = 0; i < risks.length; i++) ...[
          if (i > 0) SizedBox(height: context.rs(12)),
          _riskBanner(context, risks[i]),
        ],
      ],
    );
  }

  Widget _riskBanner(BuildContext context, Risk risk) {
    final look = _RiskLook.of(risk.level);
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(8),
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: () {
          // Prefer backend-provided steps; fall back to the analysis to-dos.
          final steps = risk.steps.isNotEmpty
              ? risk.steps
              : (controller.result.value?.actions.map((e) => e.text).toList() ??
                    const <String>[]);
          Get.toNamed(
            Routes.riskDetail,
            arguments: {
              'level': risk.level,
              'type': risk.type,
              'message': risk.message,
              'detail': risk.detail,
              'steps': steps,
              'doc_type': controller.result.value?.docType,
            },
          );
        },
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(
            horizontal: context.rs(17),
            vertical: context.rs(15),
          ),
          decoration: BoxDecoration(
            color: AppColors.card,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: look.color.withValues(alpha: 0.4)),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(top: context.rs(5)),
                child: Container(
                  width: context.rs(14),
                  height: context.rs(14),
                  decoration: BoxDecoration(
                    color: look.color,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              SizedBox(width: context.rs(12)),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          look.label,
                          style: GoogleFonts.notoSansKr(
                            fontSize: context.rs(13.12),
                            color: look.color,
                          ),
                        ),
                        SizedBox(width: context.rs(8)),
                        Text(
                          risk.type,
                          style: GoogleFonts.notoSansKr(
                            fontSize: context.rs(12.48),
                            color: AppColors.stone,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: context.rs(4)),
                    Text(
                      risk.message,
                      style: GoogleFonts.notoSansKr(
                        fontSize: context.rs(14.72),
                        height: 1.6,
                        color: AppColors.ink,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: context.rs(8)),
              Icon(
                Icons.chevron_right,
                size: context.rs(20),
                color: AppColors.stone,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ── Segmented tabs ────────────────────────────────────────────────────
  Widget _tabs(BuildContext context, Analysis a) {
    final native = a.outputMode == 'native';
    final labels = native
        ? const ['풀이', '핵심 · 할 일', '답장']
        : const ['풀이', '핵심 · 할 일'];
    return Container(
      padding: EdgeInsets.all(context.rs(4)),
      decoration: BoxDecoration(
        color: AppColors.sand,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          for (var i = 0; i < labels.length; i++) ...[
            if (i > 0) SizedBox(width: context.rs(4)),
            _tabButton(context, labels[i], i),
          ],
        ],
      ),
    );
  }

  /// Picks tab content, clamping the index when the tab set shrinks
  /// (e.g. easy mode has no 답장 tab).
  Widget _tabContent(BuildContext context, Analysis a) {
    final maxTab = a.outputMode == 'native' ? 2 : 1;
    final idx = _tab > maxTab ? 0 : _tab;
    switch (idx) {
      case 0:
        return _explanationTab(context, a);
      case 1:
        return _detailsTab(context, a);
      default:
        return _replyTab(context, a);
    }
  }

  Widget _tabButton(BuildContext context, String label, int index) {
    final active = _tab == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _tab = index),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: EdgeInsets.symmetric(vertical: context.rs(8)),
          decoration: BoxDecoration(
            color: active ? AppColors.card : Colors.transparent,
            borderRadius: BorderRadius.circular(6),
            boxShadow: active
                ? [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.1),
                      blurRadius: 1.5,
                      offset: const Offset(0, 1),
                    ),
                  ]
                : null,
          ),
          alignment: Alignment.center,
          child: Text(
            label,
            style: GoogleFonts.notoSansKr(
              fontSize: context.rs(13.6),
              color: active ? AppColors.forest : AppColors.stone,
            ),
          ),
        ),
      ),
    );
  }

  // ── Tab: 풀이 ──────────────────────────────────────────────────────────
  Widget _explanationTab(BuildContext context, Analysis a) {
    final native = a.outputMode == 'native';
    var body = _showOriginal ? a.originalText : a.explainedText;
    // Edge case: no translation available → fall back to the original text.
    if (!_showOriginal && (body == null || body.trim().isEmpty)) {
      body = a.originalText;
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              _showOriginal ? '원문' : (native ? '모국어 풀이' : '쉬운 풀이'),
              style: GoogleFonts.notoSansKr(
                fontSize: context.rs(16),
                fontWeight: FontWeight.w700,
                letterSpacing: -0.16,
                color: AppColors.ink,
              ),
            ),
            GestureDetector(
              onTap: () => setState(() => _showOriginal = !_showOriginal),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.swap_horiz,
                    size: context.rs(18),
                    color: AppColors.stone,
                  ),
                  SizedBox(width: context.rs(8)),
                  Text(
                    _showOriginal ? '풀이 보기' : '원문 보기',
                    style: GoogleFonts.notoSansKr(
                      fontSize: context.rs(13.12),
                      color: AppColors.stone,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: context.rs(16)),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(context.rs(21)),
          decoration: BoxDecoration(
            color: AppColors.card,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppColors.hairline),
          ),
          child: Text(
            (body == null || body.trim().isEmpty) ? '—' : body,
            // Plain style (no forced family) so non-Latin scripts (Khmer,
            // Devanagari, etc.) fall back to a system font instead of tofu.
            style: TextStyle(
              fontSize: context.rs(16),
              height: 1.9,
              color: AppColors.ink,
            ),
          ),
        ),
        SizedBox(height: context.rs(12)),
        Text(
          '풀이가 어색하면 원문을 함께 확인하세요. 금액·날짜는 원문 기준이에요.',
          style: GoogleFonts.notoSansKr(
            fontSize: context.rs(12.8),
            height: 1.6,
            color: AppColors.stone,
          ),
        ),
      ],
    );
  }

  // ── Tab: 핵심 · 할 일 ──────────────────────────────────────────────────
  Widget _detailsTab(BuildContext context, Analysis a) {
    final hasCards = a.cards != null && _keyPairs(a.cards!).isNotEmpty;
    final hasDeadline =
        a.cards?.deadline != null && a.cards!.deadline!.trim().isNotEmpty;
    final phone = _phoneOf(a);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (hasCards) ...[
          _sectionTitle(context, '핵심 카드'),
          SizedBox(height: context.rs(16)),
          _keyCards(context, a.cards!),
        ],
        if (a.actions.isNotEmpty) ...[
          SizedBox(height: context.rs(32)),
          _sectionTitle(context, '할 일'),
          SizedBox(height: context.rs(16)),
          _todoList(context, a.actions),
        ],
        if (a.consequence != null && a.consequence!.trim().isNotEmpty) ...[
          SizedBox(height: context.rs(32)),
          _consequenceBox(context, a.consequence!),
        ],
        if (hasDeadline) ...[
          SizedBox(height: context.rs(32)),
          _calendarButton(context, a),
        ],
        if (phone != null) ...[
          SizedBox(height: hasDeadline ? context.rs(12) : context.rs(32)),
          _phoneButton(context, phone),
        ],
      ],
    );
  }

  /// First phone-looking number in the document (cards/actions/original).
  String? _phoneOf(Analysis a) {
    final source = [
      a.cards?.what,
      a.cards?.where,
      for (final act in a.actions) act.text,
      a.originalText,
    ].whereType<String>().join(' ');
    final m = RegExp(
      r'(0\d{1,2}[-.\s]?\d{3,4}[-.\s]?\d{4}|1\d{3}[-.\s]?\d{4})',
    ).firstMatch(source);
    return m?.group(0);
  }

  Widget _phoneButton(BuildContext context, String number) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton.icon(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.forest,
          side: const BorderSide(color: AppColors.forest),
          padding: EdgeInsets.symmetric(vertical: context.rs(17)),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        onPressed: () => _dial(number),
        icon: Icon(Icons.call_outlined, size: context.rs(20)),
        label: Text(
          '전화 걸기 · $number',
          style: GoogleFonts.notoSansKr(fontSize: context.rs(16)),
        ),
      ),
    );
  }

  Future<void> _dial(String raw) async {
    final digits = raw.replaceAll(RegExp(r'[^0-9+]'), '');
    if (digits.isEmpty) return;
    await launchUrl(
      Uri(scheme: 'tel', path: digits),
      mode: LaunchMode.externalApplication,
    );
  }

  // ── Tab: 답장 (native only) ────────────────────────────────────────────
  Widget _replyTab(BuildContext context, Analysis a) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (a.replyDrafts.isEmpty)
          Padding(
            padding: EdgeInsets.symmetric(vertical: context.rs(20)),
            child: Text(
              '이 글에는 준비된 답장이 없어요.',
              style: GoogleFonts.notoSansKr(
                fontSize: context.rs(14),
                color: AppColors.stone,
              ),
            ),
          )
        else ...[
          _sectionTitle(context, '이렇게 답장해요'),
          SizedBox(height: context.rs(16)),
          for (final draft in a.replyDrafts) _replyRow(context, draft),
        ],
        SizedBox(height: context.rs(20)),
        _regenerateRow(context),
      ],
    );
  }

  // ── 답장 다시 만들기 (tone) ────────────────────────────────────────────
  Widget _regenerateRow(BuildContext context) {
    final busy = controller.isRegenerating.value;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '마음에 안 들면 새 답장을 만들 수 있어요',
          style: GoogleFonts.notoSansKr(
            fontSize: context.rs(13.12),
            color: AppColors.stone,
          ),
        ),
        SizedBox(height: context.rs(10)),
        Row(
          children: [
            Expanded(child: _toneButton(context, '정중하게 다시', 'polite', busy)),
            SizedBox(width: context.rs(12)),
            Expanded(child: _toneButton(context, '짧게 다시', 'short', busy)),
          ],
        ),
      ],
    );
  }

  Widget _toneButton(
    BuildContext context,
    String label,
    String tone,
    bool busy,
  ) {
    return OutlinedButton.icon(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.forest,
        side: const BorderSide(color: AppColors.forest),
        padding: EdgeInsets.symmetric(vertical: context.rs(12)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      onPressed: busy ? null : () => controller.regenerateReplies(tone: tone),
      icon: busy
          ? SizedBox(
              width: context.rs(16),
              height: context.rs(16),
              child: const CircularProgressIndicator(strokeWidth: 2),
            )
          : Icon(Icons.refresh, size: context.rs(18)),
      label: Text(
        label,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: GoogleFonts.notoSansKr(fontSize: context.rs(14)),
      ),
    );
  }

  Widget _sectionTitle(BuildContext context, String title) {
    return Text(
      title,
      style: GoogleFonts.notoSansKr(
        fontSize: context.rs(16),
        fontWeight: FontWeight.w700,
        letterSpacing: -0.16,
        color: AppColors.ink,
      ),
    );
  }

  // ── 핵심 카드 (2-column grid) ──────────────────────────────────────────
  /// (label, value) pairs, non-empty only; deadline formatted as YYYY년 M월 D일.
  List<(String, String)> _keyPairs(Cards c) {
    return <(String, String?)>[
          ('무엇', c.what),
          ('언제', c.when),
          ('어디서', c.where),
          ('얼마', c.amount),
          ('기한', _fmtDeadline(c.deadline)),
        ]
        .where((e) => e.$2 != null && e.$2!.trim().isNotEmpty)
        .map((e) => (e.$1, e.$2!))
        .toList();
  }

  String? _fmtDeadline(String? raw) {
    if (raw == null || raw.isEmpty) return null;
    final d = DateTime.tryParse(raw);
    return d == null ? raw : '${d.year}년 ${d.month}월 ${d.day}일';
  }

  Widget _keyCards(BuildContext context, Cards c) {
    final pairs = _keyPairs(c);
    return Column(
      children: [
        for (var i = 0; i < pairs.length; i += 2) ...[
          if (i > 0) SizedBox(height: context.rs(12)),
          IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(child: _keyCard(context, pairs[i])),
                SizedBox(width: context.rs(12)),
                Expanded(
                  child: i + 1 < pairs.length
                      ? _keyCard(context, pairs[i + 1])
                      : const SizedBox(),
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }

  Widget _keyCard(BuildContext context, (String, String) pair) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: context.rs(17),
        vertical: context.rs(15),
      ),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.hairline),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            pair.$1,
            style: GoogleFonts.notoSansKr(
              fontSize: context.rs(12),
              color: AppColors.stone,
            ),
          ),
          SizedBox(height: context.rs(4)),
          Text(
            pair.$2,
            style: GoogleFonts.notoSansKr(
              fontSize: context.rs(16),
              height: 1.4,
              color: AppColors.ink,
            ),
          ),
        ],
      ),
    );
  }

  // ── 할 일 (tappable checklist — FR-14) ─────────────────────────────────
  Widget _todoList(BuildContext context, List<ActionItem> actions) {
    return Column(
      children: [
        for (var i = 0; i < actions.length; i++) ...[
          InkWell(
            onTap: () => controller.toggleAction(actions[i].id),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: context.rs(12)),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: context.rs(24),
                    height: context.rs(24),
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      color: AppColors.forest,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      '${i + 1}',
                      style: GoogleFonts.notoSansKr(
                        fontSize: context.rs(12),
                        color: AppColors.paper,
                      ),
                    ),
                  ),
                  SizedBox(width: context.rs(12)),
                  Expanded(
                    child: Text(
                      actions[i].text,
                      style: GoogleFonts.notoSansKr(
                        fontSize: context.rs(16),
                        height: 1.6,
                        color: actions[i].isDone
                            ? AppColors.stone
                            : AppColors.ink,
                        decoration: actions[i].isDone
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                        decorationColor: AppColors.stone,
                      ),
                    ),
                  ),
                  SizedBox(width: context.rs(12)),
                  _checkMark(context, actions[i].isDone),
                ],
              ),
            ),
          ),
          Container(height: 1, color: AppColors.hairline),
        ],
      ],
    );
  }

  /// "했어요" indicator — filled when done, outlined when pending.
  Widget _checkMark(BuildContext context, bool done) {
    final s = context.rs(26);
    return Container(
      width: s,
      height: s,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: done ? AppColors.forest : Colors.transparent,
        shape: BoxShape.circle,
        border: Border.all(
          color: done ? AppColors.forest : AppColors.stone,
          width: 1.5,
        ),
      ),
      child: done
          ? Icon(Icons.check, size: context.rs(16), color: AppColors.paper)
          : null,
    );
  }

  Widget _consequenceBox(BuildContext context, String text) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: context.rs(20),
        vertical: context.rs(16),
      ),
      decoration: BoxDecoration(
        color: AppColors.sand,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.schedule,
                size: context.rs(18),
                color: AppColors.forest,
              ),
              SizedBox(width: context.rs(8)),
              Text(
                '안 하면 어떻게 되나요?',
                style: GoogleFonts.notoSansKr(
                  fontSize: context.rs(13.6),
                  color: AppColors.forest,
                ),
              ),
            ],
          ),
          SizedBox(height: context.rs(8)),
          Text(
            text,
            style: GoogleFonts.notoSansKr(
              fontSize: context.rs(14.4),
              height: 1.7,
              color: AppColors.stone,
            ),
          ),
        ],
      ),
    );
  }

  Widget _calendarButton(BuildContext context, Analysis a) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton.icon(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.forest,
          side: const BorderSide(color: AppColors.forest),
          padding: EdgeInsets.symmetric(vertical: context.rs(17)),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        onPressed: () => _addToCalendar(a),
        icon: Icon(Icons.calendar_today_outlined, size: context.rs(20)),
        label: Text(
          '캘린더에 추가',
          style: GoogleFonts.notoSansKr(fontSize: context.rs(16)),
        ),
      ),
    );
  }

  Widget _replyRow(BuildContext context, ReplyDraft draft) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: context.rs(12)),
      child: Material(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(8),
        child: InkWell(
          borderRadius: BorderRadius.circular(8),
          onTap: () => Get.toNamed(
            Routes.replyDetail,
            arguments: {'korean': draft.korean, 'note': draft.noteInLang ?? ''},
          ),
          child: Container(
            padding: EdgeInsets.all(context.rs(17)),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: AppColors.hairline),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        draft.korean,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.notoSansKr(
                          fontSize: context.rs(16),
                          height: 1.5,
                          fontWeight: FontWeight.w600,
                          color: AppColors.ink,
                        ),
                      ),
                      if (draft.noteInLang != null &&
                          draft.noteInLang!.trim().isNotEmpty) ...[
                        SizedBox(height: context.rs(6)),
                        Text(
                          draft.noteInLang!,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.notoSansKr(
                            fontSize: context.rs(13.6),
                            color: AppColors.stone,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                SizedBox(width: context.rs(8)),
                Icon(
                  Icons.chevron_right,
                  size: context.rs(22),
                  color: AppColors.stone,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _addToCalendar(Analysis a) async {
    final deadline = a.cards?.deadline;
    if (deadline == null) return;
    final date = DateTime.tryParse(deadline);
    if (date == null) return;
    final event = Event(
      title: a.cards?.what ?? a.summaryOneLine ?? '읽고 기한',
      description: a.summaryOneLine ?? '',
      startDate: date,
      endDate: date.add(const Duration(hours: 1)),
      allDay: true,
    );
    final ok = await Add2Calendar.addEvent2Cal(event);
    if (!ok) return;
    final amount = a.cards?.amount;
    Get.toNamed(
      Routes.calendarAdded,
      arguments: {
        'month': '${date.month}월',
        'day': '${date.day}',
        'title': a.cards?.what ?? a.summaryOneLine ?? '기한',
        'subtitle': [
          if (amount != null && amount.trim().isNotEmpty) amount,
          '오전 알림',
        ].join(' · '),
      },
    );
  }
}
