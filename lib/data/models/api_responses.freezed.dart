// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'api_responses.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$RepliesRegenerateResponse {

@JsonKey(name: 'reply_drafts') List<ReplyDraft> get replyDrafts;
/// Create a copy of RepliesRegenerateResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RepliesRegenerateResponseCopyWith<RepliesRegenerateResponse> get copyWith => _$RepliesRegenerateResponseCopyWithImpl<RepliesRegenerateResponse>(this as RepliesRegenerateResponse, _$identity);

  /// Serializes this RepliesRegenerateResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RepliesRegenerateResponse&&const DeepCollectionEquality().equals(other.replyDrafts, replyDrafts));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(replyDrafts));

@override
String toString() {
  return 'RepliesRegenerateResponse(replyDrafts: $replyDrafts)';
}


}

/// @nodoc
abstract mixin class $RepliesRegenerateResponseCopyWith<$Res>  {
  factory $RepliesRegenerateResponseCopyWith(RepliesRegenerateResponse value, $Res Function(RepliesRegenerateResponse) _then) = _$RepliesRegenerateResponseCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'reply_drafts') List<ReplyDraft> replyDrafts
});




}
/// @nodoc
class _$RepliesRegenerateResponseCopyWithImpl<$Res>
    implements $RepliesRegenerateResponseCopyWith<$Res> {
  _$RepliesRegenerateResponseCopyWithImpl(this._self, this._then);

  final RepliesRegenerateResponse _self;
  final $Res Function(RepliesRegenerateResponse) _then;

/// Create a copy of RepliesRegenerateResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? replyDrafts = null,}) {
  return _then(_self.copyWith(
replyDrafts: null == replyDrafts ? _self.replyDrafts : replyDrafts // ignore: cast_nullable_to_non_nullable
as List<ReplyDraft>,
  ));
}

}


/// Adds pattern-matching-related methods to [RepliesRegenerateResponse].
extension RepliesRegenerateResponsePatterns on RepliesRegenerateResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RepliesRegenerateResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RepliesRegenerateResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RepliesRegenerateResponse value)  $default,){
final _that = this;
switch (_that) {
case _RepliesRegenerateResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RepliesRegenerateResponse value)?  $default,){
final _that = this;
switch (_that) {
case _RepliesRegenerateResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'reply_drafts')  List<ReplyDraft> replyDrafts)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RepliesRegenerateResponse() when $default != null:
return $default(_that.replyDrafts);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'reply_drafts')  List<ReplyDraft> replyDrafts)  $default,) {final _that = this;
switch (_that) {
case _RepliesRegenerateResponse():
return $default(_that.replyDrafts);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'reply_drafts')  List<ReplyDraft> replyDrafts)?  $default,) {final _that = this;
switch (_that) {
case _RepliesRegenerateResponse() when $default != null:
return $default(_that.replyDrafts);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RepliesRegenerateResponse implements RepliesRegenerateResponse {
  const _RepliesRegenerateResponse({@JsonKey(name: 'reply_drafts') final  List<ReplyDraft> replyDrafts = const <ReplyDraft>[]}): _replyDrafts = replyDrafts;
  factory _RepliesRegenerateResponse.fromJson(Map<String, dynamic> json) => _$RepliesRegenerateResponseFromJson(json);

 final  List<ReplyDraft> _replyDrafts;
@override@JsonKey(name: 'reply_drafts') List<ReplyDraft> get replyDrafts {
  if (_replyDrafts is EqualUnmodifiableListView) return _replyDrafts;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_replyDrafts);
}


/// Create a copy of RepliesRegenerateResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RepliesRegenerateResponseCopyWith<_RepliesRegenerateResponse> get copyWith => __$RepliesRegenerateResponseCopyWithImpl<_RepliesRegenerateResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RepliesRegenerateResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RepliesRegenerateResponse&&const DeepCollectionEquality().equals(other._replyDrafts, _replyDrafts));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_replyDrafts));

@override
String toString() {
  return 'RepliesRegenerateResponse(replyDrafts: $replyDrafts)';
}


}

/// @nodoc
abstract mixin class _$RepliesRegenerateResponseCopyWith<$Res> implements $RepliesRegenerateResponseCopyWith<$Res> {
  factory _$RepliesRegenerateResponseCopyWith(_RepliesRegenerateResponse value, $Res Function(_RepliesRegenerateResponse) _then) = __$RepliesRegenerateResponseCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'reply_drafts') List<ReplyDraft> replyDrafts
});




}
/// @nodoc
class __$RepliesRegenerateResponseCopyWithImpl<$Res>
    implements _$RepliesRegenerateResponseCopyWith<$Res> {
  __$RepliesRegenerateResponseCopyWithImpl(this._self, this._then);

  final _RepliesRegenerateResponse _self;
  final $Res Function(_RepliesRegenerateResponse) _then;

/// Create a copy of RepliesRegenerateResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? replyDrafts = null,}) {
  return _then(_RepliesRegenerateResponse(
replyDrafts: null == replyDrafts ? _self._replyDrafts : replyDrafts // ignore: cast_nullable_to_non_nullable
as List<ReplyDraft>,
  ));
}


}


