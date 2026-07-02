import 'package:freezed_annotation/freezed_annotation.dart';

import 'action_item.dart';
import 'cards.dart';
import 'reply_draft.dart';
import 'risk.dart';

part 'analysis.freezed.dart';
part 'analysis.g.dart';

/// The full engine result returned by the live API.
@freezed
abstract class Analysis with _$Analysis {
  const factory Analysis({
    required String id,
    required String status, // done | processing | failed
    @JsonKey(name: 'output_mode') required String outputMode,
    required String lang,
    @JsonKey(name: 'doc_type') String? docType,
    @JsonKey(name: 'summary_one_line') String? summaryOneLine,
    @JsonKey(name: 'original_text') String? originalText,
    @JsonKey(name: 'explained_text') String? explainedText,
    String? consequence,
    Cards? cards,
    @Default(<Risk>[]) List<Risk> risks,
    @Default(<ActionItem>[]) List<ActionItem> actions,
    @JsonKey(name: 'reply_drafts')
    @Default(<ReplyDraft>[]) List<ReplyDraft> replyDrafts,
    @JsonKey(name: 'created_at') required String createdAt,
  }) = _Analysis;

  factory Analysis.fromJson(Map<String, dynamic> json) =>
      _$AnalysisFromJson(json);
}
