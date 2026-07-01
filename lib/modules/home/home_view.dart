import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/app_routes.dart';
import '../../core/theme.dart';
import '../../data/models/enums.dart';
import '../../data/services/profile_service.dart';
import 'home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final profile = Get.find<ProfileService>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('읽고'),
        actions: [
          IconButton(
            iconSize: 28,
            icon: const Icon(Icons.folder_outlined),
            tooltip: '보관함',
            onPressed: () => Get.toNamed(Routes.library),
          ),
          IconButton(
            iconSize: 28,
            icon: const Icon(Icons.settings_outlined),
            tooltip: '설정',
            onPressed: () => Get.toNamed(Routes.settings),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              const SizedBox(height: 12),
              Obx(() => _modeChip(profile.mode.value)),
              const Spacer(),
              const Icon(Icons.center_focus_strong,
                  size: 96, color: AppColors.primary),
              const SizedBox(height: 20),
              Text(
                '고지서나 문자를\n사진으로 찍어보세요',
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .headlineMedium
                    ?.copyWith(height: 1.35),
              ),
              const SizedBox(height: 12),
              Text(
                '어려운 내용을 쉽게 풀어드려요',
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(color: AppColors.textSecondary),
              ),
              const Spacer(),
              ElevatedButton.icon(
                onPressed: controller.capture,
                icon: const Icon(Icons.camera_alt, size: 26),
                label: const Text('사진 찍기'),
              ),
              const SizedBox(height: 12),
              OutlinedButton.icon(
                onPressed: controller.fromGallery,
                icon: const Icon(Icons.photo_library_outlined, size: 24),
                label: const Text('앨범에서 고르기'),
              ),
              const SizedBox(height: 12),
              TextButton.icon(
                onPressed: controller.runSample,
                icon: const Icon(Icons.auto_awesome, size: 20),
                label: const Text('예시로 체험해보기'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _modeChip(OutputMode mode) {
    final label =
        mode == OutputMode.nativeLang ? '🌏 English' : '🟦 쉬운 한국어';
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.riskGreenBg,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(label,
          style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: AppColors.primaryDark)),
    );
  }
}
