// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'analysis.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Analysis {

// Empty when the backend returns a result it chose not to persist
// (판독 실패 / 문서 아님) — the app then won't try to delete or save it.
 String get id; String get status;// done | processing | failed
@JsonKey(name: 'output_mode') String get outputMode; String get lang;@JsonKey(name: 'doc_type') String? get docType;// Explicit classification signals (backend enum). Preferred over the
// doc_type heuristic when present; null until the backend ships them.
@JsonKey(name: 'doc_class') String? get docClass;@JsonKey(name: 'is_document') bool? get isDocument;// 또바기 companion, AI-chosen (optional). The backend may pick which
// character state fits the document (warn/caution/safe/victim) and a short
// line; the client falls back to a risk-derived state / caption when absent.
@JsonKey(name: 'character_state') String? get characterState;@JsonKey(name: 'character_line') String? get characterLine;@JsonKey(name: 'summary_one_line') String? get summaryOneLine;@JsonKey(name: 'original_text') String? get originalText;@JsonKey(name: 'explained_text') String? get explainedText; String? get consequence; Cards? get cards; List<Risk> get risks; List<ActionItem> get actions;@JsonKey(name: 'reply_drafts') List<ReplyDraft> get replyDrafts;@JsonKey(name: 'created_at') String get createdAt;
/// Create a copy of Analysis
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AnalysisCopyWith<Analysis> get copyWith => _$AnalysisCopyWithImpl<Analysis>(this as Analysis, _$identity);

  /// Serializes this Analysis to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Analysis&&(identical(other.id, id) || other.id == id)&&(identical(other.status, status) || other.status == status)&&(identical(other.outputMode, outputMode) || other.outputMode == outputMode)&&(identical(other.lang, lang) || other.lang == lang)&&(identical(other.docType, docType) || other.docType == docType)&&(identical(other.docClass, docClass) || other.docClass == docClass)&&(identical(other.isDocument, isDocument) || other.isDocument == isDocument)&&(identical(other.characterState, characterState) || other.characterState == characterState)&&(identical(other.characterLine, characterLine) || other.characterLine == characterLine)&&(identical(other.summaryOneLine, summaryOneLine) || other.summaryOneLine == summaryOneLine)&&(identical(other.originalText, originalText) || other.originalText == originalText)&&(identical(other.explainedText, explainedText) || other.explainedText == explainedText)&&(identical(other.consequence, consequence) || other.consequence == consequence)&&(identical(other.cards, cards) || other.cards == cards)&&const DeepCollectionEquality().equals(other.risks, risks)&&const DeepCollectionEquality().equals(other.actions, actions)&&const DeepCollectionEquality().equals(other.replyDrafts, replyDrafts)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,status,outputMode,lang,docType,docClass,isDocument,characterState,characterLine,summaryOneLine,originalText,explainedText,consequence,cards,const DeepCollectionEquality().hash(risks),const DeepCollectionEquality().hash(actions),const DeepCollectionEquality().hash(replyDrafts),createdAt);

