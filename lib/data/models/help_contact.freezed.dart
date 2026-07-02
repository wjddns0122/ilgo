// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'help_contact.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$HelpContact {

 String get id; String get title; String? get org; String? get phone; String? get category; bool get emergency;
/// Create a copy of HelpContact
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HelpContactCopyWith<HelpContact> get copyWith => _$HelpContactCopyWithImpl<HelpContact>(this as HelpContact, _$identity);

  /// Serializes this HelpContact to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HelpContact&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.org, org) || other.org == org)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.category, category) || other.category == category)&&(identical(other.emergency, emergency) || other.emergency == emergency));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,org,phone,category,emergency);

@override
String toString() {
  return 'HelpContact(id: $id, title: $title, org: $org, phone: $phone, category: $category, emergency: $emergency)';
}


}

/// @nodoc
abstract mixin class $HelpContactCopyWith<$Res>  {
  factory $HelpContactCopyWith(HelpContact value, $Res Function(HelpContact) _then) = _$HelpContactCopyWithImpl;
@useResult
$Res call({
 String id, String title, String? org, String? phone, String? category, bool emergency
});




}
/// @nodoc
class _$HelpContactCopyWithImpl<$Res>
    implements $HelpContactCopyWith<$Res> {
  _$HelpContactCopyWithImpl(this._self, this._then);

  final HelpContact _self;
  final $Res Function(HelpContact) _then;

/// Create a copy of HelpContact
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? org = freezed,Object? phone = freezed,Object? category = freezed,Object? emergency = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,org: freezed == org ? _self.org : org // ignore: cast_nullable_to_non_nullable
as String?,phone: freezed == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String?,category: freezed == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String?,emergency: null == emergency ? _self.emergency : emergency // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [HelpContact].
extension HelpContactPatterns on HelpContact {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HelpContact value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HelpContact() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HelpContact value)  $default,){
final _that = this;
switch (_that) {
case _HelpContact():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HelpContact value)?  $default,){
final _that = this;
switch (_that) {
case _HelpContact() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String title,  String? org,  String? phone,  String? category,  bool emergency)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HelpContact() when $default != null:
return $default(_that.id,_that.title,_that.org,_that.phone,_that.category,_that.emergency);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String title,  String? org,  String? phone,  String? category,  bool emergency)  $default,) {final _that = this;
switch (_that) {
case _HelpContact():
return $default(_that.id,_that.title,_that.org,_that.phone,_that.category,_that.emergency);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String title,  String? org,  String? phone,  String? category,  bool emergency)?  $default,) {final _that = this;
switch (_that) {
case _HelpContact() when $default != null:
return $default(_that.id,_that.title,_that.org,_that.phone,_that.category,_that.emergency);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _HelpContact implements HelpContact {
  const _HelpContact({required this.id, required this.title, this.org, this.phone, this.category, this.emergency = false});
  factory _HelpContact.fromJson(Map<String, dynamic> json) => _$HelpContactFromJson(json);

@override final  String id;
@override final  String title;
@override final  String? org;
@override final  String? phone;
@override final  String? category;
@override@JsonKey() final  bool emergency;

/// Create a copy of HelpContact
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HelpContactCopyWith<_HelpContact> get copyWith => __$HelpContactCopyWithImpl<_HelpContact>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$HelpContactToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HelpContact&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.org, org) || other.org == org)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.category, category) || other.category == category)&&(identical(other.emergency, emergency) || other.emergency == emergency));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,org,phone,category,emergency);

@override
String toString() {
  return 'HelpContact(id: $id, title: $title, org: $org, phone: $phone, category: $category, emergency: $emergency)';
}


}

