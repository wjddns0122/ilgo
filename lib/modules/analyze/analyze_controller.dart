import 'dart:typed_data';

import 'package:get/get.dart';

import '../../core/app_routes.dart';
import '../../data/models/analysis.dart';
import '../../data/models/enums.dart';
import '../../data/repositories/analysis_repository.dart';

/// Owns the current analysis result + loading/error state. Kept as a permanent
/// singleton so state survives home → loading → result navigation.
class AnalyzeController extends GetxController {
  AnalyzeController(this._repo);

  final AnalysisRepository _repo;

  final isLoading = false.obs;
  final result = Rxn<Analysis>();
  final error = RxnString();

  // Remembered for the retry button.
  Uint8List? _lastBytes;
  String _lastMediaType = 'image/jpeg';
  OutputMode _lastMode = OutputMode.easyKorean;
  String _lastLang = 'ko';

  /// Runs an analysis and drives navigation: show the loading screen, then
  /// replace it with the result on success (or surface an error to retry).
  Future<void> analyze({
    required Uint8List bytes,
    required String mediaType,
    required OutputMode mode,
    required String lang,
  }) async {
    _lastBytes = bytes;
    _lastMediaType = mediaType;
    _lastMode = mode;
    _lastLang = lang;

    isLoading.value = true;
    error.value = null;
    result.value = null;
    Get.toNamed(Routes.analyze);

    try {
      final analysis = await _repo.analyze(
        imageBytes: bytes,
        mediaType: mediaType,
        mode: mode,
        lang: lang,
      );
      result.value = analysis;
      isLoading.value = false;
      Get.offNamed(Routes.result); // replace loading screen
    } catch (_) {
      isLoading.value = false;
      error.value = '분석에 실패했어요. 다시 시도해 주세요.';
    }
  }

  Future<void> retry() async {
    final bytes = _lastBytes;
    if (bytes == null) {
      Get.back();
      return;
    }
    await analyze(
      bytes: bytes,
      mediaType: _lastMediaType,
      mode: _lastMode,
      lang: _lastLang,
    );
  }

  /// Open a previously saved analysis (from the library) on the result screen.
  void openSaved(Analysis analysis) {
    result.value = analysis;
    error.value = null;
    Get.toNamed(Routes.result);
  }

  /// Optimistic local toggle for the to-do checklist.
  void toggleAction(String id) {
    final current = result.value;
    if (current == null) return;
    result.value = current.copyWith(
      actions: [
        for (final a in current.actions)
          if (a.id == id) a.copyWith(isDone: !a.isDone) else a,
      ],
    );
  }
}
