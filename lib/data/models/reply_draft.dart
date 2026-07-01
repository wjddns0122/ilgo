import 'package:freezed_annotation/freezed_annotation.dart';

part 'reply_draft.freezed.dart';
part 'reply_draft.g.dart';

/// A ready-to-send Korean reply plus a note in the user's language
/// (only present in `native` mode).
@freezed
abstract class ReplyDraft with _$ReplyDraft {
  const factory ReplyDraft({
    required String id,
    required String korean,
    @JsonKey(name: 'note_in_lang') String? noteInLang,
  }) = _ReplyDraft;

  factory ReplyDraft.fromJson(Map<String, dynamic> json) =>
      _$ReplyDraftFromJson(json);
}