@override
String toString() {
  return 'Analysis(id: $id, status: $status, outputMode: $outputMode, lang: $lang, docType: $docType, docClass: $docClass, isDocument: $isDocument, characterState: $characterState, characterLine: $characterLine, summaryOneLine: $summaryOneLine, originalText: $originalText, explainedText: $explainedText, consequence: $consequence, cards: $cards, risks: $risks, actions: $actions, replyDrafts: $replyDrafts, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $AnalysisCopyWith<$Res>  {
  factory $AnalysisCopyWith(Analysis value, $Res Function(Analysis) _then) = _$AnalysisCopyWithImpl;
@useResult
$Res call({
 String id, String status,@JsonKey(name: 'output_mode') String outputMode, String lang,@JsonKey(name: 'doc_type') String? docType,@JsonKey(name: 'doc_class') String? docClass,@JsonKey(name: 'is_document') bool? isDocument,@JsonKey(name: 'character_state') String? characterState,@JsonKey(name: 'character_line') String? characterLine,@JsonKey(name: 'summary_one_line') String? summaryOneLine,@JsonKey(name: 'original_text') String? originalText,@JsonKey(name: 'explained_text') String? explainedText, String? consequence, Cards? cards, List<Risk> risks, List<ActionItem> actions,@JsonKey(name: 'reply_drafts') List<ReplyDraft> replyDrafts,@JsonKey(name: 'created_at') String createdAt
});


$CardsCopyWith<$Res>? get cards;

}
/// @nodoc
class _$AnalysisCopyWithImpl<$Res>
    implements $AnalysisCopyWith<$Res> {
  _$AnalysisCopyWithImpl(this._self, this._then);

  final Analysis _self;
  final $Res Function(Analysis) _then;

/// Create a copy of Analysis
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? status = null,Object? outputMode = null,Object? lang = null,Object? docType = freezed,Object? docClass = freezed,Object? isDocument = freezed,Object? characterState = freezed,Object? characterLine = freezed,Object? summaryOneLine = freezed,Object? originalText = freezed,Object? explainedText = freezed,Object? consequence = freezed,Object? cards = freezed,Object? risks = null,Object? actions = null,Object? replyDrafts = null,Object? createdAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,outputMode: null == outputMode ? _self.outputMode : outputMode // ignore: cast_nullable_to_non_nullable
as String,lang: null == lang ? _self.lang : lang // ignore: cast_nullable_to_non_nullable
as String,docType: freezed == docType ? _self.docType : docType // ignore: cast_nullable_to_non_nullable
as String?,docClass: freezed == docClass ? _self.docClass : docClass // ignore: cast_nullable_to_non_nullable
as String?,isDocument: freezed == isDocument ? _self.isDocument : isDocument // ignore: cast_nullable_to_non_nullable
as bool?,characterState: freezed == characterState ? _self.characterState : characterState // ignore: cast_nullable_to_non_nullable
as String?,characterLine: freezed == characterLine ? _self.characterLine : characterLine // ignore: cast_nullable_to_non_nullable
as String?,summaryOneLine: freezed == summaryOneLine ? _self.summaryOneLine : summaryOneLine // ignore: cast_nullable_to_non_nullable
as String?,originalText: freezed == originalText ? _self.originalText : originalText // ignore: cast_nullable_to_non_nullable
as String?,explainedText: freezed == explainedText ? _self.explainedText : explainedText // ignore: cast_nullable_to_non_nullable
as String?,consequence: freezed == consequence ? _self.consequence : consequence // ignore: cast_nullable_to_non_nullable
as String?,cards: freezed == cards ? _self.cards : cards // ignore: cast_nullable_to_non_nullable
as Cards?,risks: null == risks ? _self.risks : risks // ignore: cast_nullable_to_non_nullable
as List<Risk>,actions: null == actions ? _self.actions : actions // ignore: cast_nullable_to_non_nullable
as List<ActionItem>,replyDrafts: null == replyDrafts ? _self.replyDrafts : replyDrafts // ignore: cast_nullable_to_non_nullable
as List<ReplyDraft>,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String,
  ));
}
/// Create a copy of Analysis
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CardsCopyWith<$Res>? get cards {
    if (_self.cards == null) {
    return null;
  }

  return $CardsCopyWith<$Res>(_self.cards!, (value) {
    return _then(_self.copyWith(cards: value));
  });
}
}


