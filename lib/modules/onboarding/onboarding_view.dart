import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/app_routes.dart';
import '../../core/theme.dart';
import '../../data/models/enums.dart';
import '../../data/services/profile_service.dart';

/// First-run screen. Pick how the app should talk to you:
/// easy Korean (김민수) or your own language / English (마리아).
class OnboardingView extends StatelessWidget {
  const OnboardingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 40, 24, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('읽고', style: TextStyle(fontSize: 40, fontWeight: FontWeight.w900, color: AppColors.primary)),
              const SizedBox(height: 8),
              Text(
                '어려운 글, 대신 읽고 알려드릴게요.',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 20),
              ),
              const SizedBox(height: 40),
              Text('어떻게 알려드릴까요?',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: AppColors.textSecondary)),
              const SizedBox(height: 16),
              _choice(
                context,
                emoji: '🟦',
                title: '쉬운 한국어로',
                subtitle: '어려운 말을 쉬운 우리말로 풀어드려요',
                onTap: () => _start(OutputMode.easyKorean, 'ko'),
              ),
              const SizedBox(height: 16),
              _choice(
                context,
                emoji: '🌏',
                title: 'In English',
                subtitle: 'Understand Korean documents in your language',
                onTap: () => _start(OutputMode.nativeLang, 'en'),
              ),
              const Spacer(),
              Text(
                '읽고는 보조 도구예요. 중요한 결정은 꼭 사람과 확인하세요.',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppColors.textSecondary),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _start(OutputMode mode, String lang) async {
    final profile = Get.find<ProfileService>();
    await profile.setProfile(outputMode: mode, language: lang);
    await profile.completeOnboarding();
    Get.offAllNamed(Routes.home);
  }

  Widget _choice(BuildContext context,
      {required String emoji,
      required String title,
      required String subtitle,
      required VoidCallback onTap}) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: AppColors.border, width: 1.5),
          ),
          child: Row(
            children: [
              Text(emoji, style: const TextStyle(fontSize: 34)),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title,
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge
                            ?.copyWith(fontSize: 22)),
                    const SizedBox(height: 4),
                    Text(subtitle,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: AppColors.textSecondary)),
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
