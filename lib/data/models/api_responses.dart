import 'package:freezed_annotation/freezed_annotation.dart';

import 'reply_draft.dart';

part 'api_responses.freezed.dart';
part 'api_responses.g.dart';

/// Response of POST /analyses/{id}/replies:regenerate.
@freezed
abstract class RepliesRegenerateResponse with _$RepliesRegenerateResponse {
  const factory RepliesRegenerateResponse({
    @JsonKey(name: 'reply_drafts')
    @Default(<ReplyDraft>[]) List<ReplyDraft> replyDrafts,
  }) = _RepliesRegenerateResponse;

  factory RepliesRegenerateResponse.fromJson(Map<String, dynamic> json) =>
      _$RepliesRegenerateResponseFromJson(json);
}

/// Response of PATCH /analyses/{id}/actions/{actionId}.
@freezed
abstract class ActionToggleResponse with _$ActionToggleResponse {
  const factory ActionToggleResponse({
    String? id,
    @JsonKey(name: 'is_done') bool? isDone,
  }) = _ActionToggleResponse;

  factory ActionToggleResponse.fromJson(Map<String, dynamic> json) =>
      _$ActionToggleResponseFromJson(json);
}

/// Response of POST /analyses/{id}/feedback.
@freezed
abstract class FeedbackResponse with _$FeedbackResponse {
  const factory FeedbackResponse({String? id}) = _FeedbackResponse;

  factory FeedbackResponse.fromJson(Map<String, dynamic> json) =>
      _$FeedbackResponseFromJson(json);
}
