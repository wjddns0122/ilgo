import 'package:freezed_annotation/freezed_annotation.dart';

part 'profile.freezed.dart';
part 'profile.g.dart';

/// Server profile (GET/PUT /profile). Same shape used for update requests.
@freezed
abstract class ProfileResponse with _$ProfileResponse {
  const factory ProfileResponse({
    @JsonKey(name: 'output_mode') String? outputMode,
    String? lang,
    @JsonKey(name: 'text_scale') double? textScale,
    @JsonKey(name: 'deadline_alarm') bool? deadlineAlarm,
  }) = _ProfileResponse;

  factory ProfileResponse.fromJson(Map<String, dynamic> json) =>
      _$ProfileResponseFromJson(json);
}
