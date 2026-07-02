// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'analyze_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AnalyzeRequest {

@JsonKey(name: 'image_base64') String get imageBase64;@JsonKey(name: 'media_type') String get mediaType;@JsonKey(name: 'output_mode') String get outputMode; String get lang; bool get save;@JsonKey(includeIfNull: false) String? get hint;
/// Create a copy of AnalyzeRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AnalyzeRequestCopyWith<AnalyzeRequest> get copyWith => _$AnalyzeRequestCopyWithImpl<AnalyzeRequest>(this as AnalyzeRequest, _$identity);

  /// Serializes this AnalyzeRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AnalyzeRequest&&(identical(other.imageBase64, imageBase64) || other.imageBase64 == imageBase64)&&(identical(other.mediaType, mediaType) || other.mediaType == mediaType)&&(identical(other.outputMode, outputMode) || other.outputMode == outputMode)&&(identical(other.lang, lang) || other.lang == lang)&&(identical(other.save, save) || other.save == save)&&(identical(other.hint, hint) || other.hint == hint));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,imageBase64,mediaType,outputMode,lang,save,hint);

@override
String toString() {
  return 'AnalyzeRequest(imageBase64: $imageBase64, mediaType: $mediaType, outputMode: $outputMode, lang: $lang, save: $save, hint: $hint)';
}


}

