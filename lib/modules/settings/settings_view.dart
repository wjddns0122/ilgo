import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/app_routes.dart';
import '../../core/responsive.dart';
import '../../core/theme.dart';
import '../../data/models/enums.dart';
import '../../data/services/profile_service.dart';
import 'settings_controller.dart';

/// Settings screen (Figma node 17:1167): reading-method + app groups.
class SettingsView extends GetView<SettingsController> {
  const SettingsView({super.key});

  ProfileService get _profile => controller.profile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.paper,
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: kOnbMaxWidth),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _header(context),
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: context.rs(26)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: context.rs(8)),
                          _readingGroup(context),
                          SizedBox(height: context.rs(29)),
                          _appGroup(context),
                          SizedBox(height: context.rs(24)),
                          _logoutButton(context),
                          SizedBox(height: context.rs(32)),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _header(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        context.rs(15),
        context.rs(15),
        context.rs(28),
        context.rs(8),
      ),
      child: Row(
        children: [
          SizedBox(
            width: context.rs(22),
            height: context.rs(22),
            child: IconButton(
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
              iconSize: context.rs(22),
              icon: const Icon(Icons.arrow_back, color: AppColors.ink),
              onPressed: () => Get.back(),
            ),
          ),
          SizedBox(width: context.rs(16)),
          Text(
            '설정',
            style: GoogleFonts.notoSansKr(
              fontSize: context.rs(18.4),
              height: 1.5,
              fontWeight: FontWeight.w700,
              letterSpacing: -0.184,
              color: AppColors.forest,
            ),
          ),
        ],
      ),
    );
  }

  // ── Groups ──────────────────────────────────────────────────────────────
  Widget _readingGroup(BuildContext context) {
    return _group(context, '읽는 방식', [
      _row(
        context,
        title: '읽기 방식',
        value: Obx(() => _valueText(context, controller.modeLabel)),
        onTap: () => _pickMode(context),
      ),
      _row(
        context,
        title: '내 언어',
        value: Obx(() => _valueText(context, _profile.langLabel)),
        onTap: () => Get.toNamed(Routes.language),
      ),
      _row(
        context,
        title: '글씨 크기',
        value: Obx(() => _valueText(context, _profile.textScaleLabel)),
        onTap: () => Get.toNamed(Routes.textSize),
      ),
    ]);
  }

  Widget _appGroup(BuildContext context) {
    return _group(context, '앱', [
      _row(
        context,
        title: '권한 · 카메라',
        value: Obx(() {
          final granted = controller.cameraGranted.value;
          final label = granted == null
              ? '확인 중'
              : (granted ? '허용됨' : '허용 필요');
          final color = granted == null
              ? AppColors.stone
              : (granted ? const Color(0xFF3B7A57) : AppColors.riskYellow);
          return Text(
            label,
            style: GoogleFonts.notoSansKr(
              fontSize: context.rs(17),
              fontWeight: FontWeight.w700,
              color: color,
            ),
          );
        }),
        onTap: controller.openPermissionSettings,
      ),
      _row(
        context,
        title: '기한 알림',
        value: Obx(() =>
            _valueText(context, _profile.deadlineAlarm.value ? '켜짐' : '꺼짐')),
        onTap: () => controller.setAlarm(!_profile.deadlineAlarm.value),
      ),
      _row(
        context,
        title: '도움받을 곳',
        titleColor: AppColors.forest,
        value: const SizedBox.shrink(),
        onTap: () => Get.toNamed(Routes.help),
      ),
    ]);
  }

  // ── Logout ────────────────────────────────────────────────────────────
  Widget _logoutButton(BuildContext context) {
    return Material(
      color: AppColors.card,
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: () => _confirmLogout(context),
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: context.rs(20)),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AppColors.hairline),
          ),
          alignment: Alignment.center,
          child: Text(
            '로그아웃',
            style: GoogleFonts.notoSansKr(
              fontSize: context.rs(19),
              fontWeight: FontWeight.w700,
              color: AppColors.riskRed,
            ),
          ),
        ),
      ),
    );
  }

  void _confirmLogout(BuildContext context) {
    Get.dialog(
      AlertDialog(
        backgroundColor: AppColors.paper,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(
          '로그아웃할까요?',
          style: GoogleFonts.notoSansKr(
            fontSize: context.rs(20),
            fontWeight: FontWeight.w700,
            color: AppColors.ink,
          ),
        ),
        content: Text(
          '다시 이용하려면 이메일로 로그인해야 해요.',
          style: GoogleFonts.notoSansKr(
            fontSize: context.rs(16),
            height: 1.5,
            color: AppColors.stone,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text(
              '취소',
              style: GoogleFonts.notoSansKr(
                fontSize: context.rs(16),
                fontWeight: FontWeight.w600,
                color: AppColors.stone,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              Get.back(); // close dialog first
              controller.logout();
            },
            child: Text(
              '로그아웃',
              style: GoogleFonts.notoSansKr(
                fontSize: context.rs(16),
                fontWeight: FontWeight.w700,
                color: AppColors.riskRed,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _group(BuildContext context, String label, List<Widget> rows) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: context.rs(10), bottom: context.rs(10)),
          child: Text(
            label,
            style: GoogleFonts.notoSansKr(
              fontSize: context.rs(15),
              fontWeight: FontWeight.w700,
              letterSpacing: 0.9,
              color: AppColors.stone,
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: AppColors.card,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AppColors.hairline),
          ),
          child: Column(
            children: [
              for (var i = 0; i < rows.length; i++) ...[
                if (i > 0)
                  Divider(height: 1, color: AppColors.hairline),
                rows[i],
              ],
            ],
          ),
        ),
      ],
    );
  }

  Widget _row(
    BuildContext context, {
    required String title,
    required Widget value,
    required VoidCallback onTap,
    Color? titleColor,
    bool chevron = true,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: context.rs(23), vertical: context.rs(20)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  title,
                  style: GoogleFonts.notoSansKr(
                    fontSize: context.rs(19),
                    fontWeight: FontWeight.w600,
                    color: titleColor ?? AppColors.ink,
                  ),
                ),
              ),
              value,
              if (chevron) ...[
                SizedBox(width: context.rs(4)),
                Icon(Icons.chevron_right,
                    size: context.rs(22), color: AppColors.stone),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _valueText(BuildContext context, String text) {
    return Text(
      text,
      style: GoogleFonts.notoSansKr(
          fontSize: context.rs(17), color: AppColors.stone),
    );
  }

  // ── Pickers ───────────────────────────────────────────────────────────
  void _pickMode(BuildContext context) {
    _sheet(context, '읽기 방식', [
      _option(context, '쉬운 한국어', controller.mode == OutputMode.easyKorean,
          () => controller.setMode(OutputMode.easyKorean)),
      _option(context, '내 언어로', controller.mode == OutputMode.nativeLang,
          () => controller.setMode(OutputMode.nativeLang)),
    ]);
  }

  void _sheet(BuildContext context, String title, List<Widget> options) {
    Get.bottomSheet(
      Container(
        padding: EdgeInsets.fromLTRB(
            context.rs(20), context.rs(12), context.rs(20), context.rs(24)),
        decoration: const BoxDecoration(
          color: AppColors.paper,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: context.rs(40),
                height: 4,
                margin: EdgeInsets.only(bottom: context.rs(16)),
                decoration: BoxDecoration(
                  color: AppColors.hairline,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            Text(title,
                style: GoogleFonts.notoSansKr(
                    fontSize: context.rs(16),
                    fontWeight: FontWeight.w700,
                    color: AppColors.stone)),
            SizedBox(height: context.rs(8)),
            ...options,
          ],
        ),
      ),
      isScrollControlled: true,
    );
  }

  Widget _option(
      BuildContext context, String label, bool selected, VoidCallback onTap) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          onTap();
          Get.back();
        },
        borderRadius: BorderRadius.circular(10),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: context.rs(14), horizontal: context.rs(8)),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  label,
                  style: GoogleFonts.notoSansKr(
                    fontSize: context.rs(18),
                    fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
                    color: selected ? AppColors.forest : AppColors.ink,
                  ),
                ),
              ),
              if (selected)
                Icon(Icons.check, color: AppColors.forest, size: context.rs(22)),
            ],
          ),
        ),
      ),
    );
  }
}