/// Adds pattern-matching-related methods to [Analysis].
extension AnalysisPatterns on Analysis {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Analysis value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Analysis() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Analysis value)  $default,){
final _that = this;
switch (_that) {
case _Analysis():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Analysis value)?  $default,){
final _that = this;
switch (_that) {
case _Analysis() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String status, @JsonKey(name: 'output_mode')  String outputMode,  String lang, @JsonKey(name: 'doc_type')  String? docType, @JsonKey(name: 'doc_class')  String? docClass, @JsonKey(name: 'is_document')  bool? isDocument, @JsonKey(name: 'character_state')  String? characterState, @JsonKey(name: 'character_line')  String? characterLine, @JsonKey(name: 'summary_one_line')  String? summaryOneLine, @JsonKey(name: 'original_text')  String? originalText, @JsonKey(name: 'explained_text')  String? explainedText,  String? consequence,  Cards? cards,  List<Risk> risks,  List<ActionItem> actions, @JsonKey(name: 'reply_drafts')  List<ReplyDraft> replyDrafts, @JsonKey(name: 'created_at')  String createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Analysis() when $default != null:
return $default(_that.id,_that.status,_that.outputMode,_that.lang,_that.docType,_that.docClass,_that.isDocument,_that.characterState,_that.characterLine,_that.summaryOneLine,_that.originalText,_that.explainedText,_that.consequence,_that.cards,_that.risks,_that.actions,_that.replyDrafts,_that.createdAt);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String status, @JsonKey(name: 'output_mode')  String outputMode,  String lang, @JsonKey(name: 'doc_type')  String? docType, @JsonKey(name: 'doc_class')  String? docClass, @JsonKey(name: 'is_document')  bool? isDocument, @JsonKey(name: 'character_state')  String? characterState, @JsonKey(name: 'character_line')  String? characterLine, @JsonKey(name: 'summary_one_line')  String? summaryOneLine, @JsonKey(name: 'original_text')  String? originalText, @JsonKey(name: 'explained_text')  String? explainedText,  String? consequence,  Cards? cards,  List<Risk> risks,  List<ActionItem> actions, @JsonKey(name: 'reply_drafts')  List<ReplyDraft> replyDrafts, @JsonKey(name: 'created_at')  String createdAt)  $default,) {final _that = this;
switch (_that) {
case _Analysis():
return $default(_that.id,_that.status,_that.outputMode,_that.lang,_that.docType,_that.docClass,_that.isDocument,_that.characterState,_that.characterLine,_that.summaryOneLine,_that.originalText,_that.explainedText,_that.consequence,_that.cards,_that.risks,_that.actions,_that.replyDrafts,_that.createdAt);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String status, @JsonKey(name: 'output_mode')  String outputMode,  String lang, @JsonKey(name: 'doc_type')  String? docType, @JsonKey(name: 'doc_class')  String? docClass, @JsonKey(name: 'is_document')  bool? isDocument, @JsonKey(name: 'character_state')  String? characterState, @JsonKey(name: 'character_line')  String? characterLine, @JsonKey(name: 'summary_one_line')  String? summaryOneLine, @JsonKey(name: 'original_text')  String? originalText, @JsonKey(name: 'explained_text')  String? explainedText,  String? consequence,  Cards? cards,  List<Risk> risks,  List<ActionItem> actions, @JsonKey(name: 'reply_drafts')  List<ReplyDraft> replyDrafts, @JsonKey(name: 'created_at')  String createdAt)?  $default,) {final _that = this;
switch (_that) {
case _Analysis() when $default != null:
return $default(_that.id,_that.status,_that.outputMode,_that.lang,_that.docType,_that.docClass,_that.isDocument,_that.characterState,_that.characterLine,_that.summaryOneLine,_that.originalText,_that.explainedText,_that.consequence,_that.cards,_that.risks,_that.actions,_that.replyDrafts,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Analysis implements Analysis {
  const _Analysis({this.id = '', required this.status, @JsonKey(name: 'output_mode') required this.outputMode, required this.lang, @JsonKey(name: 'doc_type') this.docType, @JsonKey(name: 'doc_class') this.docClass, @JsonKey(name: 'is_document') this.isDocument, @JsonKey(name: 'character_state') this.characterState, @JsonKey(name: 'character_line') this.characterLine, @JsonKey(name: 'summary_one_line') this.summaryOneLine, @JsonKey(name: 'original_text') this.originalText, @JsonKey(name: 'explained_text') this.explainedText, this.consequence, this.cards, final  List<Risk> risks = const <Risk>[], final  List<ActionItem> actions = const <ActionItem>[], @JsonKey(name: 'reply_drafts') final  List<ReplyDraft> replyDrafts = const <ReplyDraft>[], @JsonKey(name: 'created_at') this.createdAt = ''}): _risks = risks,_actions = actions,_replyDrafts = replyDrafts;
  factory _Analysis.fromJson(Map<String, dynamic> json) => _$AnalysisFromJson(json);

// Empty when the backend returns a result it chose not to persist
// (판독 실패 / 문서 아님) — the app then won't try to delete or save it.
@override@JsonKey() final  String id;
@override final  String status;
// done | processing | failed
@override@JsonKey(name: 'output_mode') final  String outputMode;
@override final  String lang;
@override@JsonKey(name: 'doc_type') final  String? docType;
// Explicit classification signals (backend enum). Preferred over the
// doc_type heuristic when present; null until the backend ships them.
@override@JsonKey(name: 'doc_class') final  String? docClass;
@override@JsonKey(name: 'is_document') final  bool? isDocument;
// 또바기 companion, AI-chosen (optional). The backend may pick which
// character state fits the document (warn/caution/safe/victim) and a short
// line; the client falls back to a risk-derived state / caption when absent.
@override@JsonKey(name: 'character_state') final  String? characterState;
@override@JsonKey(name: 'character_line') final  String? characterLine;
@override@JsonKey(name: 'summary_one_line') final  String? summaryOneLine;
@override@JsonKey(name: 'original_text') final  String? originalText;
@override@JsonKey(name: 'explained_text') final  String? explainedText;
@override final  String? consequence;
@override final  Cards? cards;
 final  List<Risk> _risks;
@override@JsonKey() List<Risk> get risks {
  if (_risks is EqualUnmodifiableListView) return _risks;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_risks);
}

 final  List<ActionItem> _actions;
@override@JsonKey() List<ActionItem> get actions {
  if (_actions is EqualUnmodifiableListView) return _actions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_actions);
}

 final  List<ReplyDraft> _replyDrafts;
@override@JsonKey(name: 'reply_drafts') List<ReplyDraft> get replyDrafts {
  if (_replyDrafts is EqualUnmodifiableListView) return _replyDrafts;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_replyDrafts);
}

@override@JsonKey(name: 'created_at') final  String createdAt;

/// Create a copy of Analysis
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AnalysisCopyWith<_Analysis> get copyWith => __$AnalysisCopyWithImpl<_Analysis>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AnalysisToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Analysis&&(identical(other.id, id) || other.id == id)&&(identical(other.status, status) || other.status == status)&&(identical(other.outputMode, outputMode) || other.outputMode == outputMode)&&(identical(other.lang, lang) || other.lang == lang)&&(identical(other.docType, docType) || other.docType == docType)&&(identical(other.docClass, docClass) || other.docClass == docClass)&&(identical(other.isDocument, isDocument) || other.isDocument == isDocument)&&(identical(other.characterState, characterState) || other.characterState == characterState)&&(identical(other.characterLine, characterLine) || other.characterLine == characterLine)&&(identical(other.summaryOneLine, summaryOneLine) || other.summaryOneLine == summaryOneLine)&&(identical(other.originalText, originalText) || other.originalText == originalText)&&(identical(other.explainedText, explainedText) || other.explainedText == explainedText)&&(identical(other.consequence, consequence) || other.consequence == consequence)&&(identical(other.cards, cards) || other.cards == cards)&&const DeepCollectionEquality().equals(other._risks, _risks)&&const DeepCollectionEquality().equals(other._actions, _actions)&&const DeepCollectionEquality().equals(other._replyDrafts, _replyDrafts)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,status,outputMode,lang,docType,docClass,isDocument,characterState,characterLine,summaryOneLine,originalText,explainedText,consequence,cards,const DeepCollectionEquality().hash(_risks),const DeepCollectionEquality().hash(_actions),const DeepCollectionEquality().hash(_replyDrafts),createdAt);