/// @nodoc
abstract mixin class $AnalyzeRequestCopyWith<$Res>  {
  factory $AnalyzeRequestCopyWith(AnalyzeRequest value, $Res Function(AnalyzeRequest) _then) = _$AnalyzeRequestCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'image_base64') String imageBase64,@JsonKey(name: 'media_type') String mediaType,@JsonKey(name: 'output_mode') String outputMode, String lang, bool save,@JsonKey(includeIfNull: false) String? hint
});




}
/// @nodoc
class _$AnalyzeRequestCopyWithImpl<$Res>
    implements $AnalyzeRequestCopyWith<$Res> {
  _$AnalyzeRequestCopyWithImpl(this._self, this._then);

  final AnalyzeRequest _self;
  final $Res Function(AnalyzeRequest) _then;

/// Create a copy of AnalyzeRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? imageBase64 = null,Object? mediaType = null,Object? outputMode = null,Object? lang = null,Object? save = null,Object? hint = freezed,}) {
  return _then(_self.copyWith(
imageBase64: null == imageBase64 ? _self.imageBase64 : imageBase64 // ignore: cast_nullable_to_non_nullable
as String,mediaType: null == mediaType ? _self.mediaType : mediaType // ignore: cast_nullable_to_non_nullable
as String,outputMode: null == outputMode ? _self.outputMode : outputMode // ignore: cast_nullable_to_non_nullable
as String,lang: null == lang ? _self.lang : lang // ignore: cast_nullable_to_non_nullable
as String,save: null == save ? _self.save : save // ignore: cast_nullable_to_non_nullable
as bool,hint: freezed == hint ? _self.hint : hint // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [AnalyzeRequest].
extension AnalyzeRequestPatterns on AnalyzeRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AnalyzeRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AnalyzeRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AnalyzeRequest value)  $default,){
final _that = this;
switch (_that) {
case _AnalyzeRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AnalyzeRequest value)?  $default,){
final _that = this;
switch (_that) {
case _AnalyzeRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'image_base64')  String imageBase64, @JsonKey(name: 'media_type')  String mediaType, @JsonKey(name: 'output_mode')  String outputMode,  String lang,  bool save, @JsonKey(includeIfNull: false)  String? hint)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AnalyzeRequest() when $default != null:
return $default(_that.imageBase64,_that.mediaType,_that.outputMode,_that.lang,_that.save,_that.hint);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'image_base64')  String imageBase64, @JsonKey(name: 'media_type')  String mediaType, @JsonKey(name: 'output_mode')  String outputMode,  String lang,  bool save, @JsonKey(includeIfNull: false)  String? hint)  $default,) {final _that = this;
switch (_that) {
case _AnalyzeRequest():
return $default(_that.imageBase64,_that.mediaType,_that.outputMode,_that.lang,_that.save,_that.hint);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'image_base64')  String imageBase64, @JsonKey(name: 'media_type')  String mediaType, @JsonKey(name: 'output_mode')  String outputMode,  String lang,  bool save, @JsonKey(includeIfNull: false)  String? hint)?  $default,) {final _that = this;
switch (_that) {
case _AnalyzeRequest() when $default != null:
return $default(_that.imageBase64,_that.mediaType,_that.outputMode,_that.lang,_that.save,_that.hint);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AnalyzeRequest implements AnalyzeRequest {
  const _AnalyzeRequest({@JsonKey(name: 'image_base64') required this.imageBase64, @JsonKey(name: 'media_type') required this.mediaType, @JsonKey(name: 'output_mode') required this.outputMode, required this.lang, this.save = true, @JsonKey(includeIfNull: false) this.hint});
  factory _AnalyzeRequest.fromJson(Map<String, dynamic> json) => _$AnalyzeRequestFromJson(json);

@override@JsonKey(name: 'image_base64') final  String imageBase64;
@override@JsonKey(name: 'media_type') final  String mediaType;
@override@JsonKey(name: 'output_mode') final  String outputMode;
@override final  String lang;
@override@JsonKey() final  bool save;
@override@JsonKey(includeIfNull: false) final  String? hint;

/// Create a copy of AnalyzeRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AnalyzeRequestCopyWith<_AnalyzeRequest> get copyWith => __$AnalyzeRequestCopyWithImpl<_AnalyzeRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AnalyzeRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AnalyzeRequest&&(identical(other.imageBase64, imageBase64) || other.imageBase64 == imageBase64)&&(identical(other.mediaType, mediaType) || other.mediaType == mediaType)&&(identical(other.outputMode, outputMode) || other.outputMode == outputMode)&&(identical(other.lang, lang) || other.lang == lang)&&(identical(other.save, save) || other.save == save)&&(identical(other.hint, hint) || other.hint == hint));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,imageBase64,mediaType,outputMode,lang,save,hint);

@override
String toString() {
  return 'AnalyzeRequest(imageBase64: $imageBase64, mediaType: $mediaType, outputMode: $outputMode, lang: $lang, save: $save, hint: $hint)';
}


}

/// @nodoc
abstract mixin class _$AnalyzeRequestCopyWith<$Res> implements $AnalyzeRequestCopyWith<$Res> {
  factory _$AnalyzeRequestCopyWith(_AnalyzeRequest value, $Res Function(_AnalyzeRequest) _then) = __$AnalyzeRequestCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'image_base64') String imageBase64,@JsonKey(name: 'media_type') String mediaType,@JsonKey(name: 'output_mode') String outputMode, String lang, bool save,@JsonKey(includeIfNull: false) String? hint
});




}
/// @nodoc
class __$AnalyzeRequestCopyWithImpl<$Res>
    implements _$AnalyzeRequestCopyWith<$Res> {
  __$AnalyzeRequestCopyWithImpl(this._self, this._then);

  final _AnalyzeRequest _self;
  final $Res Function(_AnalyzeRequest) _then;

/// Create a copy of AnalyzeRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? imageBase64 = null,Object? mediaType = null,Object? outputMode = null,Object? lang = null,Object? save = null,Object? hint = freezed,}) {
  return _then(_AnalyzeRequest(
imageBase64: null == imageBase64 ? _self.imageBase64 : imageBase64 // ignore: cast_nullable_to_non_nullable
as String,mediaType: null == mediaType ? _self.mediaType : mediaType // ignore: cast_nullable_to_non_nullable
as String,outputMode: null == outputMode ? _self.outputMode : outputMode // ignore: cast_nullable_to_non_nullable
as String,lang: null == lang ? _self.lang : lang // ignore: cast_nullable_to_non_nullable
as String,save: null == save ? _self.save : save // ignore: cast_nullable_to_non_nullable
as bool,hint: freezed == hint ? _self.hint : hint // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
