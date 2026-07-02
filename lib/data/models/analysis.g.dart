// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'analysis.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Analysis _$AnalysisFromJson(Map<String, dynamic> json) => _Analysis(
  id: json['id'] as String? ?? '',
  status: json['status'] as String,
  outputMode: json['output_mode'] as String,
  lang: json['lang'] as String,
  docType: json['doc_type'] as String?,
  docClass: json['doc_class'] as String?,
  isDocument: json['is_document'] as bool?,
  characterState: json['character_state'] as String?,
  characterLine: json['character_line'] as String?,
  summaryOneLine: json['summary_one_line'] as String?,
  originalText: json['original_text'] as String?,
  explainedText: json['explained_text'] as String?,
  consequence: json['consequence'] as String?,
  cards: json['cards'] == null
      ? null
      : Cards.fromJson(json['cards'] as Map<String, dynamic>),
  risks:
      (json['risks'] as List<dynamic>?)
          ?.map((e) => Risk.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <Risk>[],
  actions:
      (json['actions'] as List<dynamic>?)
          ?.map((e) => ActionItem.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <ActionItem>[],
  replyDrafts:
      (json['reply_drafts'] as List<dynamic>?)
          ?.map((e) => ReplyDraft.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <ReplyDraft>[],
  createdAt: json['created_at'] as String? ?? '',
);

Map<String, dynamic> _$AnalysisToJson(_Analysis instance) => <String, dynamic>{
  'id': instance.id,
  'status': instance.status,
  'output_mode': instance.outputMode,
  'lang': instance.lang,
  'doc_type': instance.docType,
  'doc_class': instance.docClass,
  'is_document': instance.isDocument,
  'character_state': instance.characterState,
  'character_line': instance.characterLine,
  'summary_one_line': instance.summaryOneLine,
  'original_text': instance.originalText,
  'explained_text': instance.explainedText,
  'consequence': instance.consequence,
  'cards': instance.cards,
  'risks': instance.risks,
  'actions': instance.actions,
  'reply_drafts': instance.replyDrafts,
  'created_at': instance.createdAt,
};
