import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../core/responsive.dart';
import '../core/theme.dart';
import '../data/models/analysis.dart';
import '../data/models/tobagi.dart';
import '../data/services/tts_service.dart';

/// 또바기 "쉬운 보기" — the result-screen companion (FE-3). Sits *below* the
/// existing TTS block, adding a second, character-led channel: 들려주기 (기존
/// TTS) + 쉽게 보여주기 (또바기). The cheek ring mirrors the risk light; tapping
/// reads the summary aloud (tap-to-play, never autoplay).
///
/// A pure layer (guardrail G4): the art has an [Image.errorBuilder] fallback and
/// TTS is looked up defensively, so a missing asset or unregistered service
/// degrades gracefully — the app never crashes and stays fully usable.
class TobagiEasyView extends StatelessWidget {
  const TobagiEasyView(this.analysis, {super.key});

  final Analysis analysis;

  Color _cheek(TobagiState s) {
    switch (s) {
      case TobagiState.warn:
      case TobagiState.victim:
        return const Color(0xFFB04A3A);
      case TobagiState.caution:
        return const Color(0xFFC0902A);
      case TobagiState.safe:
      case TobagiState.cheer:
        return const Color(0xFF3B7A57);
      default:
        return AppColors.forest;
    }
  }

  void _speak(String text) {
    if (!Get.isRegistered<TtsService>()) return;
    final lang = analysis.outputMode == 'native' ? analysis.lang : 'ko';
    Get.find<TtsService>().speak(text, lang: lang);
  }

  @override
  Widget build(BuildContext context) {
    final allDone =
        analysis.actions.isNotEmpty && analysis.actions.every((e) => e.isDone);
    final line = tobagiResultLine(analysis, allActionsDone: allDone);
    final summary = analysis.summaryOneLine?.trim() ?? '';
    final cheek = _cheek(line.state);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(context.rs(18)),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: cheek.withValues(alpha: 0.4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _avatar(context, line.state, cheek),
              SizedBox(width: context.rs(14)),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '또바기',
                      style: GoogleFonts.notoSansKr(
                        fontSize: context.rs(13),
                        fontWeight: FontWeight.w700,
                        color: cheek,
                      ),
                    ),
                    SizedBox(height: context.rs(4)),
                    Text(
                      line.caption,
                      style: GoogleFonts.notoSansKr(
                        fontSize: context.rs(17),
                        height: 1.5,
                        color: AppColors.ink,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (summary.isNotEmpty) ...[
            SizedBox(height: context.rs(14)),
            Text(
              summary,
              style: GoogleFonts.notoSansKr(
                fontSize: context.rs(20),
                height: 1.5,
                fontWeight: FontWeight.w700,
                color: AppColors.ink,
              ),
            ),
            SizedBox(height: context.rs(12)),
            _hearButton(context, () => _speak(line.speakText)),
          ],
        ],
      ),
    );
  }

  Widget _avatar(BuildContext context, TobagiState state, Color cheek) {
    final size = context.rs(64);
    Widget img(TobagiState s) => ClipOval(
          child: Image.asset(
            tobagiAsset(s),
            width: size,
            height: size,
            fit: BoxFit.cover,
            errorBuilder: (_, _, _) => SizedBox(width: size, height: size),
          ),
        );
    // While 또바기 is speaking, show the "reading" art. Falls back to the plain
    // state art if TTS isn't registered (e.g. some tests / headless).
    final inner = Get.isRegistered<TtsService>()
        ? Obx(() => img(Get.find<TtsService>().isSpeaking.value
            ? TobagiState.reading
            : state))
        : img(state);
    return Container(
      width: size + context.rs(8),
      height: size + context.rs(8),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: cheek, width: 2.5),
      ),
      child: inner,
    );
  }

  Widget _hearButton(BuildContext context, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
            horizontal: context.rs(16), vertical: context.rs(11)),
        decoration: BoxDecoration(
          color: AppColors.forest,
          borderRadius: BorderRadius.circular(999),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.volume_up, size: context.rs(20), color: AppColors.paper),
            SizedBox(width: context.rs(8)),
            Text(
              '또바기가 읽어줄게요',
              style: GoogleFonts.notoSansKr(
                fontSize: context.rs(15),
                fontWeight: FontWeight.w700,
                color: AppColors.paper,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
