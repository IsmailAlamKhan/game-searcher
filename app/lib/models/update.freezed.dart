// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'update.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Update {

 String get version; String get changelog; String get downloadUrl; int get fileSize; String? get checksum; DateTime? get releaseDate;
/// Create a copy of Update
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UpdateCopyWith<Update> get copyWith => _$UpdateCopyWithImpl<Update>(this as Update, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Update&&(identical(other.version, version) || other.version == version)&&(identical(other.changelog, changelog) || other.changelog == changelog)&&(identical(other.downloadUrl, downloadUrl) || other.downloadUrl == downloadUrl)&&(identical(other.fileSize, fileSize) || other.fileSize == fileSize)&&(identical(other.checksum, checksum) || other.checksum == checksum)&&(identical(other.releaseDate, releaseDate) || other.releaseDate == releaseDate));
}


@override
int get hashCode => Object.hash(runtimeType,version,changelog,downloadUrl,fileSize,checksum,releaseDate);

@override
String toString() {
  return 'Update(version: $version, changelog: $changelog, downloadUrl: $downloadUrl, fileSize: $fileSize, checksum: $checksum, releaseDate: $releaseDate)';
}


}

/// @nodoc
abstract mixin class $UpdateCopyWith<$Res>  {
  factory $UpdateCopyWith(Update value, $Res Function(Update) _then) = _$UpdateCopyWithImpl;
@useResult
$Res call({
 String version, String changelog, String downloadUrl, int fileSize, String? checksum, DateTime? releaseDate
});




}
/// @nodoc
class _$UpdateCopyWithImpl<$Res>
    implements $UpdateCopyWith<$Res> {
  _$UpdateCopyWithImpl(this._self, this._then);

  final Update _self;
  final $Res Function(Update) _then;

/// Create a copy of Update
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? version = null,Object? changelog = null,Object? downloadUrl = null,Object? fileSize = null,Object? checksum = freezed,Object? releaseDate = freezed,}) {
  return _then(_self.copyWith(
version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as String,changelog: null == changelog ? _self.changelog : changelog // ignore: cast_nullable_to_non_nullable
as String,downloadUrl: null == downloadUrl ? _self.downloadUrl : downloadUrl // ignore: cast_nullable_to_non_nullable
as String,fileSize: null == fileSize ? _self.fileSize : fileSize // ignore: cast_nullable_to_non_nullable
as int,checksum: freezed == checksum ? _self.checksum : checksum // ignore: cast_nullable_to_non_nullable
as String?,releaseDate: freezed == releaseDate ? _self.releaseDate : releaseDate // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [Update].
extension UpdatePatterns on Update {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Update value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Update() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Update value)  $default,){
final _that = this;
switch (_that) {
case _Update():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Update value)?  $default,){
final _that = this;
switch (_that) {
case _Update() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String version,  String changelog,  String downloadUrl,  int fileSize,  String? checksum,  DateTime? releaseDate)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Update() when $default != null:
return $default(_that.version,_that.changelog,_that.downloadUrl,_that.fileSize,_that.checksum,_that.releaseDate);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String version,  String changelog,  String downloadUrl,  int fileSize,  String? checksum,  DateTime? releaseDate)  $default,) {final _that = this;
switch (_that) {
case _Update():
return $default(_that.version,_that.changelog,_that.downloadUrl,_that.fileSize,_that.checksum,_that.releaseDate);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String version,  String changelog,  String downloadUrl,  int fileSize,  String? checksum,  DateTime? releaseDate)?  $default,) {final _that = this;
switch (_that) {
case _Update() when $default != null:
return $default(_that.version,_that.changelog,_that.downloadUrl,_that.fileSize,_that.checksum,_that.releaseDate);case _:
  return null;

}
}

}

/// @nodoc


class _Update implements Update {
  const _Update({required this.version, required this.changelog, required this.downloadUrl, required this.fileSize, this.checksum, this.releaseDate});
  

@override final  String version;
@override final  String changelog;
@override final  String downloadUrl;
@override final  int fileSize;
@override final  String? checksum;
@override final  DateTime? releaseDate;

/// Create a copy of Update
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UpdateCopyWith<_Update> get copyWith => __$UpdateCopyWithImpl<_Update>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Update&&(identical(other.version, version) || other.version == version)&&(identical(other.changelog, changelog) || other.changelog == changelog)&&(identical(other.downloadUrl, downloadUrl) || other.downloadUrl == downloadUrl)&&(identical(other.fileSize, fileSize) || other.fileSize == fileSize)&&(identical(other.checksum, checksum) || other.checksum == checksum)&&(identical(other.releaseDate, releaseDate) || other.releaseDate == releaseDate));
}


@override
int get hashCode => Object.hash(runtimeType,version,changelog,downloadUrl,fileSize,checksum,releaseDate);

@override
String toString() {
  return 'Update(version: $version, changelog: $changelog, downloadUrl: $downloadUrl, fileSize: $fileSize, checksum: $checksum, releaseDate: $releaseDate)';
}


}

/// @nodoc
abstract mixin class _$UpdateCopyWith<$Res> implements $UpdateCopyWith<$Res> {
  factory _$UpdateCopyWith(_Update value, $Res Function(_Update) _then) = __$UpdateCopyWithImpl;
@override @useResult
$Res call({
 String version, String changelog, String downloadUrl, int fileSize, String? checksum, DateTime? releaseDate
});




}
/// @nodoc
class __$UpdateCopyWithImpl<$Res>
    implements _$UpdateCopyWith<$Res> {
  __$UpdateCopyWithImpl(this._self, this._then);

  final _Update _self;
  final $Res Function(_Update) _then;

/// Create a copy of Update
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? version = null,Object? changelog = null,Object? downloadUrl = null,Object? fileSize = null,Object? checksum = freezed,Object? releaseDate = freezed,}) {
  return _then(_Update(
version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as String,changelog: null == changelog ? _self.changelog : changelog // ignore: cast_nullable_to_non_nullable
as String,downloadUrl: null == downloadUrl ? _self.downloadUrl : downloadUrl // ignore: cast_nullable_to_non_nullable
as String,fileSize: null == fileSize ? _self.fileSize : fileSize // ignore: cast_nullable_to_non_nullable
as int,checksum: freezed == checksum ? _self.checksum : checksum // ignore: cast_nullable_to_non_nullable
as String?,releaseDate: freezed == releaseDate ? _self.releaseDate : releaseDate // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
