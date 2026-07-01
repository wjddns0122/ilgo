import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/theme.dart';
import 'analyze_controller.dart';

/// Loading / error screen shown while an analysis is running.
/// On success the controller replaces this route with the result screen.
class AnalyzeView extends GetView<AnalyzeController> {
  const AnalyzeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(leading: const BackButton()),
      body: SafeArea(
        child: Obx(() {
          if (controller.error.value != null) {
            return _error(context, controller.error.value!);
          }
          return _loading(context);
        }),
      ),
    );
  }

  Widget _loading(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            width: 64,
            height: 64,
            child: CircularProgressIndicator(strokeWidth: 5),
          ),
          const SizedBox(height: 28),
          Text('AI가 읽고 있어요',
              style: Theme.of(context).textTheme.headlineMedium),
          const SizedBox(height: 10),
          Text('잠시만 기다려 주세요',
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(color: AppColors.textSecondary)),
        ],
      ),
    );
  }

  Widget _error(BuildContext context, String message) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, size: 72, color: AppColors.riskRed),
          const SizedBox(height: 20),
          Text(message,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 32),
          ElevatedButton.icon(
            onPressed: controller.retry,
            icon: const Icon(Icons.refresh),
            label: const Text('다시 시도'),
          ),
          const SizedBox(height: 12),
          OutlinedButton(
            onPressed: () => Get.back(),
            child: const Text('돌아가기'),
          ),
        ],
      ),
    );
  }
}
