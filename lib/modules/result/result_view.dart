import 'package:add_2_calendar/add_2_calendar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';

import '../../core/app_routes.dart';
import '../../core/theme.dart';
import '../../data/models/analysis.dart';
import '../../widgets/action_tile.dart';
import '../../widgets/info_cards.dart';
import '../../widgets/original_explained_toggle.dart';
import '../../widgets/reply_draft_tile.dart';
import '../../widgets/risk_banner.dart';
import '../../widgets/section_header.dart';
import '../../widgets/speak_button.dart';
import '../analyze/analyze_controller.dart';

/// The main result screen: summary → risks → explanation → cards →
/// to-dos → reply drafts. Everything a user needs after one photo.
class ResultView extends GetView<AnalyzeController> {
  const ResultView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('읽은 결과'),
        actions: [
          IconButton(
            iconSize: 26,
            icon: const Icon(Icons.home_outlined),
            tooltip: '처음으로',
            onPressed: () => Get.offAllNamed(Routes.home),
          ),
        ],
      ),
      body: SafeArea(
        child: Obx(() {
          final a = controller.result.value;
          if (a == null) {
            return const Center(child: CircularProgressIndicator());
          }
          return _body(context, a);
        }),
      ),
    );
  }

  Widget _body(BuildContext context, Analysis a) {
    final english = a.outputMode == 'native';
    final speakText = a.explainedText ?? a.summaryOneLine ?? '';
    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
      children: [
        if (a.docType != null) _docTypeChip(a.docType!),
        const SizedBox(height: 12),

        // Headline summary.
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(18),
          ),
          child: Text(
            a.summaryOneLine ?? '',
            style: const TextStyle(
                color: Colors.white,
                fontSize: 24,
                height: 1.4,
                fontWeight: FontWeight.w800),
          ),
        ),
        const SizedBox(height: 12),
        Align(
          alignment: Alignment.centerLeft,
          child: SpeakButton(text: speakText, lang: english ? 'en' : 'ko'),
        ),
        const SizedBox(height: 24),

        // Risks (traffic light) — most important, near the top.
        if (a.risks.isNotEmpty) ...[
          SectionHeader(
              icon: Icons.warning_amber_rounded,
              title: english ? 'Watch out' : '조심하세요'),
          for (final r in a.risks) ...[
            RiskBanner(risk: r),
            const SizedBox(height: 10),
          ],
          const SizedBox(height: 14),
        ],

        // Explanation ↔ original.
        SectionHeader(
            icon: Icons.menu_book_outlined,
            title: english ? 'What it says' : '무슨 내용인가요'),
        OriginalExplainedToggle(
          explained: a.explainedText,
          original: a.originalText,
          english: english,
        ),
        const SizedBox(height: 24),

        // Consequence callout.
        if (a.consequence != null && a.consequence!.trim().isNotEmpty) ...[
          _consequence(context, a.consequence!, english),
          const SizedBox(height: 24),
        ],

        // At-a-glance cards.
        if (a.cards != null) ...[
          SectionHeader(
              icon: Icons.dashboard_outlined,
              title: english ? 'At a glance' : '한눈에 보기'),
          InfoCards(cards: a.cards!, english: english),
          if (a.cards!.deadline != null && a.cards!.deadline!.isNotEmpty)
            _calendarButton(context, a, english),
          const SizedBox(height: 24),
        ],

        // To-do checklist.
        if (a.actions.isNotEmpty) ...[
          SectionHeader(
              icon: Icons.checklist_rtl,
              title: english ? 'What to do' : '할 일'),
          for (final action in a.actions)
            ActionTile(
              action: action,
              onToggle: () => controller.toggleAction(action.id),
            ),
          const SizedBox(height: 24),
        ],

        // Reply drafts (native mode only).
        if (a.replyDrafts.isNotEmpty) ...[
          SectionHeader(
              icon: Icons.reply_outlined,
              title: english ? 'Reply in Korean' : '답장하기'),
          for (final draft in a.replyDrafts) ReplyDraftTile(draft: draft),
          const SizedBox(height: 16),
        ],

        OutlinedButton.icon(
          onPressed: () => _shareAll(a),
          icon: const Icon(Icons.ios_share),
          label: Text(english ? 'Share' : '공유하기'),
        ),
      ],
    );
  }

  Widget _docTypeChip(String docType) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: AppColors.background,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppColors.border),
        ),
        child: Text(docType,
            style: const TextStyle(
                fontWeight: FontWeight.w700, color: AppColors.textSecondary)),
      ),
    );
  }

  Widget _consequence(BuildContext context, String text, bool english) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.riskYellowBg,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.riskYellow),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.info_outline, color: AppColors.riskYellow),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(english ? "If you don't" : '안 하면요',
                    style: const TextStyle(
                        fontWeight: FontWeight.w800,
                        color: AppColors.riskYellow)),
                const SizedBox(height: 4),
                Text(text,
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge
                        ?.copyWith(height: 1.45)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _calendarButton(BuildContext context, Analysis a, bool english) {
    return Padding(
      padding: const EdgeInsets.only(top: 4),
      child: OutlinedButton.icon(
        onPressed: () => _addToCalendar(a),
        icon: const Icon(Icons.event_available_outlined),
        label: Text(english ? 'Add deadline to calendar' : '기한을 달력에 넣기'),
      ),
    );
  }

  void _addToCalendar(Analysis a) {
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
    Add2Calendar.addEvent2Cal(event);
  }

  void _shareAll(Analysis a) {
    final buffer = StringBuffer()
      ..writeln(a.summaryOneLine ?? '')
      ..writeln()
      ..writeln(a.explainedText ?? '');
    SharePlus.instance.share(ShareParams(text: buffer.toString().trim()));
  }
}