@override
String toString() {
  return 'Analysis(id: $id, status: $status, outputMode: $outputMode, lang: $lang, docType: $docType, docClass: $docClass, isDocument: $isDocument, characterState: $characterState, characterLine: $characterLine, summaryOneLine: $summaryOneLine, originalText: $originalText, explainedText: $explainedText, consequence: $consequence, cards: $cards, risks: $risks, actions: $actions, replyDrafts: $replyDrafts, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$AnalysisCopyWith<$Res> implements $AnalysisCopyWith<$Res> {
  factory _$AnalysisCopyWith(_Analysis value, $Res Function(_Analysis) _then) = __$AnalysisCopyWithImpl;
@override @useResult
$Res call({
 String id, String status,@JsonKey(name: 'output_mode') String outputMode, String lang,@JsonKey(name: 'doc_type') String? docType,@JsonKey(name: 'doc_class') String? docClass,@JsonKey(name: 'is_document') bool? isDocument,@JsonKey(name: 'character_state') String? characterState,@JsonKey(name: 'character_line') String? characterLine,@JsonKey(name: 'summary_one_line') String? summaryOneLine,@JsonKey(name: 'original_text') String? originalText,@JsonKey(name: 'explained_text') String? explainedText, String? consequence, Cards? cards, List<Risk> risks, List<ActionItem> actions,@JsonKey(name: 'reply_drafts') List<ReplyDraft> replyDrafts,@JsonKey(name: 'created_at') String createdAt
});


@override $CardsCopyWith<$Res>? get cards;

}
/// @nodoc
class __$AnalysisCopyWithImpl<$Res>
    implements _$AnalysisCopyWith<$Res> {
  __$AnalysisCopyWithImpl(this._self, this._then);

  final _Analysis _self;
  final $Res Function(_Analysis) _then;

/// Create a copy of Analysis
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? status = null,Object? outputMode = null,Object? lang = null,Object? docType = freezed,Object? docClass = freezed,Object? isDocument = freezed,Object? characterState = freezed,Object? characterLine = freezed,Object? summaryOneLine = freezed,Object? originalText = freezed,Object? explainedText = freezed,Object? consequence = freezed,Object? cards = freezed,Object? risks = null,Object? actions = null,Object? replyDrafts = null,Object? createdAt = null,}) {
  return _then(_Analysis(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,outputMode: null == outputMode ? _self.outputMode : outputMode // ignore: cast_nullable_to_non_nullable
as String,lang: null == lang ? _self.lang : lang // ignore: cast_nullable_to_non_nullable
as String,docType: freezed == docType ? _self.docType : docType // ignore: cast_nullable_to_non_nullable
as String?,docClass: freezed == docClass ? _self.docClass : docClass // ignore: cast_nullable_to_non_nullable
as String?,isDocument: freezed == isDocument ? _self.isDocument : isDocument // ignore: cast_nullable_to_non_nullable
as bool?,characterState: freezed == characterState ? _self.characterState : characterState // ignore: cast_nullable_to_non_nullable
as String?,characterLine: freezed == characterLine ? _self.characterLine : characterLine // ignore: cast_nullable_to_non_nullable
as String?,summaryOneLine: freezed == summaryOneLine ? _self.summaryOneLine : summaryOneLine // ignore: cast_nullable_to_non_nullable
as String?,originalText: freezed == originalText ? _self.originalText : originalText // ignore: cast_nullable_to_non_nullable
as String?,explainedText: freezed == explainedText ? _self.explainedText : explainedText // ignore: cast_nullable_to_non_nullable
as String?,consequence: freezed == consequence ? _self.consequence : consequence // ignore: cast_nullable_to_non_nullable
as String?,cards: freezed == cards ? _self.cards : cards // ignore: cast_nullable_to_non_nullable
as Cards?,risks: null == risks ? _self._risks : risks // ignore: cast_nullable_to_non_nullable
as List<Risk>,actions: null == actions ? _self._actions : actions // ignore: cast_nullable_to_non_nullable
as List<ActionItem>,replyDrafts: null == replyDrafts ? _self._replyDrafts : replyDrafts // ignore: cast_nullable_to_non_nullable
as List<ReplyDraft>,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

/// Create a copy of Analysis
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CardsCopyWith<$Res>? get cards {
    if (_self.cards == null) {
    return null;
  }

  return $CardsCopyWith<$Res>(_self.cards!, (value) {
    return _then(_self.copyWith(cards: value));
  });
}
}

// dart format on
