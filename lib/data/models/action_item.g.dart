// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'action_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ActionItem _$ActionItemFromJson(Map<String, dynamic> json) => _ActionItem(
  id: json['id'] as String,
  text: json['text'] as String,
  priority: (json['priority'] as num?)?.toInt() ?? 0,
  isDone: json['is_done'] as bool? ?? false,
);

Map<String, dynamic> _$ActionItemToJson(_ActionItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'text': instance.text,
      'priority': instance.priority,
      'is_done': instance.isDone,
    };
