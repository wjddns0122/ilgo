// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reply_draft.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ReplyDraft _$ReplyDraftFromJson(Map<String, dynamic> json) => _ReplyDraft(
  id: json['id'] as String,
  korean: json['korean'] as String,
  noteInLang: json['note_in_lang'] as String?,
);

Map<String, dynamic> _$ReplyDraftToJson(_ReplyDraft instance) =>
    <String, dynamic>{
      'id': instance.id,
      'korean': instance.korean,
      'note_in_lang': instance.noteInLang,
    };
