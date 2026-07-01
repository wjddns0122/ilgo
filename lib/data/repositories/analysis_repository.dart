import 'dart:typed_data';

import '../models/analysis.dart';
import '../models/analysis_summary.dart';
import '../models/enums.dart';

/// The single seam the UI depends on. Swap Mock ↔ Api in [AppBinding] via
/// `Config.useMock` — no screen code changes.
abstract class AnalysisRepository {
  /// Send one image, get a structured [Analysis] back.
  Future<Analysis> analyze({
    required Uint8List imageBytes,
    required String mediaType,
    required OutputMode mode,
    required String lang,
  });

  /// Library list (most recent first).
  Future<List<AnalysisSummary>> list({String? cursor});

  /// Full detail for a saved analysis.
  Future<Analysis> getById(String id);

  /// Remove a saved analysis.
  Future<void> delete(String id);
}
