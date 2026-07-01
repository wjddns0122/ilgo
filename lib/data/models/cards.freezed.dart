// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'cards.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Cards {

 String? get what; String? get when; String? get where; String? get amount; String? get deadline;
/// Create a copy of Cards
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CardsCopyWith<Cards> get copyWith => _$CardsCopyWithImpl<Cards>(this as Cards, _$identity);

  /// Serializes this Cards to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Cards&&(identical(other.what, what) || other.what == what)&&(identical(other.when, when) || other.when == when)&&(identical(other.where, where) || other.where == where)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.deadline, deadline) || other.deadline == deadline));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,what,when,where,amount,deadline);

@override
String toString() {
  return 'Cards(what: $what, when: $when, where: $where, amount: $amount, deadline: $deadline)';
}


}

/// @nodoc
abstract mixin class $CardsCopyWith<$Res>  {
  factory $CardsCopyWith(Cards value, $Res Function(Cards) _then) = _$CardsCopyWithImpl;
@useResult
$Res call({
 String? what, String? when, String? where, String? amount, String? deadline
});




}
/// @nodoc
class _$CardsCopyWithImpl<$Res>
    implements $CardsCopyWith<$Res> {
  _$CardsCopyWithImpl(this._self, this._then);

  final Cards _self;
  final $Res Function(Cards) _then;

/// Create a copy of Cards
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? what = freezed,Object? when = freezed,Object? where = freezed,Object? amount = freezed,Object? deadline = freezed,}) {
  return _then(_self.copyWith(
what: freezed == what ? _self.what : what // ignore: cast_nullable_to_non_nullable
as String?,when: freezed == when ? _self.when : when // ignore: cast_nullable_to_non_nullable
as String?,where: freezed == where ? _self.where : where // ignore: cast_nullable_to_non_nullable
as String?,amount: freezed == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as String?,deadline: freezed == deadline ? _self.deadline : deadline // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [Cards].
extension CardsPatterns on Cards {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Cards value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Cards() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Cards value)  $default,){
final _that = this;
switch (_that) {
case _Cards():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Cards value)?  $default,){
final _that = this;
switch (_that) {
case _Cards() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? what,  String? when,  String? where,  String? amount,  String? deadline)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Cards() when $default != null:
return $default(_that.what,_that.when,_that.where,_that.amount,_that.deadline);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? what,  String? when,  String? where,  String? amount,  String? deadline)  $default,) {final _that = this;
switch (_that) {
case _Cards():
return $default(_that.what,_that.when,_that.where,_that.amount,_that.deadline);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? what,  String? when,  String? where,  String? amount,  String? deadline)?  $default,) {final _that = this;
switch (_that) {
case _Cards() when $default != null:
return $default(_that.what,_that.when,_that.where,_that.amount,_that.deadline);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Cards implements Cards {
  const _Cards({this.what, this.when, this.where, this.amount, this.deadline});
  factory _Cards.fromJson(Map<String, dynamic> json) => _$CardsFromJson(json);

@override final  String? what;
@override final  String? when;
@override final  String? where;
@override final  String? amount;
@override final  String? deadline;

/// Create a copy of Cards
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CardsCopyWith<_Cards> get copyWith => __$CardsCopyWithImpl<_Cards>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CardsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Cards&&(identical(other.what, what) || other.what == what)&&(identical(other.when, when) || other.when == when)&&(identical(other.where, where) || other.where == where)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.deadline, deadline) || other.deadline == deadline));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,what,when,where,amount,deadline);

@override
String toString() {
  return 'Cards(what: $what, when: $when, where: $where, amount: $amount, deadline: $deadline)';
}


}

/// @nodoc
abstract mixin class _$CardsCopyWith<$Res> implements $CardsCopyWith<$Res> {
  factory _$CardsCopyWith(_Cards value, $Res Function(_Cards) _then) = __$CardsCopyWithImpl;
@override @useResult
$Res call({
 String? what, String? when, String? where, String? amount, String? deadline
});




}
/// @nodoc
class __$CardsCopyWithImpl<$Res>
    implements _$CardsCopyWith<$Res> {
  __$CardsCopyWithImpl(this._self, this._then);

  final _Cards _self;
  final $Res Function(_Cards) _then;

/// Create a copy of Cards
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? what = freezed,Object? when = freezed,Object? where = freezed,Object? amount = freezed,Object? deadline = freezed,}) {
  return _then(_Cards(
what: freezed == what ? _self.what : what // ignore: cast_nullable_to_non_nullable
as String?,when: freezed == when ? _self.when : when // ignore: cast_nullable_to_non_nullable
as String?,where: freezed == where ? _self.where : where // ignore: cast_nullable_to_non_nullable
as String?,amount: freezed == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as String?,deadline: freezed == deadline ? _self.deadline : deadline // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
