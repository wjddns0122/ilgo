import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';

/// Thin wrapper over flutter_tts for the "낭독" (read aloud) feature.
class TtsService extends GetxService {
  final FlutterTts _tts = FlutterTts();
  final isSpeaking = false.obs;

  /// Fraction (0..1) of the current utterance spoken so far — drives the
  /// reading highlight + waveform on the listen screen.
  final progress = 0.0.obs;

  Future<TtsService> init() async {
    // Reliable completion + play even when the iOS ringer switch is silent.
    await _tts.awaitSpeakCompletion(true);
    try {
      await _tts.setSharedInstance(true);
      await _tts.setIosAudioCategory(
        IosTextToSpeechAudioCategory.playback,
        [
          IosTextToSpeechAudioCategoryOptions.defaultToSpeaker,
          IosTextToSpeechAudioCategoryOptions.mixWithOthers,
        ],
      );
    } catch (_) {
      // non-iOS platforms: no audio-category setup needed
    }
    _tts.setCompletionHandler(() {
      isSpeaking.value = false;
      progress.value = 1.0;
    });
    _tts.setCancelHandler(() => isSpeaking.value = false);
    _tts.setErrorHandler((_) => isSpeaking.value = false);
    _tts.setProgressHandler((text, start, end, word) {
      final len = text.length;
      if (len > 0) progress.value = (end / len).clamp(0.0, 1.0);
    });
    return this;
  }

  Future<void> speak(String text, {String lang = 'ko', double rate = 0.45}) async {
    if (text.trim().isEmpty) return;
    await _tts.stop();
    await _tts.setLanguage(_ttsLocale(lang));
    await _tts.setSpeechRate(rate.clamp(0.1, 1.0)); // slower = easier to follow
    progress.value = 0;
    isSpeaking.value = true;
    await _tts.speak(text);
  }

  /// Map an app language code to a flutter_tts locale (best-effort).
  String _ttsLocale(String lang) {
    switch (lang) {
      case 'en':
        return 'en-US';
      case 'vi':
        return 'vi-VN';
      case 'zh':
        return 'zh-CN';
      case 'th':
        return 'th-TH';
      case 'ne':
        return 'ne-NP';
      case 'km':
        return 'km-KH';
      case 'id':
        return 'id-ID';
      default:
        return 'ko-KR';
    }
  }

  Future<void> stop() async {
    await _tts.stop();
    isSpeaking.value = false;
  }

  @override
  void onClose() {
    _tts.stop();
    super.onClose();
  }
}
