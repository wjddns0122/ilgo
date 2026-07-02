// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ProfileResponse _$ProfileResponseFromJson(Map<String, dynamic> json) =>
    _ProfileResponse(
      outputMode: json['output_mode'] as String?,
      lang: json['lang'] as String?,
      textScale: (json['text_scale'] as num?)?.toDouble(),
      deadlineAlarm: json['deadline_alarm'] as bool?,
    );

Map<String, dynamic> _$ProfileResponseToJson(_ProfileResponse instance) =>
    <String, dynamic>{
      'output_mode': instance.outputMode,
      'lang': instance.lang,
      'text_scale': instance.textScale,
      'deadline_alarm': instance.deadlineAlarm,
    };
