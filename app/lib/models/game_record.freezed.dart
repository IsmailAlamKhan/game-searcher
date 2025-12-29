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

 String get id; String get source; String get title; List<Platform> get platforms;@JsonKey(name: 'release_date')@StringToDateConverter() DateTime? get releaseDate; String? get description;@JsonKey(name: 'image_url') String? get imageUrl; double? get score; List<Store> get stores; String? get website; List<String> get screenshots; List<Trailer> get trailers; List<DLC> get dlcs;@JsonKey(name: 'same_series') List<SameSeries> get sameSeries;@JsonKey(name: 'reddit_posts') List<RedditPost> get redditPosts; Map<String, dynamic> get extra;
/// Create a copy of GameRecord
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GameRecordCopyWith<GameRecord> get copyWith => _$GameRecordCopyWithImpl<GameRecord>(this as GameRecord, _$identity);

  /// Serializes this GameRecord to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GameRecord&&(identical(other.id, id) || other.id == id)&&(identical(other.source, source) || other.source == source)&&(identical(other.title, title) || other.title == title)&&const DeepCollectionEquality().equals(other.platforms, platforms)&&(identical(other.releaseDate, releaseDate) || other.releaseDate == releaseDate)&&(identical(other.description, description) || other.description == description)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.score, score) || other.score == score)&&const DeepCollectionEquality().equals(other.stores, stores)&&(identical(other.website, website) || other.website == website)&&const DeepCollectionEquality().equals(other.screenshots, screenshots)&&const DeepCollectionEquality().equals(other.trailers, trailers)&&const DeepCollectionEquality().equals(other.dlcs, dlcs)&&const DeepCollectionEquality().equals(other.sameSeries, sameSeries)&&const DeepCollectionEquality().equals(other.redditPosts, redditPosts)&&const DeepCollectionEquality().equals(other.extra, extra));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,source,title,const DeepCollectionEquality().hash(platforms),releaseDate,description,imageUrl,score,const DeepCollectionEquality().hash(stores),website,const DeepCollectionEquality().hash(screenshots),const DeepCollectionEquality().hash(trailers),const DeepCollectionEquality().hash(dlcs),const DeepCollectionEquality().hash(sameSeries),const DeepCollectionEquality().hash(redditPosts),const DeepCollectionEquality().hash(extra));

@override
String toString() {
  return 'GameRecord(id: $id, source: $source, title: $title, platforms: $platforms, releaseDate: $releaseDate, description: $description, imageUrl: $imageUrl, score: $score, stores: $stores, website: $website, screenshots: $screenshots, trailers: $trailers, dlcs: $dlcs, sameSeries: $sameSeries, redditPosts: $redditPosts, extra: $extra)';
}


}

