import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/app_routes.dart';
import '../../core/responsive.dart';
import '../../core/theme.dart';

/// Edge-case screen (Figma node 30:1220): the engine couldn't tell what kind
/// of text this is (probably not a document). Offers "그래도 풀이" (analyze
/// anyway — a result is already stored) or "다시 찍기".
class NotADocumentView extends StatelessWidget {
  const NotADocumentView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.paper,
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: kOnbMaxWidth),
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                  context.rs(28), context.rs(24), context.rs(28), context.rs(24)),
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(height: context.rs(40)),
                          _badge(context),
                          SizedBox(height: context.rs(20)),
                          Text(
                            '무슨 글인지\n잘 모르겠어요',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.notoSansKr(
                              fontSize: context.rs(31),
                              height: 1.35,
                              fontWeight: FontWeight.w700,
                              color: AppColors.ink,
                            ),
                          ),
                          SizedBox(height: context.rs(16)),
                          Text(
                            '고지서·안내문·메시지가 아닌 것 같아요.\n글자가 있는 종이나 화면을 찍어주세요.',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.notoSansKr(
                              fontSize: context.rs(18),
                              height: 1.6,
                              color: AppColors.stone,
                            ),
                          ),
                          SizedBox(height: context.rs(28)),
                          _readableCard(context),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: context.rs(16)),
                  _buttons(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _badge(BuildContext context) {
    final s = context.rs(112);
    return Container(
      width: s,
      height: s,
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        color: AppColors.sand,
        shape: BoxShape.circle,
      ),
      child: Icon(Icons.help_outline, size: context.rs(52), color: AppColors.ink),
    );
  }

  Widget _readableCard(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
          horizontal: context.rs(24), vertical: context.rs(22)),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.hairline),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '읽을 수 있는 것',
            style: GoogleFonts.notoSansKr(
              fontSize: context.rs(16),
              fontWeight: FontWeight.w700,
              color: AppColors.stone,
            ),
          ),
          SizedBox(height: context.rs(10)),
          Text(
            '고지서 · 안내문 · 계약서',
            style: GoogleFonts.notoSansKr(
                fontSize: context.rs(18), height: 1.7, color: AppColors.ink),
          ),
          Text(
            '문자 · 카톡 · 공지 캡처',
            style: GoogleFonts.notoSansKr(
                fontSize: context.rs(18), height: 1.7, color: AppColors.ink),
          ),
        ],
      ),
    );
  }

  Widget _buttons(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 172,
          child: _button(
            context,
            label: '그래도 풀이',
            filled: false,
            // A low-confidence result is already stored — show it anyway.
            onTap: () => Get.offNamed(Routes.result),
          ),
        ),
        SizedBox(width: context.rs(12)),
        Expanded(
          flex: 206,
          child: _button(
            context,
            label: '다시 찍기',
            filled: true,
            onTap: () {
              Get.offAllNamed(Routes.home);
              Get.toNamed(Routes.camera);
            },
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
              color: filled ? AppColors.paper : AppColors.ink,
            ),
          ),
        ),
      ),
    );
  }
}
