// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'analyze_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AnalyzeRequest _$AnalyzeRequestFromJson(Map<String, dynamic> json) =>
    _AnalyzeRequest(
      imageBase64: json['image_base64'] as String,
      mediaType: json['media_type'] as String,
      outputMode: json['output_mode'] as String,
      lang: json['lang'] as String,
      save: json['save'] as bool? ?? true,
    );

Map<String, dynamic> _$AnalyzeRequestToJson(_AnalyzeRequest instance) =>
    <String, dynamic>{
      'image_base64': instance.imageBase64,
      'media_type': instance.mediaType,
      'output_mode': instance.outputMode,
      'lang': instance.lang,
      'save': instance.save,
    };