/// @nodoc
abstract mixin class $GameRecordCopyWith<$Res>  {
  factory $GameRecordCopyWith(GameRecord value, $Res Function(GameRecord) _then) = _$GameRecordCopyWithImpl;
@useResult
$Res call({
 String id, String source, String title, List<Platform> platforms,@JsonKey(name: 'release_date')@StringToDateConverter() DateTime? releaseDate, String? description,@JsonKey(name: 'image_url') String? imageUrl, double? score, List<Store> stores, String? website, List<String> screenshots, List<Trailer> trailers, List<DLC> dlcs,@JsonKey(name: 'same_series') List<SameSeries> sameSeries,@JsonKey(name: 'reddit_posts') List<RedditPost> redditPosts, Map<String, dynamic> extra
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
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? source = null,Object? title = null,Object? platforms = null,Object? releaseDate = freezed,Object? description = freezed,Object? imageUrl = freezed,Object? score = freezed,Object? stores = null,Object? website = freezed,Object? screenshots = null,Object? trailers = null,Object? dlcs = null,Object? sameSeries = null,Object? redditPosts = null,Object? extra = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,source: null == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,platforms: null == platforms ? _self.platforms : platforms // ignore: cast_nullable_to_non_nullable
as List<Platform>,releaseDate: freezed == releaseDate ? _self.releaseDate : releaseDate // ignore: cast_nullable_to_non_nullable
as DateTime?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,score: freezed == score ? _self.score : score // ignore: cast_nullable_to_non_nullable
as double?,stores: null == stores ? _self.stores : stores // ignore: cast_nullable_to_non_nullable
as List<Store>,website: freezed == website ? _self.website : website // ignore: cast_nullable_to_non_nullable
as String?,screenshots: null == screenshots ? _self.screenshots : screenshots // ignore: cast_nullable_to_non_nullable
as List<String>,trailers: null == trailers ? _self.trailers : trailers // ignore: cast_nullable_to_non_nullable
as List<Trailer>,dlcs: null == dlcs ? _self.dlcs : dlcs // ignore: cast_nullable_to_non_nullable
as List<DLC>,sameSeries: null == sameSeries ? _self.sameSeries : sameSeries // ignore: cast_nullable_to_non_nullable
as List<SameSeries>,redditPosts: null == redditPosts ? _self.redditPosts : redditPosts // ignore: cast_nullable_to_non_nullable
as List<RedditPost>,extra: null == extra ? _self.extra : extra // ignore: cast_nullable_to_non_nullable
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String source,  String title,  List<Platform> platforms, @JsonKey(name: 'release_date')@StringToDateConverter()  DateTime? releaseDate,  String? description, @JsonKey(name: 'image_url')  String? imageUrl,  double? score,  List<Store> stores,  String? website,  List<String> screenshots,  List<Trailer> trailers,  List<DLC> dlcs, @JsonKey(name: 'same_series')  List<SameSeries> sameSeries, @JsonKey(name: 'reddit_posts')  List<RedditPost> redditPosts,  Map<String, dynamic> extra)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GameRecord() when $default != null:
return $default(_that.id,_that.source,_that.title,_that.platforms,_that.releaseDate,_that.description,_that.imageUrl,_that.score,_that.stores,_that.website,_that.screenshots,_that.trailers,_that.dlcs,_that.sameSeries,_that.redditPosts,_that.extra);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String source,  String title,  List<Platform> platforms, @JsonKey(name: 'release_date')@StringToDateConverter()  DateTime? releaseDate,  String? description, @JsonKey(name: 'image_url')  String? imageUrl,  double? score,  List<Store> stores,  String? website,  List<String> screenshots,  List<Trailer> trailers,  List<DLC> dlcs, @JsonKey(name: 'same_series')  List<SameSeries> sameSeries, @JsonKey(name: 'reddit_posts')  List<RedditPost> redditPosts,  Map<String, dynamic> extra)  $default,) {final _that = this;
switch (_that) {
case _GameRecord():
return $default(_that.id,_that.source,_that.title,_that.platforms,_that.releaseDate,_that.description,_that.imageUrl,_that.score,_that.stores,_that.website,_that.screenshots,_that.trailers,_that.dlcs,_that.sameSeries,_that.redditPosts,_that.extra);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String source,  String title,  List<Platform> platforms, @JsonKey(name: 'release_date')@StringToDateConverter()  DateTime? releaseDate,  String? description, @JsonKey(name: 'image_url')  String? imageUrl,  double? score,  List<Store> stores,  String? website,  List<String> screenshots,  List<Trailer> trailers,  List<DLC> dlcs, @JsonKey(name: 'same_series')  List<SameSeries> sameSeries, @JsonKey(name: 'reddit_posts')  List<RedditPost> redditPosts,  Map<String, dynamic> extra)?  $default,) {final _that = this;
switch (_that) {
case _GameRecord() when $default != null:
return $default(_that.id,_that.source,_that.title,_that.platforms,_that.releaseDate,_that.description,_that.imageUrl,_that.score,_that.stores,_that.website,_that.screenshots,_that.trailers,_that.dlcs,_that.sameSeries,_that.redditPosts,_that.extra);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _GameRecord implements GameRecord {
  const _GameRecord({required this.id, required this.source, required this.title, final  List<Platform> platforms = const [], @JsonKey(name: 'release_date')@StringToDateConverter() this.releaseDate, this.description, @JsonKey(name: 'image_url') this.imageUrl, this.score, final  List<Store> stores = const [], this.website, final  List<String> screenshots = const [], final  List<Trailer> trailers = const [], final  List<DLC> dlcs = const [], @JsonKey(name: 'same_series') final  List<SameSeries> sameSeries = const [], @JsonKey(name: 'reddit_posts') final  List<RedditPost> redditPosts = const [], final  Map<String, dynamic> extra = const {}}): _platforms = platforms,_stores = stores,_screenshots = screenshots,_trailers = trailers,_dlcs = dlcs,_sameSeries = sameSeries,_redditPosts = redditPosts,_extra = extra;
  factory _GameRecord.fromJson(Map<String, dynamic> json) => _$GameRecordFromJson(json);

@override final  String id;
@override final  String source;
@override final  String title;
 final  List<Platform> _platforms;
@override@JsonKey() List<Platform> get platforms {
  if (_platforms is EqualUnmodifiableListView) return _platforms;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_platforms);
}

@override@JsonKey(name: 'release_date')@StringToDateConverter() final  DateTime? releaseDate;
@override final  String? description;
@override@JsonKey(name: 'image_url') final  String? imageUrl;
@override final  double? score;
 final  List<Store> _stores;
@override@JsonKey() List<Store> get stores {
  if (_stores is EqualUnmodifiableListView) return _stores;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_stores);
}

@override final  String? website;
 final  List<String> _screenshots;
@override@JsonKey() List<String> get screenshots {
  if (_screenshots is EqualUnmodifiableListView) return _screenshots;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_screenshots);
}

 final  List<Trailer> _trailers;
@override@JsonKey() List<Trailer> get trailers {
  if (_trailers is EqualUnmodifiableListView) return _trailers;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_trailers);
}

 final  List<DLC> _dlcs;
@override@JsonKey() List<DLC> get dlcs {
  if (_dlcs is EqualUnmodifiableListView) return _dlcs;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_dlcs);
}

 final  List<SameSeries> _sameSeries;
@override@JsonKey(name: 'same_series') List<SameSeries> get sameSeries {
  if (_sameSeries is EqualUnmodifiableListView) return _sameSeries;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_sameSeries);
}

 final  List<RedditPost> _redditPosts;
@override@JsonKey(name: 'reddit_posts') List<RedditPost> get redditPosts {
  if (_redditPosts is EqualUnmodifiableListView) return _redditPosts;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_redditPosts);
}

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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GameRecord&&(identical(other.id, id) || other.id == id)&&(identical(other.source, source) || other.source == source)&&(identical(other.title, title) || other.title == title)&&const DeepCollectionEquality().equals(other._platforms, _platforms)&&(identical(other.releaseDate, releaseDate) || other.releaseDate == releaseDate)&&(identical(other.description, description) || other.description == description)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.score, score) || other.score == score)&&const DeepCollectionEquality().equals(other._stores, _stores)&&(identical(other.website, website) || other.website == website)&&const DeepCollectionEquality().equals(other._screenshots, _screenshots)&&const DeepCollectionEquality().equals(other._trailers, _trailers)&&const DeepCollectionEquality().equals(other._dlcs, _dlcs)&&const DeepCollectionEquality().equals(other._sameSeries, _sameSeries)&&const DeepCollectionEquality().equals(other._redditPosts, _redditPosts)&&const DeepCollectionEquality().equals(other._extra, _extra));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,source,title,const DeepCollectionEquality().hash(_platforms),releaseDate,description,imageUrl,score,const DeepCollectionEquality().hash(_stores),website,const DeepCollectionEquality().hash(_screenshots),const DeepCollectionEquality().hash(_trailers),const DeepCollectionEquality().hash(_dlcs),const DeepCollectionEquality().hash(_sameSeries),const DeepCollectionEquality().hash(_redditPosts),const DeepCollectionEquality().hash(_extra));

@override
String toString() {
  return 'GameRecord(id: $id, source: $source, title: $title, platforms: $platforms, releaseDate: $releaseDate, description: $description, imageUrl: $imageUrl, score: $score, stores: $stores, website: $website, screenshots: $screenshots, trailers: $trailers, dlcs: $dlcs, sameSeries: $sameSeries, redditPosts: $redditPosts, extra: $extra)';
}


}

