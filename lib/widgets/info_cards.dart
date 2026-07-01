import 'package:flutter/material.dart';

import '../core/theme.dart';
import '../data/models/cards.dart';

/// "At a glance" grid: only shows the fields the engine actually filled in.
class InfoCards extends StatelessWidget {
  const InfoCards({super.key, required this.cards, this.english = false});

  final Cards cards;
  final bool english;

  @override
  Widget build(BuildContext context) {
    final rows = <_Row>[
      _Row(Icons.help_outline, english ? 'What' : '무엇', cards.what),
      _Row(Icons.schedule, english ? 'When' : '언제', cards.when),
      _Row(Icons.place_outlined, english ? 'Where' : '어디', cards.where),
      _Row(Icons.payments_outlined, english ? 'Amount' : '금액', cards.amount),
      _Row(Icons.event_outlined, english ? 'Deadline' : '기한', cards.deadline),
    ].where((r) => r.value != null && r.value!.trim().isNotEmpty).toList();

    if (rows.isEmpty) return const SizedBox.shrink();

    return Column(
      children: [
        for (final r in rows)
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: AppColors.border),
              ),
              child: Row(
                children: [
                  Icon(r.icon, color: AppColors.primary, size: 24),
                  const SizedBox(width: 12),
                  SizedBox(
                    width: 64,
                    child: Text(
                      r.label,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: AppColors.textSecondary,
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      r.value!,
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge
                          ?.copyWith(fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}

class _Row {
  const _Row(this.icon, this.label, this.value);
  final IconData icon;
  final String label;
  final String? value;
}