/// @nodoc
mixin _$ActionToggleResponse {

 String? get id;@JsonKey(name: 'is_done') bool? get isDone;
/// Create a copy of ActionToggleResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ActionToggleResponseCopyWith<ActionToggleResponse> get copyWith => _$ActionToggleResponseCopyWithImpl<ActionToggleResponse>(this as ActionToggleResponse, _$identity);

  /// Serializes this ActionToggleResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ActionToggleResponse&&(identical(other.id, id) || other.id == id)&&(identical(other.isDone, isDone) || other.isDone == isDone));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,isDone);

@override
String toString() {
  return 'ActionToggleResponse(id: $id, isDone: $isDone)';
}


}

/// @nodoc
abstract mixin class $ActionToggleResponseCopyWith<$Res>  {
  factory $ActionToggleResponseCopyWith(ActionToggleResponse value, $Res Function(ActionToggleResponse) _then) = _$ActionToggleResponseCopyWithImpl;
@useResult
$Res call({
 String? id,@JsonKey(name: 'is_done') bool? isDone
});




}
/// @nodoc
class _$ActionToggleResponseCopyWithImpl<$Res>
    implements $ActionToggleResponseCopyWith<$Res> {
  _$ActionToggleResponseCopyWithImpl(this._self, this._then);

  final ActionToggleResponse _self;
  final $Res Function(ActionToggleResponse) _then;

/// Create a copy of ActionToggleResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? isDone = freezed,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,isDone: freezed == isDone ? _self.isDone : isDone // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}

}