/// @nodoc
abstract mixin class _$GameRecordCopyWith<$Res> implements $GameRecordCopyWith<$Res> {
  factory _$GameRecordCopyWith(_GameRecord value, $Res Function(_GameRecord) _then) = __$GameRecordCopyWithImpl;
@override @useResult
$Res call({
 String id, String source, String title, List<Platform> platforms,@JsonKey(name: 'release_date')@StringToDateConverter() DateTime? releaseDate, String? description,@JsonKey(name: 'image_url') String? imageUrl, double? score, List<Store> stores, String? website, List<String> screenshots, List<Trailer> trailers, List<DLC> dlcs,@JsonKey(name: 'same_series') List<SameSeries> sameSeries,@JsonKey(name: 'reddit_posts') List<RedditPost> redditPosts, Map<String, dynamic> extra
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
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? source = null,Object? title = null,Object? platforms = null,Object? releaseDate = freezed,Object? description = freezed,Object? imageUrl = freezed,Object? score = freezed,Object? stores = null,Object? website = freezed,Object? screenshots = null,Object? trailers = null,Object? dlcs = null,Object? sameSeries = null,Object? redditPosts = null,Object? extra = null,}) {
  return _then(_GameRecord(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,source: null == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,platforms: null == platforms ? _self._platforms : platforms // ignore: cast_nullable_to_non_nullable
as List<Platform>,releaseDate: freezed == releaseDate ? _self.releaseDate : releaseDate // ignore: cast_nullable_to_non_nullable
as DateTime?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,score: freezed == score ? _self.score : score // ignore: cast_nullable_to_non_nullable
as double?,stores: null == stores ? _self._stores : stores // ignore: cast_nullable_to_non_nullable
as List<Store>,website: freezed == website ? _self.website : website // ignore: cast_nullable_to_non_nullable
as String?,screenshots: null == screenshots ? _self._screenshots : screenshots // ignore: cast_nullable_to_non_nullable
as List<String>,trailers: null == trailers ? _self._trailers : trailers // ignore: cast_nullable_to_non_nullable
as List<Trailer>,dlcs: null == dlcs ? _self._dlcs : dlcs // ignore: cast_nullable_to_non_nullable
as List<DLC>,sameSeries: null == sameSeries ? _self._sameSeries : sameSeries // ignore: cast_nullable_to_non_nullable
as List<SameSeries>,redditPosts: null == redditPosts ? _self._redditPosts : redditPosts // ignore: cast_nullable_to_non_nullable
as List<RedditPost>,extra: null == extra ? _self._extra : extra // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,
  ));
}


}


/// @nodoc
mixin _$Store {

 int get id; String? get name; String? get url; String? get image;@StringToColorConverter() Color? get color;
/// Create a copy of Store
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StoreCopyWith<Store> get copyWith => _$StoreCopyWithImpl<Store>(this as Store, _$identity);

  /// Serializes this Store to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Store&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.url, url) || other.url == url)&&(identical(other.image, image) || other.image == image)&&(identical(other.color, color) || other.color == color));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,url,image,color);

@override
String toString() {
  return 'Store(id: $id, name: $name, url: $url, image: $image, color: $color)';
}


}

/// @nodoc
abstract mixin class $StoreCopyWith<$Res>  {
  factory $StoreCopyWith(Store value, $Res Function(Store) _then) = _$StoreCopyWithImpl;
@useResult
$Res call({
 int id, String? name, String? url, String? image,@StringToColorConverter() Color? color
});




}
/// @nodoc
class _$StoreCopyWithImpl<$Res>
    implements $StoreCopyWith<$Res> {
  _$StoreCopyWithImpl(this._self, this._then);

  final Store _self;
  final $Res Function(Store) _then;

/// Create a copy of Store
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = freezed,Object? url = freezed,Object? image = freezed,Object? color = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,url: freezed == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String?,image: freezed == image ? _self.image : image // ignore: cast_nullable_to_non_nullable
as String?,color: freezed == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as Color?,
  ));
}

}


/// Adds pattern-matching-related methods to [Store].
extension StorePatterns on Store {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Store value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Store() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Store value)  $default,){
final _that = this;
switch (_that) {
case _Store():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Store value)?  $default,){
final _that = this;
switch (_that) {
case _Store() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String? name,  String? url,  String? image, @StringToColorConverter()  Color? color)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Store() when $default != null:
return $default(_that.id,_that.name,_that.url,_that.image,_that.color);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String? name,  String? url,  String? image, @StringToColorConverter()  Color? color)  $default,) {final _that = this;
switch (_that) {
case _Store():
return $default(_that.id,_that.name,_that.url,_that.image,_that.color);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String? name,  String? url,  String? image, @StringToColorConverter()  Color? color)?  $default,) {final _that = this;
switch (_that) {
case _Store() when $default != null:
return $default(_that.id,_that.name,_that.url,_that.image,_that.color);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Store implements Store {
  const _Store({required this.id, this.name, this.url, this.image, @StringToColorConverter() this.color});
  factory _Store.fromJson(Map<String, dynamic> json) => _$StoreFromJson(json);

@override final  int id;
@override final  String? name;
@override final  String? url;
@override final  String? image;
@override@StringToColorConverter() final  Color? color;

/// Create a copy of Store
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StoreCopyWith<_Store> get copyWith => __$StoreCopyWithImpl<_Store>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$StoreToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Store&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.url, url) || other.url == url)&&(identical(other.image, image) || other.image == image)&&(identical(other.color, color) || other.color == color));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,url,image,color);

@override
String toString() {
  return 'Store(id: $id, name: $name, url: $url, image: $image, color: $color)';
}


}

/// @nodoc
abstract mixin class _$StoreCopyWith<$Res> implements $StoreCopyWith<$Res> {
  factory _$StoreCopyWith(_Store value, $Res Function(_Store) _then) = __$StoreCopyWithImpl;
@override @useResult
$Res call({
 int id, String? name, String? url, String? image,@StringToColorConverter() Color? color
});




}
/// @nodoc
class __$StoreCopyWithImpl<$Res>
    implements _$StoreCopyWith<$Res> {
  __$StoreCopyWithImpl(this._self, this._then);

  final _Store _self;
  final $Res Function(_Store) _then;

/// Create a copy of Store
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = freezed,Object? url = freezed,Object? image = freezed,Object? color = freezed,}) {
  return _then(_Store(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,url: freezed == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String?,image: freezed == image ? _self.image : image // ignore: cast_nullable_to_non_nullable
as String?,color: freezed == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as Color?,
  ));
}


}


