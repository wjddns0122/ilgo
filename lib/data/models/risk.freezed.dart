// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'risk.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Risk {

 String get id; String get level; String get type; String get message;
/// Create a copy of Risk
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RiskCopyWith<Risk> get copyWith => _$RiskCopyWithImpl<Risk>(this as Risk, _$identity);

  /// Serializes this Risk to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Risk&&(identical(other.id, id) || other.id == id)&&(identical(other.level, level) || other.level == level)&&(identical(other.type, type) || other.type == type)&&(identical(other.message, message) || other.message == message));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,level,type,message);

@override
String toString() {
  return 'Risk(id: $id, level: $level, type: $type, message: $message)';
}


}

/// @nodoc
abstract mixin class $RiskCopyWith<$Res>  {
  factory $RiskCopyWith(Risk value, $Res Function(Risk) _then) = _$RiskCopyWithImpl;
@useResult
$Res call({
 String id, String level, String type, String message
});




}
/// @nodoc
class _$RiskCopyWithImpl<$Res>
    implements $RiskCopyWith<$Res> {
  _$RiskCopyWithImpl(this._self, this._then);

  final Risk _self;
  final $Res Function(Risk) _then;

/// Create a copy of Risk
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? level = null,Object? type = null,Object? message = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,level: null == level ? _self.level : level // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [Risk].
extension RiskPatterns on Risk {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Risk value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Risk() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Risk value)  $default,){
final _that = this;
switch (_that) {
case _Risk():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Risk value)?  $default,){
final _that = this;
switch (_that) {
case _Risk() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String level,  String type,  String message)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Risk() when $default != null:
return $default(_that.id,_that.level,_that.type,_that.message);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String level,  String type,  String message)  $default,) {final _that = this;
switch (_that) {
case _Risk():
return $default(_that.id,_that.level,_that.type,_that.message);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String level,  String type,  String message)?  $default,) {final _that = this;
switch (_that) {
case _Risk() when $default != null:
return $default(_that.id,_that.level,_that.type,_that.message);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Risk extends Risk {
  const _Risk({required this.id, required this.level, required this.type, required this.message}): super._();
  factory _Risk.fromJson(Map<String, dynamic> json) => _$RiskFromJson(json);

@override final  String id;
@override final  String level;
@override final  String type;
@override final  String message;

/// Create a copy of Risk
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RiskCopyWith<_Risk> get copyWith => __$RiskCopyWithImpl<_Risk>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RiskToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Risk&&(identical(other.id, id) || other.id == id)&&(identical(other.level, level) || other.level == level)&&(identical(other.type, type) || other.type == type)&&(identical(other.message, message) || other.message == message));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,level,type,message);

@override
String toString() {
  return 'Risk(id: $id, level: $level, type: $type, message: $message)';
}


}

/// @nodoc
abstract mixin class _$RiskCopyWith<$Res> implements $RiskCopyWith<$Res> {
  factory _$RiskCopyWith(_Risk value, $Res Function(_Risk) _then) = __$RiskCopyWithImpl;
@override @useResult
$Res call({
 String id, String level, String type, String message
});




}
/// @nodoc
class __$RiskCopyWithImpl<$Res>
    implements _$RiskCopyWith<$Res> {
  __$RiskCopyWithImpl(this._self, this._then);

  final _Risk _self;
  final $Res Function(_Risk) _then;

/// Create a copy of Risk
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? level = null,Object? type = null,Object? message = null,}) {
  return _then(_Risk(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,level: null == level ? _self.level : level // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
