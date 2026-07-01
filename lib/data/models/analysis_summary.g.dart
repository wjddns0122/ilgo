// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'analysis_summary.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AnalysisSummary _$AnalysisSummaryFromJson(Map<String, dynamic> json) =>
    _AnalysisSummary(
      id: json['id'] as String,
      docType: json['doc_type'] as String?,
      summaryOneLine: json['summary_one_line'] as String?,
      topRiskLevel: json['top_risk_level'] as String?,
      cardDeadline: json['card_deadline'] as String?,
      createdAt: json['created_at'] as String,
    );

Map<String, dynamic> _$AnalysisSummaryToJson(_AnalysisSummary instance) =>
    <String, dynamic>{
      'id': instance.id,
      'doc_type': instance.docType,
      'summary_one_line': instance.summaryOneLine,
      'top_risk_level': instance.topRiskLevel,
      'card_deadline': instance.cardDeadline,
      'created_at': instance.createdAt,
    };

_AnalysisListResponse _$AnalysisListResponseFromJson(
  Map<String, dynamic> json,
) => _AnalysisListResponse(
  items:
      (json['items'] as List<dynamic>?)
          ?.map((e) => AnalysisSummary.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <AnalysisSummary>[],
  nextCursor: json['next_cursor'] as String?,
);

Map<String, dynamic> _$AnalysisListResponseToJson(
  _AnalysisListResponse instance,
) => <String, dynamic>{
  'items': instance.items,
  'next_cursor': instance.nextCursor,
};