/// @nodoc
mixin _$Trailer {

 String? get name; String? get preview; String? get video;
/// Create a copy of Trailer
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TrailerCopyWith<Trailer> get copyWith => _$TrailerCopyWithImpl<Trailer>(this as Trailer, _$identity);

  /// Serializes this Trailer to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Trailer&&(identical(other.name, name) || other.name == name)&&(identical(other.preview, preview) || other.preview == preview)&&(identical(other.video, video) || other.video == video));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,preview,video);

@override
String toString() {
  return 'Trailer(name: $name, preview: $preview, video: $video)';
}


}

/// @nodoc
abstract mixin class $TrailerCopyWith<$Res>  {
  factory $TrailerCopyWith(Trailer value, $Res Function(Trailer) _then) = _$TrailerCopyWithImpl;
@useResult
$Res call({
 String? name, String? preview, String? video
});




}
/// @nodoc
class _$TrailerCopyWithImpl<$Res>
    implements $TrailerCopyWith<$Res> {
  _$TrailerCopyWithImpl(this._self, this._then);

  final Trailer _self;
  final $Res Function(Trailer) _then;

/// Create a copy of Trailer
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = freezed,Object? preview = freezed,Object? video = freezed,}) {
  return _then(_self.copyWith(
name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,preview: freezed == preview ? _self.preview : preview // ignore: cast_nullable_to_non_nullable
as String?,video: freezed == video ? _self.video : video // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [Trailer].
extension TrailerPatterns on Trailer {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Trailer value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Trailer() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Trailer value)  $default,){
final _that = this;
switch (_that) {
case _Trailer():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Trailer value)?  $default,){
final _that = this;
switch (_that) {
case _Trailer() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? name,  String? preview,  String? video)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Trailer() when $default != null:
return $default(_that.name,_that.preview,_that.video);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? name,  String? preview,  String? video)  $default,) {final _that = this;
switch (_that) {
case _Trailer():
return $default(_that.name,_that.preview,_that.video);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? name,  String? preview,  String? video)?  $default,) {final _that = this;
switch (_that) {
case _Trailer() when $default != null:
return $default(_that.name,_that.preview,_that.video);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Trailer implements Trailer {
  const _Trailer({this.name, this.preview, this.video});
  factory _Trailer.fromJson(Map<String, dynamic> json) => _$TrailerFromJson(json);

@override final  String? name;
@override final  String? preview;
@override final  String? video;

/// Create a copy of Trailer
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TrailerCopyWith<_Trailer> get copyWith => __$TrailerCopyWithImpl<_Trailer>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TrailerToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Trailer&&(identical(other.name, name) || other.name == name)&&(identical(other.preview, preview) || other.preview == preview)&&(identical(other.video, video) || other.video == video));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,preview,video);

@override
String toString() {
  return 'Trailer(name: $name, preview: $preview, video: $video)';
}


}

/// @nodoc
abstract mixin class _$TrailerCopyWith<$Res> implements $TrailerCopyWith<$Res> {
  factory _$TrailerCopyWith(_Trailer value, $Res Function(_Trailer) _then) = __$TrailerCopyWithImpl;
@override @useResult
$Res call({
 String? name, String? preview, String? video
});




}
/// @nodoc
class __$TrailerCopyWithImpl<$Res>
    implements _$TrailerCopyWith<$Res> {
  __$TrailerCopyWithImpl(this._self, this._then);

  final _Trailer _self;
  final $Res Function(_Trailer) _then;

/// Create a copy of Trailer
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = freezed,Object? preview = freezed,Object? video = freezed,}) {
  return _then(_Trailer(
name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,preview: freezed == preview ? _self.preview : preview // ignore: cast_nullable_to_non_nullable
as String?,video: freezed == video ? _self.video : video // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$RedditPost {

 int get id; String get name; String? get url; String? get image;
/// Create a copy of RedditPost
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RedditPostCopyWith<RedditPost> get copyWith => _$RedditPostCopyWithImpl<RedditPost>(this as RedditPost, _$identity);

  /// Serializes this RedditPost to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RedditPost&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.url, url) || other.url == url)&&(identical(other.image, image) || other.image == image));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,url,image);

@override
String toString() {
  return 'RedditPost(id: $id, name: $name, url: $url, image: $image)';
}


}

/// @nodoc
abstract mixin class $RedditPostCopyWith<$Res>  {
  factory $RedditPostCopyWith(RedditPost value, $Res Function(RedditPost) _then) = _$RedditPostCopyWithImpl;
@useResult
$Res call({
 int id, String name, String? url, String? image
});




}
/// @nodoc
class _$RedditPostCopyWithImpl<$Res>
    implements $RedditPostCopyWith<$Res> {
  _$RedditPostCopyWithImpl(this._self, this._then);

  final RedditPost _self;
  final $Res Function(RedditPost) _then;

/// Create a copy of RedditPost
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? url = freezed,Object? image = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,url: freezed == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String?,image: freezed == image ? _self.image : image // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [RedditPost].
extension RedditPostPatterns on RedditPost {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RedditPost value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RedditPost() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RedditPost value)  $default,){
final _that = this;
switch (_that) {
case _RedditPost():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RedditPost value)?  $default,){
final _that = this;
switch (_that) {
case _RedditPost() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String name,  String? url,  String? image)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RedditPost() when $default != null:
return $default(_that.id,_that.name,_that.url,_that.image);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String name,  String? url,  String? image)  $default,) {final _that = this;
switch (_that) {
case _RedditPost():
return $default(_that.id,_that.name,_that.url,_that.image);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String name,  String? url,  String? image)?  $default,) {final _that = this;
switch (_that) {
case _RedditPost() when $default != null:
return $default(_that.id,_that.name,_that.url,_that.image);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RedditPost implements RedditPost {
  const _RedditPost({required this.id, required this.name, this.url, this.image});
  factory _RedditPost.fromJson(Map<String, dynamic> json) => _$RedditPostFromJson(json);

@override final  int id;
@override final  String name;
@override final  String? url;
@override final  String? image;

/// Create a copy of RedditPost
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RedditPostCopyWith<_RedditPost> get copyWith => __$RedditPostCopyWithImpl<_RedditPost>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RedditPostToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RedditPost&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.url, url) || other.url == url)&&(identical(other.image, image) || other.image == image));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,url,image);

