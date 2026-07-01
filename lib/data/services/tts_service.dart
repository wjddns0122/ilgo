import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';

/// Thin wrapper over flutter_tts for the "낭독" (read aloud) feature.
class TtsService extends GetxService {
  final FlutterTts _tts = FlutterTts();
  final isSpeaking = false.obs;

  Future<TtsService> init() async {
    _tts.setCompletionHandler(() => isSpeaking.value = false);
    _tts.setCancelHandler(() => isSpeaking.value = false);
    _tts.setErrorHandler((_) => isSpeaking.value = false);
    return this;
  }

  Future<void> speak(String text, {String lang = 'ko'}) async {
    if (text.trim().isEmpty) return;
    await _tts.stop();
    await _tts.setLanguage(lang == 'en' ? 'en-US' : 'ko-KR');
    await _tts.setSpeechRate(0.45); // slower = easier to follow
    isSpeaking.value = true;
    await _tts.speak(text);
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
