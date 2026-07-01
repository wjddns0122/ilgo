import 'dart:convert';
import 'dart:typed_data';

import '../api/analyze_request.dart';
import '../api/ilgo_api.dart';
import '../models/analysis.dart';
import '../models/analysis_summary.dart';
import '../models/enums.dart';
import 'analysis_repository.dart';

/// Live implementation backed by the Spring/Railway API via retrofit.
class ApiAnalysisRepository implements AnalysisRepository {
  ApiAnalysisRepository(this._api);

  final IlgoApi _api;

  @override
  Future<Analysis> analyze({
    required Uint8List imageBytes,
    required String mediaType,
    required OutputMode mode,
    required String lang,
  }) {
    return _api.analyze(AnalyzeRequest(
      imageBase64: base64Encode(imageBytes),
      mediaType: mediaType,
      outputMode: mode.wire,
      lang: lang,
    ));
  }

  @override
  Future<List<AnalysisSummary>> list({String? cursor}) async {
    final res = await _api.list(cursor);
    return res.items;
  }

  @override
  Future<Analysis> getById(String id) => _api.getById(id);

  @override
  Future<void> delete(String id) => _api.delete(id);
}
