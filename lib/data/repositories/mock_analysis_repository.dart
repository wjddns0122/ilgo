import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/services.dart' show rootBundle;

import '../models/analysis.dart';
import '../models/analysis_summary.dart';
import '../models/enums.dart';
import 'analysis_repository.dart';

/// Serves the bundled `assets/mock/*.json` so the whole app runs with no
/// backend. Also used as the live-failure fallback cache during the demo.
class MockAnalysisRepository implements AnalysisRepository {
  static const _health = 'assets/mock/analyze_easy_health.json';
  static const _wage = 'assets/mock/analyze_native_wage.json';
  static const _fine = 'assets/mock/analyze_easy_fine.json';
  static const _list = 'assets/mock/list.json';

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
    return Analysis.fromJson(await _load(path));
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
}