@override
String toString() {
  return 'RedditPost(id: $id, name: $name, url: $url, image: $image)';
}


}

/// @nodoc
abstract mixin class _$RedditPostCopyWith<$Res> implements $RedditPostCopyWith<$Res> {
  factory _$RedditPostCopyWith(_RedditPost value, $Res Function(_RedditPost) _then) = __$RedditPostCopyWithImpl;
@override @useResult
$Res call({
 int id, String name, String? url, String? image
});




}
/// @nodoc
class __$RedditPostCopyWithImpl<$Res>
    implements _$RedditPostCopyWith<$Res> {
  __$RedditPostCopyWithImpl(this._self, this._then);

  final _RedditPost _self;
  final $Res Function(_RedditPost) _then;

/// Create a copy of RedditPost
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? url = freezed,Object? image = freezed,}) {
  return _then(_RedditPost(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,url: freezed == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String?,image: freezed == image ? _self.image : image // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$Achievement {

 int get id; String? get name; String? get description; String? get image;
/// Create a copy of Achievement
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AchievementCopyWith<Achievement> get copyWith => _$AchievementCopyWithImpl<Achievement>(this as Achievement, _$identity);

  /// Serializes this Achievement to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Achievement&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.image, image) || other.image == image));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,description,image);

@override
String toString() {
  return 'Achievement(id: $id, name: $name, description: $description, image: $image)';
}


}

/// @nodoc
abstract mixin class $AchievementCopyWith<$Res>  {
  factory $AchievementCopyWith(Achievement value, $Res Function(Achievement) _then) = _$AchievementCopyWithImpl;
@useResult
$Res call({
 int id, String? name, String? description, String? image
});




}
/// @nodoc
class _$AchievementCopyWithImpl<$Res>
    implements $AchievementCopyWith<$Res> {
  _$AchievementCopyWithImpl(this._self, this._then);

  final Achievement _self;
  final $Res Function(Achievement) _then;

/// Create a copy of Achievement
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = freezed,Object? description = freezed,Object? image = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,image: freezed == image ? _self.image : image // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [Achievement].
extension AchievementPatterns on Achievement {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Achievement value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Achievement() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Achievement value)  $default,){
final _that = this;
switch (_that) {
case _Achievement():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Achievement value)?  $default,){
final _that = this;
switch (_that) {
case _Achievement() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String? name,  String? description,  String? image)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Achievement() when $default != null:
return $default(_that.id,_that.name,_that.description,_that.image);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String? name,  String? description,  String? image)  $default,) {final _that = this;
switch (_that) {
case _Achievement():
return $default(_that.id,_that.name,_that.description,_that.image);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String? name,  String? description,  String? image)?  $default,) {final _that = this;
switch (_that) {
case _Achievement() when $default != null:
return $default(_that.id,_that.name,_that.description,_that.image);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Achievement implements Achievement {
  const _Achievement({required this.id, this.name, this.description, this.image});
  factory _Achievement.fromJson(Map<String, dynamic> json) => _$AchievementFromJson(json);

@override final  int id;
@override final  String? name;
@override final  String? description;
@override final  String? image;

/// Create a copy of Achievement
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AchievementCopyWith<_Achievement> get copyWith => __$AchievementCopyWithImpl<_Achievement>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AchievementToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Achievement&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.image, image) || other.image == image));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,description,image);

@override
String toString() {
  return 'Achievement(id: $id, name: $name, description: $description, image: $image)';
}


}

/// @nodoc
abstract mixin class _$AchievementCopyWith<$Res> implements $AchievementCopyWith<$Res> {
  factory _$AchievementCopyWith(_Achievement value, $Res Function(_Achievement) _then) = __$AchievementCopyWithImpl;
@override @useResult
$Res call({
 int id, String? name, String? description, String? image
});




}
/// @nodoc
class __$AchievementCopyWithImpl<$Res>
    implements _$AchievementCopyWith<$Res> {
  __$AchievementCopyWithImpl(this._self, this._then);

  final _Achievement _self;
  final $Res Function(_Achievement) _then;

/// Create a copy of Achievement
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = freezed,Object? description = freezed,Object? image = freezed,}) {
  return _then(_Achievement(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,image: freezed == image ? _self.image : image // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$DLC {

 int get id; String? get title; String? get url; String? get image;
/// Create a copy of DLC
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DLCCopyWith<DLC> get copyWith => _$DLCCopyWithImpl<DLC>(this as DLC, _$identity);

  /// Serializes this DLC to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DLC&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.url, url) || other.url == url)&&(identical(other.image, image) || other.image == image));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,url,image);

@override
String toString() {
  return 'DLC(id: $id, title: $title, url: $url, image: $image)';
}


}

/// @nodoc
abstract mixin class $DLCCopyWith<$Res>  {
  factory $DLCCopyWith(DLC value, $Res Function(DLC) _then) = _$DLCCopyWithImpl;
@useResult
$Res call({
 int id, String? title, String? url, String? image
});




}
/// @nodoc
class _$DLCCopyWithImpl<$Res>
    implements $DLCCopyWith<$Res> {
  _$DLCCopyWithImpl(this._self, this._then);

  final DLC _self;
  final $Res Function(DLC) _then;

/// Create a copy of DLC
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = freezed,Object? url = freezed,Object? image = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,url: freezed == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String?,image: freezed == image ? _self.image : image // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [DLC].
extension DLCPatterns on DLC {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DLC value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DLC() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DLC value)  $default,){
final _that = this;
switch (_that) {
case _DLC():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DLC value)?  $default,){
final _that = this;
switch (_that) {
case _DLC() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String? title,  String? url,  String? image)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DLC() when $default != null:
return $default(_that.id,_that.title,_that.url,_that.image);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String? title,  String? url,  String? image)  $default,) {final _that = this;
switch (_that) {
case _DLC():
return $default(_that.id,_that.title,_that.url,_that.image);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String? title,  String? url,  String? image)?  $default,) {final _that = this;
switch (_that) {
case _DLC() when $default != null:
return $default(_that.id,_that.title,_that.url,_that.image);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DLC extends DLC {
  const _DLC({required this.id, this.title, this.url, this.image}): super._();
  factory _DLC.fromJson(Map<String, dynamic> json) => _$DLCFromJson(json);

@override final  int id;
@override final  String? title;
@override final  String? url;
@override final  String? image;

/// Create a copy of DLC
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DLCCopyWith<_DLC> get copyWith => __$DLCCopyWithImpl<_DLC>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DLCToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DLC&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.url, url) || other.url == url)&&(identical(other.image, image) || other.image == image));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,url,image);

