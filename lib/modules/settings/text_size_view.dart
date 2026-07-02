import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/responsive.dart';
import '../../core/theme.dart';
import '../../data/services/profile_service.dart';
import '../../widgets/text_size_picker.dart';

/// Text-size screen (Figma node 17:1292): live preview + 4-step slider.
/// Applies app-wide via [ProfileService.textScale] (wired in main.dart).
/// The preview + slider live in the shared [TextSizePicker] widget, reused by
/// the onboarding step.
class TextSizeView extends StatefulWidget {
  const TextSizeView({super.key});

  @override
  State<TextSizeView> createState() => _TextSizeViewState();
}

class _TextSizeViewState extends State<TextSizeView> {
  final ProfileService _profile = Get.find<ProfileService>();
  late double _scale = _profile.textScale.value;

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
                      padding: EdgeInsets.symmetric(horizontal: context.rs(28)),
                      child: Column(
                        children: [
                          SizedBox(height: context.rs(8)),
                          TextSizePicker(
                            initialScale: _profile.textScale.value,
                            onChanged: (s) => _scale = s,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(context.rs(28), context.rs(8),
                      context.rs(28), context.rs(24)),
                  child: _confirmButton(context),
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
          context.rs(15), context.rs(15), context.rs(28), context.rs(8)),
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
            '글씨 크기',
            style: GoogleFonts.notoSansKr(
              fontSize: context.rs(18.4),
              fontWeight: FontWeight.w700,
              letterSpacing: -0.184,
              color: AppColors.forest,
            ),
          ),
        ],
      ),
    );
  }

  Widget _confirmButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Material(
        color: AppColors.forest,
        borderRadius: BorderRadius.circular(10),
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: () async {
            await _profile.setTextScale(_scale);
            Get.back();
          },
          child: Container(
            height: context.rs(64),
            alignment: Alignment.center,
            child: Text(
              '이 크기로 할게요',
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
