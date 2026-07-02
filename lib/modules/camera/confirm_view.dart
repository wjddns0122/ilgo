import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

import '../../core/responsive.dart';
import '../../core/theme.dart';
import '../home/home_controller.dart';

/// Capture-confirm screen (Figma node 17:1039): preview the photo and decide
/// whether to analyze it or retake. Shown after camera capture / gallery pick.
class ConfirmView extends StatelessWidget {
  const ConfirmView({super.key});

  @override
  Widget build(BuildContext context) {
    final args = Get.arguments;
    final XFile? file = args is XFile ? args : null;

    return Scaffold(
      backgroundColor: AppColors.paper,
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: kOnbMaxWidth),
            child: file == null
                ? _missing(context)
                : Padding(
                    padding: EdgeInsets.fromLTRB(
                      context.rs(28),
                      context.rs(24),
                      context.rs(28),
                      context.rs(24),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _header(context),
                        SizedBox(height: context.rs(20)),
                        Expanded(child: _preview(context, file)),
                        SizedBox(height: context.rs(16)),
                        Center(
                          child: Text(
                            '글자가 흐리면 다시 찍는 게 좋아요',
                            style: GoogleFonts.notoSansKr(
                              fontSize: context.rs(16),
                              color: AppColors.stone,
                            ),
                          ),
                        ),
                        SizedBox(height: context.rs(20)),
                        _buttons(context, file),
                      ],
                    ),
                  ),
          ),
        ),
      ),
    );
  }

  Widget _header(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '방금 찍은 사진',
          style: GoogleFonts.notoSansKr(
            fontSize: context.rs(18),
            fontWeight: FontWeight.w600,
            color: AppColors.stone,
          ),
        ),
        SizedBox(height: context.rs(8)),
        Text(
          '이 사진으로 읽어드릴까요?',
          style: GoogleFonts.notoSansKr(
            fontSize: context.rs(30),
            height: 1.3,
            fontWeight: FontWeight.w700,
            letterSpacing: -0.3,
            color: AppColors.ink,
          ),
        ),
      ],
    );
  }

  Widget _preview(BuildContext context, XFile file) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.hairline),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF281E0F).withValues(alpha: 0.08),
            blurRadius: 13,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned.fill(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.file(
                File(file.path),
                fit: BoxFit.cover,
                errorBuilder: (_, _, _) => Center(
                  child: Icon(
                    Icons.image_not_supported_outlined,
                    color: AppColors.stone,
                    size: context.rs(40),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            right: context.rs(16),
            bottom: context.rs(16),
            child: _sharpBadge(context),
          ),
        ],
      ),
    );
  }

  Widget _sharpBadge(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: context.rs(16),
        vertical: context.rs(8),
      ),
      decoration: BoxDecoration(
        color: const Color(0xFFE8F0EA),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.check, size: context.rs(18), color: AppColors.forest),
          SizedBox(width: context.rs(6)),
          Text(
            '글자가 또렷해요',
            style: GoogleFonts.notoSansKr(
              fontSize: context.rs(15),
              fontWeight: FontWeight.w700,
              color: AppColors.forest,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buttons(BuildContext context, XFile file) {
    return Row(
      children: [
        Expanded(
          flex: 157,
          child: _button(
            context,
            label: '다시 찍기',
            filled: false,
            onTap: () => Get.back(),
          ),
        ),
        SizedBox(width: context.rs(12)),
        Expanded(
          flex: 221,
          child: _button(
            context,
            label: '이 사진 쓰기',
            filled: true,
            onTap: () => Get.find<HomeController>().analyzeXFile(file),
          ),
        ),
      ],
    );
  }

  Widget _button(
    BuildContext context, {
    required String label,
    required bool filled,
    required VoidCallback onTap,
  }) {
    return Material(
      color: filled ? AppColors.forest : Colors.transparent,
      borderRadius: BorderRadius.circular(10),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10),
        child: Container(
          height: context.rs(64),
          alignment: Alignment.center,
          decoration: filled
              ? null
              : BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: AppColors.hairline),
                ),
          child: Text(
            label,
            style: GoogleFonts.notoSansKr(
              fontSize: context.rs(18),
              fontWeight: FontWeight.w700,
              color: filled ? AppColors.paper : const Color(0xFF4A4439),
            ),
          ),
        ),
      ),
    );
  }

  Widget _missing(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '사진을 찾을 수 없어요.',
            style: GoogleFonts.notoSansKr(
              fontSize: context.rs(16),
              color: AppColors.stone,
            ),
          ),
          SizedBox(height: context.rs(16)),
          OutlinedButton(
            onPressed: () => Get.back(),
            child: const Text('돌아가기'),
          ),
        ],
      ),
    );
  }
}