/// @nodoc
abstract mixin class _$HelpContactCopyWith<$Res> implements $HelpContactCopyWith<$Res> {
  factory _$HelpContactCopyWith(_HelpContact value, $Res Function(_HelpContact) _then) = __$HelpContactCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, String? org, String? phone, String? category, bool emergency
});




}
/// @nodoc
class __$HelpContactCopyWithImpl<$Res>
    implements _$HelpContactCopyWith<$Res> {
  __$HelpContactCopyWithImpl(this._self, this._then);

  final _HelpContact _self;
  final $Res Function(_HelpContact) _then;

/// Create a copy of HelpContact
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? org = freezed,Object? phone = freezed,Object? category = freezed,Object? emergency = null,}) {
  return _then(_HelpContact(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,org: freezed == org ? _self.org : org // ignore: cast_nullable_to_non_nullable
as String?,phone: freezed == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String?,category: freezed == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String?,emergency: null == emergency ? _self.emergency : emergency // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$HelpContactsResponse {

 List<HelpContact> get items;
/// Create a copy of HelpContactsResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HelpContactsResponseCopyWith<HelpContactsResponse> get copyWith => _$HelpContactsResponseCopyWithImpl<HelpContactsResponse>(this as HelpContactsResponse, _$identity);

  /// Serializes this HelpContactsResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HelpContactsResponse&&const DeepCollectionEquality().equals(other.items, items));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(items));

@override
String toString() {
  return 'HelpContactsResponse(items: $items)';
}


}

/// @nodoc
abstract mixin class $HelpContactsResponseCopyWith<$Res>  {
  factory $HelpContactsResponseCopyWith(HelpContactsResponse value, $Res Function(HelpContactsResponse) _then) = _$HelpContactsResponseCopyWithImpl;
@useResult
$Res call({
 List<HelpContact> items
});




}
/// @nodoc
class _$HelpContactsResponseCopyWithImpl<$Res>
    implements $HelpContactsResponseCopyWith<$Res> {
  _$HelpContactsResponseCopyWithImpl(this._self, this._then);

  final HelpContactsResponse _self;
  final $Res Function(HelpContactsResponse) _then;

/// Create a copy of HelpContactsResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? items = null,}) {
  return _then(_self.copyWith(
items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<HelpContact>,
  ));
}

}


/// Adds pattern-matching-related methods to [HelpContactsResponse].
extension HelpContactsResponsePatterns on HelpContactsResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HelpContactsResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HelpContactsResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HelpContactsResponse value)  $default,){
final _that = this;
switch (_that) {
case _HelpContactsResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HelpContactsResponse value)?  $default,){
final _that = this;
switch (_that) {
case _HelpContactsResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<HelpContact> items)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HelpContactsResponse() when $default != null:
return $default(_that.items);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<HelpContact> items)  $default,) {final _that = this;
switch (_that) {
case _HelpContactsResponse():
return $default(_that.items);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<HelpContact> items)?  $default,) {final _that = this;
switch (_that) {
case _HelpContactsResponse() when $default != null:
return $default(_that.items);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _HelpContactsResponse implements HelpContactsResponse {
  const _HelpContactsResponse({final  List<HelpContact> items = const <HelpContact>[]}): _items = items;
  factory _HelpContactsResponse.fromJson(Map<String, dynamic> json) => _$HelpContactsResponseFromJson(json);

 final  List<HelpContact> _items;
@override@JsonKey() List<HelpContact> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}


/// Create a copy of HelpContactsResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HelpContactsResponseCopyWith<_HelpContactsResponse> get copyWith => __$HelpContactsResponseCopyWithImpl<_HelpContactsResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$HelpContactsResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HelpContactsResponse&&const DeepCollectionEquality().equals(other._items, _items));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_items));

@override
String toString() {
  return 'HelpContactsResponse(items: $items)';
}


}

/// @nodoc
abstract mixin class _$HelpContactsResponseCopyWith<$Res> implements $HelpContactsResponseCopyWith<$Res> {
  factory _$HelpContactsResponseCopyWith(_HelpContactsResponse value, $Res Function(_HelpContactsResponse) _then) = __$HelpContactsResponseCopyWithImpl;
@override @useResult
$Res call({
 List<HelpContact> items
});




}
/// @nodoc
class __$HelpContactsResponseCopyWithImpl<$Res>
    implements _$HelpContactsResponseCopyWith<$Res> {
  __$HelpContactsResponseCopyWithImpl(this._self, this._then);

  final _HelpContactsResponse _self;
  final $Res Function(_HelpContactsResponse) _then;

/// Create a copy of HelpContactsResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? items = null,}) {
  return _then(_HelpContactsResponse(
items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<HelpContact>,
  ));
}


}

// dart format on
