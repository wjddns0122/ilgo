// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_responses.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_RepliesRegenerateResponse _$RepliesRegenerateResponseFromJson(
  Map<String, dynamic> json,
) => _RepliesRegenerateResponse(
  replyDrafts:
      (json['reply_drafts'] as List<dynamic>?)
          ?.map((e) => ReplyDraft.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <ReplyDraft>[],
);

Map<String, dynamic> _$RepliesRegenerateResponseToJson(
  _RepliesRegenerateResponse instance,
) => <String, dynamic>{'reply_drafts': instance.replyDrafts};

_ActionToggleResponse _$ActionToggleResponseFromJson(
  Map<String, dynamic> json,
) => _ActionToggleResponse(
  id: json['id'] as String?,
  isDone: json['is_done'] as bool?,
);

Map<String, dynamic> _$ActionToggleResponseToJson(
  _ActionToggleResponse instance,
) => <String, dynamic>{'id': instance.id, 'is_done': instance.isDone};

_FeedbackResponse _$FeedbackResponseFromJson(Map<String, dynamic> json) =>
    _FeedbackResponse(id: json['id'] as String?);

Map<String, dynamic> _$FeedbackResponseToJson(_FeedbackResponse instance) =>
    <String, dynamic>{'id': instance.id};
