import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';

import '../core/theme.dart';
import '../data/models/reply_draft.dart';
import '../data/services/tts_service.dart';

/// A ready-to-send Korean reply with copy / share / listen controls.
/// Used in `native` mode so a non-Korean speaker can answer in Korean.
class ReplyDraftTile extends StatelessWidget {
  const ReplyDraftTile({super.key, required this.draft});

  final ReplyDraft draft;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SelectableText(
            draft.korean,
            style: Theme.of(context)
                .textTheme
                .bodyLarge
                ?.copyWith(fontWeight: FontWeight.w700, height: 1.5),
          ),
          if (draft.noteInLang != null && draft.noteInLang!.trim().isNotEmpty) ...[
            const SizedBox(height: 8),
            Text(
              draft.noteInLang!,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.textSecondary,
                    fontStyle: FontStyle.italic,
                  ),
            ),
          ],
          const SizedBox(height: 12),
          Row(
            children: [
              _action(context, Icons.copy, 'Copy', () async {
                await Clipboard.setData(ClipboardData(text: draft.korean));
                Get.snackbar('Copied', 'Korean reply copied to clipboard',
                    snackPosition: SnackPosition.BOTTOM,
                    margin: const EdgeInsets.all(12));
              }),
              const SizedBox(width: 8),
              _action(context, Icons.ios_share, 'Share',
                  () => SharePlus.instance.share(ShareParams(text: draft.korean))),
              const SizedBox(width: 8),
              _action(context, Icons.volume_up, 'Listen',
                  () => Get.find<TtsService>().speak(draft.korean, lang: 'ko')),
            ],
          ),
        ],
      ),
    );
  }

  Widget _action(
      BuildContext context, IconData icon, String label, VoidCallback onTap) {
    return Expanded(
      child: OutlinedButton.icon(
        onPressed: onTap,
        style: OutlinedButton.styleFrom(
          minimumSize: const Size.fromHeight(48),
          padding: const EdgeInsets.symmetric(horizontal: 6),
        ),
        icon: Icon(icon, size: 20),
        label: Text(label, style: const TextStyle(fontSize: 15)),
      ),
    );
  }
}
