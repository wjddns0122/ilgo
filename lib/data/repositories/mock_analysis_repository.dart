import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/services.dart' show rootBundle;

import '../models/analysis.dart';
import '../models/analysis_summary.dart';
import '../models/enums.dart';
import '../models/reply_draft.dart';
import 'analysis_repository.dart';

/// Serves the bundled `assets/mock/*.json` so the whole app runs with no
/// backend. Also used as the live-failure fallback cache during the demo.
class MockAnalysisRepository implements AnalysisRepository {
  static const _health = 'assets/mock/analyze_easy_health.json';
  static const _wage = 'assets/mock/analyze_native_wage.json';
  static const _fine = 'assets/mock/analyze_easy_fine.json';
  static const _list = 'assets/mock/list.json';

  /// Demo-only: the native "wage" explanation localized per mother tongue.
  /// A real backend returns the translation directly. Unknown languages fall
  /// back to the JSON's English text (edge case).
  static const _wageExplainedByLang = <String, String>{
    'km':
        'ថ្ងៃស្អែក ត្រូវមកម៉ោង ៥ ព្រឹក។ បើយឺត គេនឹងកាត់ប្រាក់ឈ្នួល។ អ្នកគ្រប់គ្រងនិយាយថានឹងកាត់ថ្លៃស្នាក់នៅ ១៥ម៉ឺនវ៉ុន ក្នុងខែនេះ។',
    'vi':
        'Ngày mai hãy đến trước kho lúc 5 giờ sáng. Nếu đến muộn, họ sẽ trừ tiền công trong ngày. Quản lý còn nói sẽ trừ 150.000 won tiền ở trọ trong tháng này.',
    'ne':
        'भोलि बिहान ५ बजे गोदाम अगाडि आउनू। ढिलो भए ज्यालाबाट कटौती गरिन्छ। यस महिना बासको १५०,००० वोन तलबबाट काटिने पनि भनिएको छ।',
  };

  Future<Map<String, dynamic>> _load(String path) async {
    final raw = await rootBundle.loadString(path);
    return jsonDecode(raw) as Map<String, dynamic>;
  }

  @override
  Future<Analysis> analyze({
    required Uint8List imageBytes,
    required String mediaType,
    required OutputMode mode,
    required String lang,
  }) async {
    await Future<void>.delayed(const Duration(seconds: 2)); // show loading UI
    final path = mode == OutputMode.nativeLang ? _wage : _health;
    final analysis = Analysis.fromJson(await _load(path));
    if (mode == OutputMode.nativeLang) {
      // Localize the explanation to the chosen mother tongue for the demo.
      return analysis.copyWith(
        lang: lang,
        explainedText: _wageExplainedByLang[lang] ?? analysis.explainedText,
      );
    }
    return analysis;
  }

  @override
  Future<List<AnalysisSummary>> list({String? cursor}) async {
    final json = await _load(_list);
    return AnalysisListResponse.fromJson(json).items;
  }

  @override
  Future<Analysis> getById(String id) async {
    const byId = {
      'anl_0001': _health,
      'anl_0002': _wage,
      'anl_0003': _fine,
    };
    return Analysis.fromJson(await _load(byId[id] ?? _health));
  }

  @override
  Future<void> delete(String id) async {
    // No persistence in mock mode.
  }

  @override
  Future<void> toggleAction(
      String analysisId, String actionId, bool isDone) async {
    // No-op in mock mode (state kept client-side).
  }

  @override
  Future<List<ReplyDraft>> regenerateReplies(String analysisId,
          {String? tone}) async =>
      const <ReplyDraft>[];
}
