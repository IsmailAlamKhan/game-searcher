// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'game_record.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$GameRecord {

 String get id; String get source; String get title; List<String> get platforms;@JsonKey(name: 'release_date') String? get releaseDate; String? get description;@JsonKey(name: 'image_url') String? get imageUrl; double? get score; Map<String, dynamic> get extra;
/// Create a copy of GameRecord
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GameRecordCopyWith<GameRecord> get copyWith => _$GameRecordCopyWithImpl<GameRecord>(this as GameRecord, _$identity);

  /// Serializes this GameRecord to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GameRecord&&(identical(other.id, id) || other.id == id)&&(identical(other.source, source) || other.source == source)&&(identical(other.title, title) || other.title == title)&&const DeepCollectionEquality().equals(other.platforms, platforms)&&(identical(other.releaseDate, releaseDate) || other.releaseDate == releaseDate)&&(identical(other.description, description) || other.description == description)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.score, score) || other.score == score)&&const DeepCollectionEquality().equals(other.extra, extra));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,source,title,const DeepCollectionEquality().hash(platforms),releaseDate,description,imageUrl,score,const DeepCollectionEquality().hash(extra));

@override
String toString() {
  return 'GameRecord(id: $id, source: $source, title: $title, platforms: $platforms, releaseDate: $releaseDate, description: $description, imageUrl: $imageUrl, score: $score, extra: $extra)';
}


}

/// @nodoc
abstract mixin class $GameRecordCopyWith<$Res>  {
  factory $GameRecordCopyWith(GameRecord value, $Res Function(GameRecord) _then) = _$GameRecordCopyWithImpl;
@useResult
$Res call({
 String id, String source, String title, List<String> platforms,@JsonKey(name: 'release_date') String? releaseDate, String? description,@JsonKey(name: 'image_url') String? imageUrl, double? score, Map<String, dynamic> extra
});




}
/// @nodoc
class _$GameRecordCopyWithImpl<$Res>
    implements $GameRecordCopyWith<$Res> {
  _$GameRecordCopyWithImpl(this._self, this._then);

  final GameRecord _self;
  final $Res Function(GameRecord) _then;

/// Create a copy of GameRecord
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? source = null,Object? title = null,Object? platforms = null,Object? releaseDate = freezed,Object? description = freezed,Object? imageUrl = freezed,Object? score = freezed,Object? extra = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,source: null == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,platforms: null == platforms ? _self.platforms : platforms // ignore: cast_nullable_to_non_nullable
as List<String>,releaseDate: freezed == releaseDate ? _self.releaseDate : releaseDate // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,score: freezed == score ? _self.score : score // ignore: cast_nullable_to_non_nullable
as double?,extra: null == extra ? _self.extra : extra // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,
  ));
}

}


