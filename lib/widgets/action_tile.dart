import 'package:flutter/material.dart';

import '../core/theme.dart';
import '../data/models/action_item.dart';

/// One to-do row with a large, easy-to-tap checkbox (48dp+ target).
class ActionTile extends StatelessWidget {
  const ActionTile({super.key, required this.action, required this.onToggle});

  final ActionItem action;
  final VoidCallback onToggle;

  @override
  Widget build(BuildContext context) {
    final done = action.isDone;
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onToggle,
        borderRadius: BorderRadius.circular(14),
        child: Container(
          constraints: const BoxConstraints(minHeight: AppTheme.minTouch),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          margin: const EdgeInsets.only(bottom: 10),
          decoration: BoxDecoration(
            color: done ? AppColors.riskGreenBg : AppColors.surface,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
                color: done ? AppColors.riskGreen : AppColors.border),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                done ? Icons.check_circle : Icons.radio_button_unchecked,
                color: done ? AppColors.riskGreen : AppColors.textSecondary,
                size: 28,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  action.text,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        decoration: done ? TextDecoration.lineThrough : null,
                        color: done
                            ? AppColors.textSecondary
                            : AppColors.textPrimary,
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
