import 'package:flutter/material.dart';

import '../core/theme.dart';

/// Segmented control switching between the easy explanation and the raw
/// original text. Explanation is shown first (the whole point of the app).
class OriginalExplainedToggle extends StatefulWidget {
  const OriginalExplainedToggle({
    super.key,
    required this.explained,
    required this.original,
    this.english = false,
  });

  final String? explained;
  final String? original;
  final bool english;

  @override
  State<OriginalExplainedToggle> createState() =>
      _OriginalExplainedToggleState();
}

class _OriginalExplainedToggleState extends State<OriginalExplainedToggle> {
  bool _showOriginal = false;

  @override
  Widget build(BuildContext context) {
    final explainedLabel = widget.english ? 'Explanation' : '쉬운 풀이';
    final originalLabel = widget.english ? 'Original' : '원문';
    final body = _showOriginal ? widget.original : widget.explained;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: AppColors.background,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.border),
          ),
          child: Row(
            children: [
              _tab(explainedLabel, !_showOriginal,
                  () => setState(() => _showOriginal = false)),
              _tab(originalLabel, _showOriginal,
                  () => setState(() => _showOriginal = true)),
            ],
          ),
        ),
        const SizedBox(height: 14),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: AppColors.border),
          ),
          child: Text(
            (body == null || body.trim().isEmpty) ? '—' : body,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  height: 1.55,
                  color: _showOriginal
                      ? AppColors.textSecondary
                      : AppColors.textPrimary,
                ),
          ),
        ),
      ],
    );
  }

  Widget _tab(String label, bool active, VoidCallback onTap) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 44,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: active ? AppColors.primary : Colors.transparent,
            borderRadius: BorderRadius.circular(9),
          ),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w700,
              color: active ? Colors.white : AppColors.textSecondary,
            ),
          ),
        ),
      ),
    );
  }
}
