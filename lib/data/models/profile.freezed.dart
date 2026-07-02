// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'profile.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ProfileResponse {

@JsonKey(name: 'output_mode') String? get outputMode; String? get lang;@JsonKey(name: 'text_scale') double? get textScale;@JsonKey(name: 'deadline_alarm') bool? get deadlineAlarm;
/// Create a copy of ProfileResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProfileResponseCopyWith<ProfileResponse> get copyWith => _$ProfileResponseCopyWithImpl<ProfileResponse>(this as ProfileResponse, _$identity);

  /// Serializes this ProfileResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProfileResponse&&(identical(other.outputMode, outputMode) || other.outputMode == outputMode)&&(identical(other.lang, lang) || other.lang == lang)&&(identical(other.textScale, textScale) || other.textScale == textScale)&&(identical(other.deadlineAlarm, deadlineAlarm) || other.deadlineAlarm == deadlineAlarm));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,outputMode,lang,textScale,deadlineAlarm);

@override
String toString() {
  return 'ProfileResponse(outputMode: $outputMode, lang: $lang, textScale: $textScale, deadlineAlarm: $deadlineAlarm)';
}


}

/// @nodoc
abstract mixin class $ProfileResponseCopyWith<$Res>  {
  factory $ProfileResponseCopyWith(ProfileResponse value, $Res Function(ProfileResponse) _then) = _$ProfileResponseCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'output_mode') String? outputMode, String? lang,@JsonKey(name: 'text_scale') double? textScale,@JsonKey(name: 'deadline_alarm') bool? deadlineAlarm
});




}
/// @nodoc
class _$ProfileResponseCopyWithImpl<$Res>
    implements $ProfileResponseCopyWith<$Res> {
  _$ProfileResponseCopyWithImpl(this._self, this._then);

  final ProfileResponse _self;
  final $Res Function(ProfileResponse) _then;

/// Create a copy of ProfileResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? outputMode = freezed,Object? lang = freezed,Object? textScale = freezed,Object? deadlineAlarm = freezed,}) {
  return _then(_self.copyWith(
outputMode: freezed == outputMode ? _self.outputMode : outputMode // ignore: cast_nullable_to_non_nullable
as String?,lang: freezed == lang ? _self.lang : lang // ignore: cast_nullable_to_non_nullable
as String?,textScale: freezed == textScale ? _self.textScale : textScale // ignore: cast_nullable_to_non_nullable
as double?,deadlineAlarm: freezed == deadlineAlarm ? _self.deadlineAlarm : deadlineAlarm // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}

}


/// Adds pattern-matching-related methods to [ProfileResponse].
extension ProfileResponsePatterns on ProfileResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProfileResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProfileResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProfileResponse value)  $default,){
final _that = this;
switch (_that) {
case _ProfileResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProfileResponse value)?  $default,){
final _that = this;
switch (_that) {
case _ProfileResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'output_mode')  String? outputMode,  String? lang, @JsonKey(name: 'text_scale')  double? textScale, @JsonKey(name: 'deadline_alarm')  bool? deadlineAlarm)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProfileResponse() when $default != null:
return $default(_that.outputMode,_that.lang,_that.textScale,_that.deadlineAlarm);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'output_mode')  String? outputMode,  String? lang, @JsonKey(name: 'text_scale')  double? textScale, @JsonKey(name: 'deadline_alarm')  bool? deadlineAlarm)  $default,) {final _that = this;
switch (_that) {
case _ProfileResponse():
return $default(_that.outputMode,_that.lang,_that.textScale,_that.deadlineAlarm);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'output_mode')  String? outputMode,  String? lang, @JsonKey(name: 'text_scale')  double? textScale, @JsonKey(name: 'deadline_alarm')  bool? deadlineAlarm)?  $default,) {final _that = this;
switch (_that) {
case _ProfileResponse() when $default != null:
return $default(_that.outputMode,_that.lang,_that.textScale,_that.deadlineAlarm);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ProfileResponse implements ProfileResponse {
  const _ProfileResponse({@JsonKey(name: 'output_mode') this.outputMode, this.lang, @JsonKey(name: 'text_scale') this.textScale, @JsonKey(name: 'deadline_alarm') this.deadlineAlarm});
  factory _ProfileResponse.fromJson(Map<String, dynamic> json) => _$ProfileResponseFromJson(json);

@override@JsonKey(name: 'output_mode') final  String? outputMode;
@override final  String? lang;
@override@JsonKey(name: 'text_scale') final  double? textScale;
@override@JsonKey(name: 'deadline_alarm') final  bool? deadlineAlarm;

/// Create a copy of ProfileResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProfileResponseCopyWith<_ProfileResponse> get copyWith => __$ProfileResponseCopyWithImpl<_ProfileResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ProfileResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProfileResponse&&(identical(other.outputMode, outputMode) || other.outputMode == outputMode)&&(identical(other.lang, lang) || other.lang == lang)&&(identical(other.textScale, textScale) || other.textScale == textScale)&&(identical(other.deadlineAlarm, deadlineAlarm) || other.deadlineAlarm == deadlineAlarm));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,outputMode,lang,textScale,deadlineAlarm);

@override
String toString() {
  return 'ProfileResponse(outputMode: $outputMode, lang: $lang, textScale: $textScale, deadlineAlarm: $deadlineAlarm)';
}


}

/// @nodoc
abstract mixin class _$ProfileResponseCopyWith<$Res> implements $ProfileResponseCopyWith<$Res> {
  factory _$ProfileResponseCopyWith(_ProfileResponse value, $Res Function(_ProfileResponse) _then) = __$ProfileResponseCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'output_mode') String? outputMode, String? lang,@JsonKey(name: 'text_scale') double? textScale,@JsonKey(name: 'deadline_alarm') bool? deadlineAlarm
});




}
/// @nodoc
class __$ProfileResponseCopyWithImpl<$Res>
    implements _$ProfileResponseCopyWith<$Res> {
  __$ProfileResponseCopyWithImpl(this._self, this._then);

  final _ProfileResponse _self;
  final $Res Function(_ProfileResponse) _then;

/// Create a copy of ProfileResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? outputMode = freezed,Object? lang = freezed,Object? textScale = freezed,Object? deadlineAlarm = freezed,}) {
  return _then(_ProfileResponse(
outputMode: freezed == outputMode ? _self.outputMode : outputMode // ignore: cast_nullable_to_non_nullable
as String?,lang: freezed == lang ? _self.lang : lang // ignore: cast_nullable_to_non_nullable
as String?,textScale: freezed == textScale ? _self.textScale : textScale // ignore: cast_nullable_to_non_nullable
as double?,deadlineAlarm: freezed == deadlineAlarm ? _self.deadlineAlarm : deadlineAlarm // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}


}

// dart format on