/// Adds pattern-matching-related methods to [GameRecord].
extension GameRecordPatterns on GameRecord {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GameRecord value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GameRecord() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GameRecord value)  $default,){
final _that = this;
switch (_that) {
case _GameRecord():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GameRecord value)?  $default,){
final _that = this;
switch (_that) {
case _GameRecord() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String source,  String title,  List<String> platforms, @JsonKey(name: 'release_date')  String? releaseDate,  String? description, @JsonKey(name: 'image_url')  String? imageUrl,  double? score,  Map<String, dynamic> extra)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GameRecord() when $default != null:
return $default(_that.id,_that.source,_that.title,_that.platforms,_that.releaseDate,_that.description,_that.imageUrl,_that.score,_that.extra);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String source,  String title,  List<String> platforms, @JsonKey(name: 'release_date')  String? releaseDate,  String? description, @JsonKey(name: 'image_url')  String? imageUrl,  double? score,  Map<String, dynamic> extra)  $default,) {final _that = this;
switch (_that) {
case _GameRecord():
return $default(_that.id,_that.source,_that.title,_that.platforms,_that.releaseDate,_that.description,_that.imageUrl,_that.score,_that.extra);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String source,  String title,  List<String> platforms, @JsonKey(name: 'release_date')  String? releaseDate,  String? description, @JsonKey(name: 'image_url')  String? imageUrl,  double? score,  Map<String, dynamic> extra)?  $default,) {final _that = this;
switch (_that) {
case _GameRecord() when $default != null:
return $default(_that.id,_that.source,_that.title,_that.platforms,_that.releaseDate,_that.description,_that.imageUrl,_that.score,_that.extra);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _GameRecord implements GameRecord {
  const _GameRecord({required this.id, required this.source, required this.title, final  List<String> platforms = const [], @JsonKey(name: 'release_date') this.releaseDate, this.description, @JsonKey(name: 'image_url') this.imageUrl, this.score, final  Map<String, dynamic> extra = const {}}): _platforms = platforms,_extra = extra;
  factory _GameRecord.fromJson(Map<String, dynamic> json) => _$GameRecordFromJson(json);

@override final  String id;
@override final  String source;
@override final  String title;
 final  List<String> _platforms;
@override@JsonKey() List<String> get platforms {
  if (_platforms is EqualUnmodifiableListView) return _platforms;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_platforms);
}

@override@JsonKey(name: 'release_date') final  String? releaseDate;
@override final  String? description;
@override@JsonKey(name: 'image_url') final  String? imageUrl;
@override final  double? score;
 final  Map<String, dynamic> _extra;
@override@JsonKey() Map<String, dynamic> get extra {
  if (_extra is EqualUnmodifiableMapView) return _extra;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_extra);
}


/// Create a copy of GameRecord
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GameRecordCopyWith<_GameRecord> get copyWith => __$GameRecordCopyWithImpl<_GameRecord>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$GameRecordToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GameRecord&&(identical(other.id, id) || other.id == id)&&(identical(other.source, source) || other.source == source)&&(identical(other.title, title) || other.title == title)&&const DeepCollectionEquality().equals(other._platforms, _platforms)&&(identical(other.releaseDate, releaseDate) || other.releaseDate == releaseDate)&&(identical(other.description, description) || other.description == description)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.score, score) || other.score == score)&&const DeepCollectionEquality().equals(other._extra, _extra));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,source,title,const DeepCollectionEquality().hash(_platforms),releaseDate,description,imageUrl,score,const DeepCollectionEquality().hash(_extra));

@override
String toString() {
  return 'GameRecord(id: $id, source: $source, title: $title, platforms: $platforms, releaseDate: $releaseDate, description: $description, imageUrl: $imageUrl, score: $score, extra: $extra)';
}


}

/// @nodoc
abstract mixin class _$GameRecordCopyWith<$Res> implements $GameRecordCopyWith<$Res> {
  factory _$GameRecordCopyWith(_GameRecord value, $Res Function(_GameRecord) _then) = __$GameRecordCopyWithImpl;
@override @useResult
$Res call({
 String id, String source, String title, List<String> platforms,@JsonKey(name: 'release_date') String? releaseDate, String? description,@JsonKey(name: 'image_url') String? imageUrl, double? score, Map<String, dynamic> extra
});




}
/// @nodoc
class __$GameRecordCopyWithImpl<$Res>
    implements _$GameRecordCopyWith<$Res> {
  __$GameRecordCopyWithImpl(this._self, this._then);

  final _GameRecord _self;
  final $Res Function(_GameRecord) _then;

/// Create a copy of GameRecord
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? source = null,Object? title = null,Object? platforms = null,Object? releaseDate = freezed,Object? description = freezed,Object? imageUrl = freezed,Object? score = freezed,Object? extra = null,}) {
  return _then(_GameRecord(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,source: null == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,platforms: null == platforms ? _self._platforms : platforms // ignore: cast_nullable_to_non_nullable
as List<String>,releaseDate: freezed == releaseDate ? _self.releaseDate : releaseDate // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,score: freezed == score ? _self.score : score // ignore: cast_nullable_to_non_nullable
as double?,extra: null == extra ? _self._extra : extra // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,
  ));
}


}

// dart format on
