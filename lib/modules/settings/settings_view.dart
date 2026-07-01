import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/theme.dart';
import '../../data/models/enums.dart';
import '../../data/services/profile_service.dart';
import 'settings_controller.dart';

class SettingsView extends GetView<SettingsController> {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    final profile = Get.find<ProfileService>();
    return Scaffold(
      appBar: AppBar(title: const Text('설정')),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Text('알려주는 방식',
                style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 12),
            Obx(() {
              final mode = profile.mode.value;
              return Column(
                children: [
                  _option(
                    context,
                    title: '쉬운 한국어로',
                    subtitle: '어려운 말을 쉬운 우리말로',
                    selected: mode == OutputMode.easyKorean,
                    onTap: () => controller.setMode(OutputMode.easyKorean),
                  ),
                  const SizedBox(height: 12),
                  _option(
                    context,
                    title: 'In English',
                    subtitle: 'Explain Korean documents in English',
                    selected: mode == OutputMode.nativeLang,
                    onTap: () => controller.setMode(OutputMode.nativeLang),
                  ),
                ],
              );
            }),
            const SizedBox(height: 32),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.riskYellowBg,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.privacy_tip_outlined,
                      color: AppColors.riskYellow),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      '읽고는 보조 도구예요. 사진은 기본적으로 저장하지 않으며, '
                      '사기·기한 같은 중요한 판단은 꼭 사람과 확인하세요.',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(height: 1.5),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _option(BuildContext context,
      {required String title,
      required String subtitle,
      required bool selected,
      required VoidCallback onTap}) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: selected ? AppColors.riskGreenBg : AppColors.surface,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
                color: selected ? AppColors.primary : AppColors.border,
                width: selected ? 2 : 1),
          ),
          child: Row(
            children: [
              Icon(
                selected
                    ? Icons.radio_button_checked
                    : Icons.radio_button_unchecked,
                color: selected ? AppColors.primary : AppColors.textSecondary,
                size: 26,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title,
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge
                            ?.copyWith(fontSize: 19)),
                    Text(subtitle,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: AppColors.textSecondary)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