@override
String toString() {
  return 'DLC(id: $id, title: $title, url: $url, image: $image)';
}


}

/// @nodoc
abstract mixin class _$DLCCopyWith<$Res> implements $DLCCopyWith<$Res> {
  factory _$DLCCopyWith(_DLC value, $Res Function(_DLC) _then) = __$DLCCopyWithImpl;
@override @useResult
$Res call({
 int id, String? title, String? url, String? image
});




}
/// @nodoc
class __$DLCCopyWithImpl<$Res>
    implements _$DLCCopyWith<$Res> {
  __$DLCCopyWithImpl(this._self, this._then);

  final _DLC _self;
  final $Res Function(_DLC) _then;

/// Create a copy of DLC
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = freezed,Object? url = freezed,Object? image = freezed,}) {
  return _then(_DLC(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,url: freezed == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String?,image: freezed == image ? _self.image : image // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$SameSeries {

 int get id; String? get title; String? get released; String? get image;
/// Create a copy of SameSeries
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SameSeriesCopyWith<SameSeries> get copyWith => _$SameSeriesCopyWithImpl<SameSeries>(this as SameSeries, _$identity);

  /// Serializes this SameSeries to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SameSeries&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.released, released) || other.released == released)&&(identical(other.image, image) || other.image == image));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,released,image);

@override
String toString() {
  return 'SameSeries(id: $id, title: $title, released: $released, image: $image)';
}


}

/// @nodoc
abstract mixin class $SameSeriesCopyWith<$Res>  {
  factory $SameSeriesCopyWith(SameSeries value, $Res Function(SameSeries) _then) = _$SameSeriesCopyWithImpl;
@useResult
$Res call({
 int id, String? title, String? released, String? image
});




}
/// @nodoc
class _$SameSeriesCopyWithImpl<$Res>
    implements $SameSeriesCopyWith<$Res> {
  _$SameSeriesCopyWithImpl(this._self, this._then);

  final SameSeries _self;
  final $Res Function(SameSeries) _then;

/// Create a copy of SameSeries
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = freezed,Object? released = freezed,Object? image = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,released: freezed == released ? _self.released : released // ignore: cast_nullable_to_non_nullable
as String?,image: freezed == image ? _self.image : image // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [SameSeries].
extension SameSeriesPatterns on SameSeries {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SameSeries value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SameSeries() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SameSeries value)  $default,){
final _that = this;
switch (_that) {
case _SameSeries():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SameSeries value)?  $default,){
final _that = this;
switch (_that) {
case _SameSeries() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String? title,  String? released,  String? image)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SameSeries() when $default != null:
return $default(_that.id,_that.title,_that.released,_that.image);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String? title,  String? released,  String? image)  $default,) {final _that = this;
switch (_that) {
case _SameSeries():
return $default(_that.id,_that.title,_that.released,_that.image);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String? title,  String? released,  String? image)?  $default,) {final _that = this;
switch (_that) {
case _SameSeries() when $default != null:
return $default(_that.id,_that.title,_that.released,_that.image);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SameSeries extends SameSeries {
  const _SameSeries({required this.id, this.title, this.released, this.image}): super._();
  factory _SameSeries.fromJson(Map<String, dynamic> json) => _$SameSeriesFromJson(json);

@override final  int id;
@override final  String? title;
@override final  String? released;
@override final  String? image;

/// Create a copy of SameSeries
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SameSeriesCopyWith<_SameSeries> get copyWith => __$SameSeriesCopyWithImpl<_SameSeries>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SameSeriesToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SameSeries&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.released, released) || other.released == released)&&(identical(other.image, image) || other.image == image));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,released,image);

@override
String toString() {
  return 'SameSeries(id: $id, title: $title, released: $released, image: $image)';
}


}

