import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
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

  /// True while reply drafts are being regenerated.
  final isRegenerating = false.obs;

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
    // Show loading over home — drop camera/confirm so "back" from the result
    // returns to the main page, not the capture-confirm screen.
    Get.offNamedUntil(
      Routes.analyze,
      (route) => route.settings.name == Routes.home,
    );

    try {
      final analysis = await _repo.analyze(
        imageBytes: bytes,
        mediaType: mediaType,
        mode: mode,
        lang: lang,
      );
      result.value = analysis;
      isLoading.value = false;
      // Edge cases:
      // - failed: engine couldn't read the image (blurry) → retake tips.
      // - unknown doc type: probably not a document → "무슨 글인지 모르겠어요".
      if (analysis.status == 'failed') {
        Get.offNamed(Routes.unreadable);
      } else if (_isUnknownDoc(analysis)) {
        Get.offNamed(Routes.notADocument);
      } else {
        Get.offNamed(Routes.result); // replace loading screen
      }
    } catch (e) {
      isLoading.value = false;
      if (_isNetworkError(e)) {
        Get.offNamed(Routes.connectionFailed); // photo kept for retry
      } else {
        error.value = '분석에 실패했어요. 다시 시도해 주세요.';
        Get.offNamed(Routes.unreadable);
      }
    }
  }

  /// True when the failure looks like a network / connectivity problem.
  bool _isNetworkError(Object e) {
    if (e is SocketException) return true;
    if (e is DioException) {
      const netTypes = {
        DioExceptionType.connectionError,
        DioExceptionType.connectionTimeout,
        DioExceptionType.receiveTimeout,
        DioExceptionType.sendTimeout,
      };
      return netTypes.contains(e.type);
    }
    return false;
  }

  /// True when the engine couldn't identify a supported document type.
  bool _isUnknownDoc(Analysis a) {
    final raw = a.docType?.trim();
    if (raw == null || raw.isEmpty) return true;
    const unknown = {'기타', '알 수 없음', '알수없음', 'unknown', 'other'};
    return unknown.contains(raw) || unknown.contains(raw.toLowerCase());
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

  /// Optimistic local toggle for the to-do checklist, best-effort synced to
  /// the server.
  void toggleAction(String id) {
    final current = result.value;
    if (current == null) return;
    final updated = [
      for (final a in current.actions)
        if (a.id == id) a.copyWith(isDone: !a.isDone) else a,
    ];
    result.value = current.copyWith(actions: updated);
    final item = updated.where((a) => a.id == id).firstOrNull;
    if (item == null) return;
    unawaited(_repo
        .toggleAction(current.id, id, item.isDone)
        .catchError((_) {})); // keep the optimistic state on failure
  }

  /// Regenerate reply drafts (native mode) with an optional tone
  /// ('polite' | 'short'). Keeps the current drafts when nothing comes back.
  Future<void> regenerateReplies({String? tone}) async {
    final current = result.value;
    if (current == null || isRegenerating.value) return;
    isRegenerating.value = true;
    try {
      final drafts = await _repo.regenerateReplies(current.id, tone: tone);
      if (drafts.isEmpty) {
        Get.snackbar('알림', '지금은 새 답장을 만들지 못했어요.');
      } else {
        result.value = result.value?.copyWith(replyDrafts: drafts);
      }
    } catch (_) {
      Get.snackbar('알림', '답장을 다시 만들지 못했어요. 잠시 후 다시 시도해 주세요.');
    } finally {
      isRegenerating.value = false;
    }
  }
}