/// Adds pattern-matching-related methods to [ActionToggleResponse].
extension ActionToggleResponsePatterns on ActionToggleResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ActionToggleResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ActionToggleResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ActionToggleResponse value)  $default,){
final _that = this;
switch (_that) {
case _ActionToggleResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ActionToggleResponse value)?  $default,){
final _that = this;
switch (_that) {
case _ActionToggleResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? id, @JsonKey(name: 'is_done')  bool? isDone)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ActionToggleResponse() when $default != null:
return $default(_that.id,_that.isDone);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? id, @JsonKey(name: 'is_done')  bool? isDone)  $default,) {final _that = this;
switch (_that) {
case _ActionToggleResponse():
return $default(_that.id,_that.isDone);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? id, @JsonKey(name: 'is_done')  bool? isDone)?  $default,) {final _that = this;
switch (_that) {
case _ActionToggleResponse() when $default != null:
return $default(_that.id,_that.isDone);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ActionToggleResponse implements ActionToggleResponse {
  const _ActionToggleResponse({this.id, @JsonKey(name: 'is_done') this.isDone});
  factory _ActionToggleResponse.fromJson(Map<String, dynamic> json) => _$ActionToggleResponseFromJson(json);

@override final  String? id;
@override@JsonKey(name: 'is_done') final  bool? isDone;

/// Create a copy of ActionToggleResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ActionToggleResponseCopyWith<_ActionToggleResponse> get copyWith => __$ActionToggleResponseCopyWithImpl<_ActionToggleResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ActionToggleResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ActionToggleResponse&&(identical(other.id, id) || other.id == id)&&(identical(other.isDone, isDone) || other.isDone == isDone));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,isDone);

@override
String toString() {
  return 'ActionToggleResponse(id: $id, isDone: $isDone)';
}


}

/// @nodoc
abstract mixin class _$ActionToggleResponseCopyWith<$Res> implements $ActionToggleResponseCopyWith<$Res> {
  factory _$ActionToggleResponseCopyWith(_ActionToggleResponse value, $Res Function(_ActionToggleResponse) _then) = __$ActionToggleResponseCopyWithImpl;
@override @useResult
$Res call({
 String? id,@JsonKey(name: 'is_done') bool? isDone
});




}
/// @nodoc
class __$ActionToggleResponseCopyWithImpl<$Res>
    implements _$ActionToggleResponseCopyWith<$Res> {
  __$ActionToggleResponseCopyWithImpl(this._self, this._then);

  final _ActionToggleResponse _self;
  final $Res Function(_ActionToggleResponse) _then;

/// Create a copy of ActionToggleResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? isDone = freezed,}) {
  return _then(_ActionToggleResponse(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,isDone: freezed == isDone ? _self.isDone : isDone // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}


}


/// @nodoc
mixin _$FeedbackResponse {

 String? get id;
/// Create a copy of FeedbackResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FeedbackResponseCopyWith<FeedbackResponse> get copyWith => _$FeedbackResponseCopyWithImpl<FeedbackResponse>(this as FeedbackResponse, _$identity);

  /// Serializes this FeedbackResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FeedbackResponse&&(identical(other.id, id) || other.id == id));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id);

@override
String toString() {
  return 'FeedbackResponse(id: $id)';
}


}

/// @nodoc
abstract mixin class $FeedbackResponseCopyWith<$Res>  {
  factory $FeedbackResponseCopyWith(FeedbackResponse value, $Res Function(FeedbackResponse) _then) = _$FeedbackResponseCopyWithImpl;
@useResult
$Res call({
 String? id
});




}
/// @nodoc
class _$FeedbackResponseCopyWithImpl<$Res>
    implements $FeedbackResponseCopyWith<$Res> {
  _$FeedbackResponseCopyWithImpl(this._self, this._then);

  final FeedbackResponse _self;
  final $Res Function(FeedbackResponse) _then;

/// Create a copy of FeedbackResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [FeedbackResponse].
extension FeedbackResponsePatterns on FeedbackResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FeedbackResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FeedbackResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FeedbackResponse value)  $default,){
final _that = this;
switch (_that) {
case _FeedbackResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FeedbackResponse value)?  $default,){
final _that = this;
switch (_that) {
case _FeedbackResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? id)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FeedbackResponse() when $default != null:
return $default(_that.id);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? id)  $default,) {final _that = this;
switch (_that) {
case _FeedbackResponse():
return $default(_that.id);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? id)?  $default,) {final _that = this;
switch (_that) {
case _FeedbackResponse() when $default != null:
return $default(_that.id);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _FeedbackResponse implements FeedbackResponse {
  const _FeedbackResponse({this.id});
  factory _FeedbackResponse.fromJson(Map<String, dynamic> json) => _$FeedbackResponseFromJson(json);

@override final  String? id;

/// Create a copy of FeedbackResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FeedbackResponseCopyWith<_FeedbackResponse> get copyWith => __$FeedbackResponseCopyWithImpl<_FeedbackResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FeedbackResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FeedbackResponse&&(identical(other.id, id) || other.id == id));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id);

@override
String toString() {
  return 'FeedbackResponse(id: $id)';
}


}

/// @nodoc
abstract mixin class _$FeedbackResponseCopyWith<$Res> implements $FeedbackResponseCopyWith<$Res> {
  factory _$FeedbackResponseCopyWith(_FeedbackResponse value, $Res Function(_FeedbackResponse) _then) = __$FeedbackResponseCopyWithImpl;
@override @useResult
$Res call({
 String? id
});




}
/// @nodoc
class __$FeedbackResponseCopyWithImpl<$Res>
    implements _$FeedbackResponseCopyWith<$Res> {
  __$FeedbackResponseCopyWithImpl(this._self, this._then);

  final _FeedbackResponse _self;
  final $Res Function(_FeedbackResponse) _then;

/// Create a copy of FeedbackResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,}) {
  return _then(_FeedbackResponse(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
