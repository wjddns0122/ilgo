// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'risk.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Risk _$RiskFromJson(Map<String, dynamic> json) => _Risk(
  id: json['id'] as String,
  level: json['level'] as String,
  type: json['type'] as String,
  message: json['message'] as String,
  detail: json['detail'] as String?,
  steps:
      (json['steps'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const <String>[],
);

Map<String, dynamic> _$RiskToJson(_Risk instance) => <String, dynamic>{
  'id': instance.id,
  'level': instance.level,
  'type': instance.type,
  'message': instance.message,
  'detail': instance.detail,
  'steps': instance.steps,
};
