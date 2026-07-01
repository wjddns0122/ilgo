// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'analysis_summary.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AnalysisSummary {

 String get id;@JsonKey(name: 'doc_type') String? get docType;@JsonKey(name: 'summary_one_line') String? get summaryOneLine;@JsonKey(name: 'top_risk_level') String? get topRiskLevel;@JsonKey(name: 'card_deadline') String? get cardDeadline;@JsonKey(name: 'created_at') String get createdAt;
/// Create a copy of AnalysisSummary
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AnalysisSummaryCopyWith<AnalysisSummary> get copyWith => _$AnalysisSummaryCopyWithImpl<AnalysisSummary>(this as AnalysisSummary, _$identity);

  /// Serializes this AnalysisSummary to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AnalysisSummary&&(identical(other.id, id) || other.id == id)&&(identical(other.docType, docType) || other.docType == docType)&&(identical(other.summaryOneLine, summaryOneLine) || other.summaryOneLine == summaryOneLine)&&(identical(other.topRiskLevel, topRiskLevel) || other.topRiskLevel == topRiskLevel)&&(identical(other.cardDeadline, cardDeadline) || other.cardDeadline == cardDeadline)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,docType,summaryOneLine,topRiskLevel,cardDeadline,createdAt);

@override
String toString() {
  return 'AnalysisSummary(id: $id, docType: $docType, summaryOneLine: $summaryOneLine, topRiskLevel: $topRiskLevel, cardDeadline: $cardDeadline, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $AnalysisSummaryCopyWith<$Res>  {
  factory $AnalysisSummaryCopyWith(AnalysisSummary value, $Res Function(AnalysisSummary) _then) = _$AnalysisSummaryCopyWithImpl;
@useResult
$Res call({
 String id,@JsonKey(name: 'doc_type') String? docType,@JsonKey(name: 'summary_one_line') String? summaryOneLine,@JsonKey(name: 'top_risk_level') String? topRiskLevel,@JsonKey(name: 'card_deadline') String? cardDeadline,@JsonKey(name: 'created_at') String createdAt
});




}
/// @nodoc
class _$AnalysisSummaryCopyWithImpl<$Res>
    implements $AnalysisSummaryCopyWith<$Res> {
  _$AnalysisSummaryCopyWithImpl(this._self, this._then);

  final AnalysisSummary _self;
  final $Res Function(AnalysisSummary) _then;

/// Create a copy of AnalysisSummary
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? docType = freezed,Object? summaryOneLine = freezed,Object? topRiskLevel = freezed,Object? cardDeadline = freezed,Object? createdAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,docType: freezed == docType ? _self.docType : docType // ignore: cast_nullable_to_non_nullable
as String?,summaryOneLine: freezed == summaryOneLine ? _self.summaryOneLine : summaryOneLine // ignore: cast_nullable_to_non_nullable
as String?,topRiskLevel: freezed == topRiskLevel ? _self.topRiskLevel : topRiskLevel // ignore: cast_nullable_to_non_nullable
as String?,cardDeadline: freezed == cardDeadline ? _self.cardDeadline : cardDeadline // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [AnalysisSummary].
extension AnalysisSummaryPatterns on AnalysisSummary {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AnalysisSummary value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AnalysisSummary() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AnalysisSummary value)  $default,){
final _that = this;
switch (_that) {
case _AnalysisSummary():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AnalysisSummary value)?  $default,){
final _that = this;
switch (_that) {
case _AnalysisSummary() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'doc_type')  String? docType, @JsonKey(name: 'summary_one_line')  String? summaryOneLine, @JsonKey(name: 'top_risk_level')  String? topRiskLevel, @JsonKey(name: 'card_deadline')  String? cardDeadline, @JsonKey(name: 'created_at')  String createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AnalysisSummary() when $default != null:
return $default(_that.id,_that.docType,_that.summaryOneLine,_that.topRiskLevel,_that.cardDeadline,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'doc_type')  String? docType, @JsonKey(name: 'summary_one_line')  String? summaryOneLine, @JsonKey(name: 'top_risk_level')  String? topRiskLevel, @JsonKey(name: 'card_deadline')  String? cardDeadline, @JsonKey(name: 'created_at')  String createdAt)  $default,) {final _that = this;
switch (_that) {
case _AnalysisSummary():
return $default(_that.id,_that.docType,_that.summaryOneLine,_that.topRiskLevel,_that.cardDeadline,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id, @JsonKey(name: 'doc_type')  String? docType, @JsonKey(name: 'summary_one_line')  String? summaryOneLine, @JsonKey(name: 'top_risk_level')  String? topRiskLevel, @JsonKey(name: 'card_deadline')  String? cardDeadline, @JsonKey(name: 'created_at')  String createdAt)?  $default,) {final _that = this;
switch (_that) {
case _AnalysisSummary() when $default != null:
return $default(_that.id,_that.docType,_that.summaryOneLine,_that.topRiskLevel,_that.cardDeadline,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AnalysisSummary implements AnalysisSummary {
  const _AnalysisSummary({required this.id, @JsonKey(name: 'doc_type') this.docType, @JsonKey(name: 'summary_one_line') this.summaryOneLine, @JsonKey(name: 'top_risk_level') this.topRiskLevel, @JsonKey(name: 'card_deadline') this.cardDeadline, @JsonKey(name: 'created_at') required this.createdAt});
  factory _AnalysisSummary.fromJson(Map<String, dynamic> json) => _$AnalysisSummaryFromJson(json);

@override final  String id;
@override@JsonKey(name: 'doc_type') final  String? docType;
@override@JsonKey(name: 'summary_one_line') final  String? summaryOneLine;
@override@JsonKey(name: 'top_risk_level') final  String? topRiskLevel;
@override@JsonKey(name: 'card_deadline') final  String? cardDeadline;
@override@JsonKey(name: 'created_at') final  String createdAt;

/// Create a copy of AnalysisSummary
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AnalysisSummaryCopyWith<_AnalysisSummary> get copyWith => __$AnalysisSummaryCopyWithImpl<_AnalysisSummary>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AnalysisSummaryToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AnalysisSummary&&(identical(other.id, id) || other.id == id)&&(identical(other.docType, docType) || other.docType == docType)&&(identical(other.summaryOneLine, summaryOneLine) || other.summaryOneLine == summaryOneLine)&&(identical(other.topRiskLevel, topRiskLevel) || other.topRiskLevel == topRiskLevel)&&(identical(other.cardDeadline, cardDeadline) || other.cardDeadline == cardDeadline)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,docType,summaryOneLine,topRiskLevel,cardDeadline,createdAt);

@override
String toString() {
  return 'AnalysisSummary(id: $id, docType: $docType, summaryOneLine: $summaryOneLine, topRiskLevel: $topRiskLevel, cardDeadline: $cardDeadline, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$AnalysisSummaryCopyWith<$Res> implements $AnalysisSummaryCopyWith<$Res> {
  factory _$AnalysisSummaryCopyWith(_AnalysisSummary value, $Res Function(_AnalysisSummary) _then) = __$AnalysisSummaryCopyWithImpl;
@override @useResult
$Res call({
 String id,@JsonKey(name: 'doc_type') String? docType,@JsonKey(name: 'summary_one_line') String? summaryOneLine,@JsonKey(name: 'top_risk_level') String? topRiskLevel,@JsonKey(name: 'card_deadline') String? cardDeadline,@JsonKey(name: 'created_at') String createdAt
});




}
/// @nodoc
class __$AnalysisSummaryCopyWithImpl<$Res>
    implements _$AnalysisSummaryCopyWith<$Res> {
  __$AnalysisSummaryCopyWithImpl(this._self, this._then);

  final _AnalysisSummary _self;
  final $Res Function(_AnalysisSummary) _then;

/// Create a copy of AnalysisSummary
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? docType = freezed,Object? summaryOneLine = freezed,Object? topRiskLevel = freezed,Object? cardDeadline = freezed,Object? createdAt = null,}) {
  return _then(_AnalysisSummary(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,docType: freezed == docType ? _self.docType : docType // ignore: cast_nullable_to_non_nullable
as String?,summaryOneLine: freezed == summaryOneLine ? _self.summaryOneLine : summaryOneLine // ignore: cast_nullable_to_non_nullable
as String?,topRiskLevel: freezed == topRiskLevel ? _self.topRiskLevel : topRiskLevel // ignore: cast_nullable_to_non_nullable
as String?,cardDeadline: freezed == cardDeadline ? _self.cardDeadline : cardDeadline // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$AnalysisListResponse {

 List<AnalysisSummary> get items;@JsonKey(name: 'next_cursor') String? get nextCursor;
/// Create a copy of AnalysisListResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AnalysisListResponseCopyWith<AnalysisListResponse> get copyWith => _$AnalysisListResponseCopyWithImpl<AnalysisListResponse>(this as AnalysisListResponse, _$identity);

  /// Serializes this AnalysisListResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AnalysisListResponse&&const DeepCollectionEquality().equals(other.items, items)&&(identical(other.nextCursor, nextCursor) || other.nextCursor == nextCursor));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(items),nextCursor);

@override
String toString() {
  return 'AnalysisListResponse(items: $items, nextCursor: $nextCursor)';
}


}

/// @nodoc
abstract mixin class $AnalysisListResponseCopyWith<$Res>  {
  factory $AnalysisListResponseCopyWith(AnalysisListResponse value, $Res Function(AnalysisListResponse) _then) = _$AnalysisListResponseCopyWithImpl;
@useResult
$Res call({
 List<AnalysisSummary> items,@JsonKey(name: 'next_cursor') String? nextCursor
});




}
/// @nodoc
class _$AnalysisListResponseCopyWithImpl<$Res>
    implements $AnalysisListResponseCopyWith<$Res> {
  _$AnalysisListResponseCopyWithImpl(this._self, this._then);

  final AnalysisListResponse _self;
  final $Res Function(AnalysisListResponse) _then;

/// Create a copy of AnalysisListResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? items = null,Object? nextCursor = freezed,}) {
  return _then(_self.copyWith(
items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<AnalysisSummary>,nextCursor: freezed == nextCursor ? _self.nextCursor : nextCursor // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [AnalysisListResponse].
extension AnalysisListResponsePatterns on AnalysisListResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AnalysisListResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AnalysisListResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AnalysisListResponse value)  $default,){
final _that = this;
switch (_that) {
case _AnalysisListResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AnalysisListResponse value)?  $default,){
final _that = this;
switch (_that) {
case _AnalysisListResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<AnalysisSummary> items, @JsonKey(name: 'next_cursor')  String? nextCursor)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AnalysisListResponse() when $default != null:
return $default(_that.items,_that.nextCursor);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<AnalysisSummary> items, @JsonKey(name: 'next_cursor')  String? nextCursor)  $default,) {final _that = this;
switch (_that) {
case _AnalysisListResponse():
return $default(_that.items,_that.nextCursor);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<AnalysisSummary> items, @JsonKey(name: 'next_cursor')  String? nextCursor)?  $default,) {final _that = this;
switch (_that) {
case _AnalysisListResponse() when $default != null:
return $default(_that.items,_that.nextCursor);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AnalysisListResponse implements AnalysisListResponse {
  const _AnalysisListResponse({final  List<AnalysisSummary> items = const <AnalysisSummary>[], @JsonKey(name: 'next_cursor') this.nextCursor}): _items = items;
  factory _AnalysisListResponse.fromJson(Map<String, dynamic> json) => _$AnalysisListResponseFromJson(json);

 final  List<AnalysisSummary> _items;
@override@JsonKey() List<AnalysisSummary> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}

@override@JsonKey(name: 'next_cursor') final  String? nextCursor;

/// Create a copy of AnalysisListResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AnalysisListResponseCopyWith<_AnalysisListResponse> get copyWith => __$AnalysisListResponseCopyWithImpl<_AnalysisListResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AnalysisListResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AnalysisListResponse&&const DeepCollectionEquality().equals(other._items, _items)&&(identical(other.nextCursor, nextCursor) || other.nextCursor == nextCursor));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_items),nextCursor);

@override
String toString() {
  return 'AnalysisListResponse(items: $items, nextCursor: $nextCursor)';
}


}

/// @nodoc
abstract mixin class _$AnalysisListResponseCopyWith<$Res> implements $AnalysisListResponseCopyWith<$Res> {
  factory _$AnalysisListResponseCopyWith(_AnalysisListResponse value, $Res Function(_AnalysisListResponse) _then) = __$AnalysisListResponseCopyWithImpl;
@override @useResult
$Res call({
 List<AnalysisSummary> items,@JsonKey(name: 'next_cursor') String? nextCursor
});




}
/// @nodoc
class __$AnalysisListResponseCopyWithImpl<$Res>
    implements _$AnalysisListResponseCopyWith<$Res> {
  __$AnalysisListResponseCopyWithImpl(this._self, this._then);

  final _AnalysisListResponse _self;
  final $Res Function(_AnalysisListResponse) _then;

/// Create a copy of AnalysisListResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? items = null,Object? nextCursor = freezed,}) {
  return _then(_AnalysisListResponse(
items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<AnalysisSummary>,nextCursor: freezed == nextCursor ? _self.nextCursor : nextCursor // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
