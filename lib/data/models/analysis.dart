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
    // Empty when the backend returns a result it chose not to persist
    // (판독 실패 / 문서 아님) — the app then won't try to delete or save it.
    @Default('') String id,
    required String status, // done | processing | failed
    @JsonKey(name: 'output_mode') required String outputMode,
    required String lang,
    @JsonKey(name: 'doc_type') String? docType,
    // Explicit classification signals (backend enum). Preferred over the
    // doc_type heuristic when present; null until the backend ships them.
    @JsonKey(name: 'doc_class') String? docClass,
    @JsonKey(name: 'is_document') bool? isDocument,
    // 또바기 companion, AI-chosen (optional). The backend may pick which
    // character state fits the document (warn/caution/safe/victim) and a short
    // line; the client falls back to a risk-derived state / caption when absent.
    @JsonKey(name: 'character_state') String? characterState,
    @JsonKey(name: 'character_line') String? characterLine,
    @JsonKey(name: 'summary_one_line') String? summaryOneLine,
    @JsonKey(name: 'original_text') String? originalText,
    @JsonKey(name: 'explained_text') String? explainedText,
    String? consequence,
    Cards? cards,
    @Default(<Risk>[]) List<Risk> risks,
    @Default(<ActionItem>[]) List<ActionItem> actions,
    @JsonKey(name: 'reply_drafts')
    @Default(<ReplyDraft>[]) List<ReplyDraft> replyDrafts,
    @JsonKey(name: 'created_at') @Default('') String createdAt,
  }) = _Analysis;

  factory Analysis.fromJson(Map<String, dynamic> json) =>
      _$AnalysisFromJson(json);
}
