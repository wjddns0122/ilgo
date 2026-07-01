import 'package:flutter/material.dart';

import '../core/theme.dart';
import '../data/models/risk.dart';

/// A single risk rendered as a traffic-light banner (🟢🟡🔴).
class RiskBanner extends StatelessWidget {
  const RiskBanner({super.key, required this.risk});

  final Risk risk;

  @override
  Widget build(BuildContext context) {
    final style = RiskStyle.of(risk.levelEnum);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: style.background,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: style.color, width: 1.5),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(style.emoji, style: const TextStyle(fontSize: 28)),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  risk.type,
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color: style.color,
                        fontWeight: FontWeight.w800,
                      ),
                ),
                const SizedBox(height: 4),
                Text(
                  risk.message,
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.copyWith(color: AppColors.textPrimary, height: 1.45),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
