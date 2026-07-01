import 'package:freezed_annotation/freezed_annotation.dart';

part 'analysis_summary.freezed.dart';
part 'analysis_summary.g.dart';

/// Lightweight list-row model for the library (GET /analyses).
@freezed
abstract class AnalysisSummary with _$AnalysisSummary {
  const factory AnalysisSummary({
    required String id,
    @JsonKey(name: 'doc_type') String? docType,
    @JsonKey(name: 'summary_one_line') String? summaryOneLine,
    @JsonKey(name: 'top_risk_level') String? topRiskLevel,
    @JsonKey(name: 'card_deadline') String? cardDeadline,
    @JsonKey(name: 'created_at') required String createdAt,
  }) = _AnalysisSummary;

  factory AnalysisSummary.fromJson(Map<String, dynamic> json) =>
      _$AnalysisSummaryFromJson(json);
}

/// Wrapper for the paginated list response.
@freezed
abstract class AnalysisListResponse with _$AnalysisListResponse {
  const factory AnalysisListResponse({
    @Default(<AnalysisSummary>[]) List<AnalysisSummary> items,
    @JsonKey(name: 'next_cursor') String? nextCursor,
  }) = _AnalysisListResponse;

  factory AnalysisListResponse.fromJson(Map<String, dynamic> json) =>
      _$AnalysisListResponseFromJson(json);
}
