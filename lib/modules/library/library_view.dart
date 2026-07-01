import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/theme.dart';
import '../../data/models/analysis_summary.dart';
import '../../data/models/enums.dart';
import 'library_controller.dart';

class LibraryView extends GetView<LibraryController> {
  const LibraryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('보관함')),
      body: SafeArea(
        child: Obx(() {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }
          if (controller.error.value != null) {
            return Center(child: Text(controller.error.value!));
          }
          if (controller.items.isEmpty) {
            return Center(
              child: Text('아직 저장된 분석이 없어요',
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.copyWith(color: AppColors.textSecondary)),
            );
          }
          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: controller.items.length,
            separatorBuilder: (_, _) => const SizedBox(height: 12),
            itemBuilder: (_, i) => _row(context, controller.items[i]),
          );
        }),
      ),
    );
  }

  Widget _row(BuildContext context, AnalysisSummary item) {
    final style = RiskStyle.of(RiskLevel.fromString(item.topRiskLevel));
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => controller.open(item.id),
        borderRadius: BorderRadius.circular(14),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: AppColors.border),
          ),
          child: Row(
            children: [
              Text(style.emoji, style: const TextStyle(fontSize: 22)),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (item.docType != null)
                      Text(item.docType!,
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: AppColors.textSecondary,
                              fontWeight: FontWeight.w700)),
                    const SizedBox(height: 2),
                    Text(item.summaryOneLine ?? '',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge
                            ?.copyWith(fontWeight: FontWeight.w600)),
                    if (item.cardDeadline != null) ...[
                      const SizedBox(height: 4),
                      Text('기한 ${item.cardDeadline}',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: AppColors.riskRed,
                              fontWeight: FontWeight.w700)),
                    ],
                  ],
                ),
              ),
              const Icon(Icons.chevron_right, color: AppColors.textSecondary),
            ],
          ),
        ),
      ),
    );
  }
}
