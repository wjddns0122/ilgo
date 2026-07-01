import 'package:freezed_annotation/freezed_annotation.dart';

part 'analyze_request.freezed.dart';
part 'analyze_request.g.dart';

/// Request body for POST /analyses.
@freezed
abstract class AnalyzeRequest with _$AnalyzeRequest {
  const factory AnalyzeRequest({
    @JsonKey(name: 'image_base64') required String imageBase64,
    @JsonKey(name: 'media_type') required String mediaType,
    @JsonKey(name: 'output_mode') required String outputMode,
    required String lang,
    @Default(true) bool save,
  }) = _AnalyzeRequest;

  factory AnalyzeRequest.fromJson(Map<String, dynamic> json) =>
      _$AnalyzeRequestFromJson(json);
}