/// @nodoc
abstract mixin class _$SameSeriesCopyWith<$Res> implements $SameSeriesCopyWith<$Res> {
  factory _$SameSeriesCopyWith(_SameSeries value, $Res Function(_SameSeries) _then) = __$SameSeriesCopyWithImpl;
@override @useResult
$Res call({
 int id, String? title, String? released, String? image
});




}
/// @nodoc
class __$SameSeriesCopyWithImpl<$Res>
    implements _$SameSeriesCopyWith<$Res> {
  __$SameSeriesCopyWithImpl(this._self, this._then);

  final _SameSeries _self;
  final $Res Function(_SameSeries) _then;

/// Create a copy of SameSeries
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = freezed,Object? released = freezed,Object? image = freezed,}) {
  return _then(_SameSeries(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,released: freezed == released ? _self.released : released // ignore: cast_nullable_to_non_nullable
as String?,image: freezed == image ? _self.image : image // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$HorizontalList {

 int get id; String? get name; String? get url; String? get image;
/// Create a copy of HorizontalList
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HorizontalListCopyWith<HorizontalList> get copyWith => _$HorizontalListCopyWithImpl<HorizontalList>(this as HorizontalList, _$identity);

  /// Serializes this HorizontalList to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HorizontalList&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.url, url) || other.url == url)&&(identical(other.image, image) || other.image == image));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,url,image);

@override
String toString() {
  return 'HorizontalList(id: $id, name: $name, url: $url, image: $image)';
}


}

/// @nodoc
abstract mixin class $HorizontalListCopyWith<$Res>  {
  factory $HorizontalListCopyWith(HorizontalList value, $Res Function(HorizontalList) _then) = _$HorizontalListCopyWithImpl;
@useResult
$Res call({
 int id, String? name, String? url, String? image
});




}
/// @nodoc
class _$HorizontalListCopyWithImpl<$Res>
    implements $HorizontalListCopyWith<$Res> {
  _$HorizontalListCopyWithImpl(this._self, this._then);

  final HorizontalList _self;
  final $Res Function(HorizontalList) _then;

/// Create a copy of HorizontalList
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = freezed,Object? url = freezed,Object? image = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,url: freezed == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String?,image: freezed == image ? _self.image : image // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [HorizontalList].
extension HorizontalListPatterns on HorizontalList {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HorizontalList value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HorizontalList() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HorizontalList value)  $default,){
final _that = this;
switch (_that) {
case _HorizontalList():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HorizontalList value)?  $default,){
final _that = this;
switch (_that) {
case _HorizontalList() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String? name,  String? url,  String? image)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HorizontalList() when $default != null:
return $default(_that.id,_that.name,_that.url,_that.image);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String? name,  String? url,  String? image)  $default,) {final _that = this;
switch (_that) {
case _HorizontalList():
return $default(_that.id,_that.name,_that.url,_that.image);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String? name,  String? url,  String? image)?  $default,) {final _that = this;
switch (_that) {
case _HorizontalList() when $default != null:
return $default(_that.id,_that.name,_that.url,_that.image);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _HorizontalList implements HorizontalList {
  const _HorizontalList({required this.id, this.name, this.url, this.image});
  factory _HorizontalList.fromJson(Map<String, dynamic> json) => _$HorizontalListFromJson(json);

@override final  int id;
@override final  String? name;
@override final  String? url;
@override final  String? image;

/// Create a copy of HorizontalList
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HorizontalListCopyWith<_HorizontalList> get copyWith => __$HorizontalListCopyWithImpl<_HorizontalList>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$HorizontalListToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HorizontalList&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.url, url) || other.url == url)&&(identical(other.image, image) || other.image == image));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,url,image);

@override
String toString() {
  return 'HorizontalList(id: $id, name: $name, url: $url, image: $image)';
}


}

/// @nodoc
abstract mixin class _$HorizontalListCopyWith<$Res> implements $HorizontalListCopyWith<$Res> {
  factory _$HorizontalListCopyWith(_HorizontalList value, $Res Function(_HorizontalList) _then) = __$HorizontalListCopyWithImpl;
@override @useResult
$Res call({
 int id, String? name, String? url, String? image
});




}
/// @nodoc
class __$HorizontalListCopyWithImpl<$Res>
    implements _$HorizontalListCopyWith<$Res> {
  __$HorizontalListCopyWithImpl(this._self, this._then);

  final _HorizontalList _self;
  final $Res Function(_HorizontalList) _then;

/// Create a copy of HorizontalList
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = freezed,Object? url = freezed,Object? image = freezed,}) {
  return _then(_HorizontalList(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,url: freezed == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String?,image: freezed == image ? _self.image : image // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$Platform {

 int get id; String? get name; Requirements? get requirements; String? get released;@StringToColorConverter() Color? get color; String? get icon;
/// Create a copy of Platform
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PlatformCopyWith<Platform> get copyWith => _$PlatformCopyWithImpl<Platform>(this as Platform, _$identity);

  /// Serializes this Platform to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Platform&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.requirements, requirements) || other.requirements == requirements)&&(identical(other.released, released) || other.released == released)&&(identical(other.color, color) || other.color == color)&&(identical(other.icon, icon) || other.icon == icon));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,requirements,released,color,icon);

@override
String toString() {
  return 'Platform(id: $id, name: $name, requirements: $requirements, released: $released, color: $color, icon: $icon)';
}


}

/// @nodoc
abstract mixin class $PlatformCopyWith<$Res>  {
  factory $PlatformCopyWith(Platform value, $Res Function(Platform) _then) = _$PlatformCopyWithImpl;
@useResult
$Res call({
 int id, String? name, Requirements? requirements, String? released,@StringToColorConverter() Color? color, String? icon
});


$RequirementsCopyWith<$Res>? get requirements;

}
/// @nodoc
class _$PlatformCopyWithImpl<$Res>
    implements $PlatformCopyWith<$Res> {
  _$PlatformCopyWithImpl(this._self, this._then);

  final Platform _self;
  final $Res Function(Platform) _then;

/// Create a copy of Platform
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = freezed,Object? requirements = freezed,Object? released = freezed,Object? color = freezed,Object? icon = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,requirements: freezed == requirements ? _self.requirements : requirements // ignore: cast_nullable_to_non_nullable
as Requirements?,released: freezed == released ? _self.released : released // ignore: cast_nullable_to_non_nullable
as String?,color: freezed == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as Color?,icon: freezed == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of Platform
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RequirementsCopyWith<$Res>? get requirements {
    if (_self.requirements == null) {
    return null;
  }

  return $RequirementsCopyWith<$Res>(_self.requirements!, (value) {
    return _then(_self.copyWith(requirements: value));
  });
}
}


/// Adds pattern-matching-related methods to [Platform].
extension PlatformPatterns on Platform {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Platform value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Platform() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Platform value)  $default,){
final _that = this;
switch (_that) {
case _Platform():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Platform value)?  $default,){
final _that = this;
switch (_that) {
case _Platform() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String? name,  Requirements? requirements,  String? released, @StringToColorConverter()  Color? color,  String? icon)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Platform() when $default != null:
return $default(_that.id,_that.name,_that.requirements,_that.released,_that.color,_that.icon);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String? name,  Requirements? requirements,  String? released, @StringToColorConverter()  Color? color,  String? icon)  $default,) {final _that = this;
switch (_that) {
case _Platform():
return $default(_that.id,_that.name,_that.requirements,_that.released,_that.color,_that.icon);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String? name,  Requirements? requirements,  String? released, @StringToColorConverter()  Color? color,  String? icon)?  $default,) {final _that = this;
switch (_that) {
case _Platform() when $default != null:
return $default(_that.id,_that.name,_that.requirements,_that.released,_that.color,_that.icon);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Platform implements Platform {
  const _Platform({required this.id, this.name, this.requirements, this.released, @StringToColorConverter() this.color, this.icon});
  factory _Platform.fromJson(Map<String, dynamic> json) => _$PlatformFromJson(json);

@override final  int id;
@override final  String? name;
@override final  Requirements? requirements;
@override final  String? released;
@override@StringToColorConverter() final  Color? color;
@override final  String? icon;

/// Create a copy of Platform
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PlatformCopyWith<_Platform> get copyWith => __$PlatformCopyWithImpl<_Platform>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PlatformToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Platform&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.requirements, requirements) || other.requirements == requirements)&&(identical(other.released, released) || other.released == released)&&(identical(other.color, color) || other.color == color)&&(identical(other.icon, icon) || other.icon == icon));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,requirements,released,color,icon);

