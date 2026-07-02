import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/app_routes.dart';
import '../../core/responsive.dart';
import '../../core/theme.dart';

/// Edge-case screen (Figma node 17:1110): the engine couldn't read the image
/// (blurry, or not a document). Shows retake tips and a "다시 찍기" button.
///
/// Title/message can be overridden via Get.arguments {title, message} to reuse
/// this for the "고지서가 아닌 것 같아요" case.
class UnreadableView extends StatelessWidget {
  const UnreadableView({super.key});

  @override
  Widget build(BuildContext context) {
    final args = Get.arguments;
    final title = (args is Map && args['title'] is String)
        ? args['title'] as String
        : '글자가 잘\n안 보여요';
    final message = (args is Map && args['message'] is String)
        ? args['message'] as String
        : '사진이 흐려서 뜻을 풀기 어려워요.\n다시 한 번 찍어주세요.';

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
                            title,
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
                            message,
                            textAlign: TextAlign.center,
                            style: GoogleFonts.notoSansKr(
                              fontSize: context.rs(18),
                              height: 1.6,
                              color: AppColors.stone,
                            ),
                          ),
                          SizedBox(height: context.rs(36)),
                          _tips(context),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: context.rs(16)),
                  _retakeButton(context),
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
        color: Color(0xFFF0E4C6),
        shape: BoxShape.circle,
      ),
      child: Icon(Icons.search, size: context.rs(50), color: AppColors.ink),
    );
  }

  Widget _tips(BuildContext context) {
    const tips = [
      (Icons.lightbulb_outline, '밝은 곳에서 찍어요'),
      (Icons.straighten, '종이를 평평하게 펴요'),
      (Icons.stay_current_portrait_outlined, '글자가 또렷해질 때까지 기다려요'),
    ];
    return Container(
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.hairline),
      ),
      padding: EdgeInsets.symmetric(vertical: context.rs(6)),
      child: Column(
        children: [
          for (var i = 0; i < tips.length; i++) ...[
            if (i > 0) Divider(height: 1, color: AppColors.hairline, indent: context.rs(20), endIndent: context.rs(20)),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: context.rs(22), vertical: context.rs(18)),
              child: Row(
                children: [
                  Icon(tips[i].$1, size: context.rs(26), color: AppColors.forest),
                  SizedBox(width: context.rs(16)),
                  Expanded(
                    child: Text(
                      tips[i].$2,
                      style: GoogleFonts.notoSansKr(
                        fontSize: context.rs(17),
                        fontWeight: FontWeight.w600,
                        color: AppColors.ink,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _retakeButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Material(
        color: AppColors.forest,
        borderRadius: BorderRadius.circular(10),
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: () {
            // Return to home, then reopen the camera to retake.
            Get.offAllNamed(Routes.home);
            Get.toNamed(Routes.camera);
          },
          child: Container(
            height: context.rs(72),
            alignment: Alignment.center,
            child: Text(
              '다시 찍기',
              style: GoogleFonts.notoSansKr(
                fontSize: context.rs(20),
                fontWeight: FontWeight.w700,
                color: AppColors.paper,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
