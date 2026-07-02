import 'dart:typed_data';

import '../models/analysis.dart';
import '../models/analysis_summary.dart';
import '../models/enums.dart';
import '../models/reply_draft.dart';

/// The single seam the UI depends on. Backed by the live API
/// ([ApiAnalysisRepository]), wired in [AppBinding].
abstract class AnalysisRepository {
  /// Send one image, get a structured [Analysis] back. [hint] is optional
  /// free-text context the user gives about the document.
  Future<Analysis> analyze({
    required Uint8List imageBytes,
    required String mediaType,
    required OutputMode mode,
    required String lang,
    String? hint,
  });

  /// Library list (most recent first).
  Future<List<AnalysisSummary>> list({String? cursor});

  /// Full detail for a saved analysis.
  Future<Analysis> getById(String id);

  /// Remove a saved analysis.
  Future<void> delete(String id);

  /// Toggle a to-do's done state (server-synced).
  Future<void> toggleAction(String analysisId, String actionId, bool isDone);

  /// Regenerate reply drafts (native only).
  Future<List<ReplyDraft>> regenerateReplies(String analysisId, {String? tone});

  /// Rate an analysis (👍/👎) with an optional free-text reason.
  Future<void> feedback(String analysisId,
      {required bool isHelpful, String? reason});
}
