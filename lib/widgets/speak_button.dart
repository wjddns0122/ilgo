import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../data/services/tts_service.dart';

/// Read-aloud button. Toggles between speaking and stopped state.
class SpeakButton extends StatelessWidget {
  const SpeakButton({
    super.key,
    required this.text,
    this.lang = 'ko',
    this.label,
  });

  final String text;
  final String lang;
  final String? label;

  @override
  Widget build(BuildContext context) {
    final tts = Get.find<TtsService>();
    final defaultLabel = lang == 'en' ? 'Listen' : '들어보기';
    return Obx(() {
      final speaking = tts.isSpeaking.value;
      return OutlinedButton.icon(
        onPressed: () => speaking ? tts.stop() : tts.speak(text, lang: lang),
        icon: Icon(speaking ? Icons.stop_circle : Icons.volume_up, size: 24),
        label: Text(speaking ? (lang == 'en' ? 'Stop' : '멈춤') : (label ?? defaultLabel)),
      );
    });
  }
}