@override
String toString() {
  return 'Platform(id: $id, name: $name, requirements: $requirements, released: $released, color: $color, icon: $icon)';
}


}

/// @nodoc
abstract mixin class _$PlatformCopyWith<$Res> implements $PlatformCopyWith<$Res> {
  factory _$PlatformCopyWith(_Platform value, $Res Function(_Platform) _then) = __$PlatformCopyWithImpl;
@override @useResult
$Res call({
 int id, String? name, Requirements? requirements, String? released,@StringToColorConverter() Color? color, String? icon
});


@override $RequirementsCopyWith<$Res>? get requirements;

}
/// @nodoc
class __$PlatformCopyWithImpl<$Res>
    implements _$PlatformCopyWith<$Res> {
  __$PlatformCopyWithImpl(this._self, this._then);

  final _Platform _self;
  final $Res Function(_Platform) _then;

/// Create a copy of Platform
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = freezed,Object? requirements = freezed,Object? released = freezed,Object? color = freezed,Object? icon = freezed,}) {
  return _then(_Platform(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,requirements: freezed == requirements ? _self.requirements : requirements // ignore: cast_nullable_to_non_nullable
as Requirements?,released: freezed == released ? _self.released : released // ignore: cast_nullable_to_non_nullable
as String?,color: freezed == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as Color?,icon: freezed == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of Platform
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RequirementsCopyWith<$Res>? get requirements {
    if (_self.requirements == null) {
    return null;
  }

  return $RequirementsCopyWith<$Res>(_self.requirements!, (value) {
    return _then(_self.copyWith(requirements: value));
  });
}
}


/// @nodoc
mixin _$Requirements {

 String? get minimum; String? get recommended;
/// Create a copy of Requirements
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RequirementsCopyWith<Requirements> get copyWith => _$RequirementsCopyWithImpl<Requirements>(this as Requirements, _$identity);

  /// Serializes this Requirements to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Requirements&&(identical(other.minimum, minimum) || other.minimum == minimum)&&(identical(other.recommended, recommended) || other.recommended == recommended));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,minimum,recommended);

@override
String toString() {
  return 'Requirements(minimum: $minimum, recommended: $recommended)';
}


}

/// @nodoc
abstract mixin class $RequirementsCopyWith<$Res>  {
  factory $RequirementsCopyWith(Requirements value, $Res Function(Requirements) _then) = _$RequirementsCopyWithImpl;
@useResult
$Res call({
 String? minimum, String? recommended
});




}
/// @nodoc
class _$RequirementsCopyWithImpl<$Res>
    implements $RequirementsCopyWith<$Res> {
  _$RequirementsCopyWithImpl(this._self, this._then);

  final Requirements _self;
  final $Res Function(Requirements) _then;

/// Create a copy of Requirements
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? minimum = freezed,Object? recommended = freezed,}) {
  return _then(_self.copyWith(
minimum: freezed == minimum ? _self.minimum : minimum // ignore: cast_nullable_to_non_nullable
as String?,recommended: freezed == recommended ? _self.recommended : recommended // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [Requirements].
extension RequirementsPatterns on Requirements {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Requirements value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Requirements() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Requirements value)  $default,){
final _that = this;
switch (_that) {
case _Requirements():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Requirements value)?  $default,){
final _that = this;
switch (_that) {
case _Requirements() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? minimum,  String? recommended)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Requirements() when $default != null:
return $default(_that.minimum,_that.recommended);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? minimum,  String? recommended)  $default,) {final _that = this;
switch (_that) {
case _Requirements():
return $default(_that.minimum,_that.recommended);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? minimum,  String? recommended)?  $default,) {final _that = this;
switch (_that) {
case _Requirements() when $default != null:
return $default(_that.minimum,_that.recommended);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Requirements implements Requirements {
  const _Requirements({this.minimum, this.recommended});
  factory _Requirements.fromJson(Map<String, dynamic> json) => _$RequirementsFromJson(json);

@override final  String? minimum;
@override final  String? recommended;

/// Create a copy of Requirements
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RequirementsCopyWith<_Requirements> get copyWith => __$RequirementsCopyWithImpl<_Requirements>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RequirementsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Requirements&&(identical(other.minimum, minimum) || other.minimum == minimum)&&(identical(other.recommended, recommended) || other.recommended == recommended));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,minimum,recommended);

@override
String toString() {
  return 'Requirements(minimum: $minimum, recommended: $recommended)';
}


}

/// @nodoc
abstract mixin class _$RequirementsCopyWith<$Res> implements $RequirementsCopyWith<$Res> {
  factory _$RequirementsCopyWith(_Requirements value, $Res Function(_Requirements) _then) = __$RequirementsCopyWithImpl;
@override @useResult
$Res call({
 String? minimum, String? recommended
});




}
/// @nodoc
class __$RequirementsCopyWithImpl<$Res>
    implements _$RequirementsCopyWith<$Res> {
  __$RequirementsCopyWithImpl(this._self, this._then);

  final _Requirements _self;
  final $Res Function(_Requirements) _then;

/// Create a copy of Requirements
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? minimum = freezed,Object? recommended = freezed,}) {
  return _then(_Requirements(
minimum: freezed == minimum ? _self.minimum : minimum // ignore: cast_nullable_to_non_nullable
as String?,recommended: freezed == recommended ? _self.recommended : recommended // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
