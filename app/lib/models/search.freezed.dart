// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'search.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SearchQueryParams {

 String? get query; List<Tag> get tags; List<String> get genres; GamePlatform? get platform; GameOrdering get ordering; bool get searchPrecise; bool get searchExact; bool get reverseOrder;
/// Create a copy of SearchQueryParams
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SearchQueryParamsCopyWith<SearchQueryParams> get copyWith => _$SearchQueryParamsCopyWithImpl<SearchQueryParams>(this as SearchQueryParams, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SearchQueryParams&&(identical(other.query, query) || other.query == query)&&const DeepCollectionEquality().equals(other.tags, tags)&&const DeepCollectionEquality().equals(other.genres, genres)&&(identical(other.platform, platform) || other.platform == platform)&&(identical(other.ordering, ordering) || other.ordering == ordering)&&(identical(other.searchPrecise, searchPrecise) || other.searchPrecise == searchPrecise)&&(identical(other.searchExact, searchExact) || other.searchExact == searchExact)&&(identical(other.reverseOrder, reverseOrder) || other.reverseOrder == reverseOrder));
}


@override
int get hashCode => Object.hash(runtimeType,query,const DeepCollectionEquality().hash(tags),const DeepCollectionEquality().hash(genres),platform,ordering,searchPrecise,searchExact,reverseOrder);

@override
String toString() {
  return 'SearchQueryParams(query: $query, tags: $tags, genres: $genres, platform: $platform, ordering: $ordering, searchPrecise: $searchPrecise, searchExact: $searchExact, reverseOrder: $reverseOrder)';
}


}

/// @nodoc
abstract mixin class $SearchQueryParamsCopyWith<$Res>  {
  factory $SearchQueryParamsCopyWith(SearchQueryParams value, $Res Function(SearchQueryParams) _then) = _$SearchQueryParamsCopyWithImpl;
@useResult
$Res call({
 String? query, List<Tag> tags, List<String> genres, GamePlatform? platform, GameOrdering ordering, bool searchPrecise, bool searchExact, bool reverseOrder
});




}
/// @nodoc
class _$SearchQueryParamsCopyWithImpl<$Res>
    implements $SearchQueryParamsCopyWith<$Res> {
  _$SearchQueryParamsCopyWithImpl(this._self, this._then);

  final SearchQueryParams _self;
  final $Res Function(SearchQueryParams) _then;

/// Create a copy of SearchQueryParams
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? query = freezed,Object? tags = null,Object? genres = null,Object? platform = freezed,Object? ordering = null,Object? searchPrecise = null,Object? searchExact = null,Object? reverseOrder = null,}) {
  return _then(_self.copyWith(
query: freezed == query ? _self.query : query // ignore: cast_nullable_to_non_nullable
as String?,tags: null == tags ? _self.tags : tags // ignore: cast_nullable_to_non_nullable
as List<Tag>,genres: null == genres ? _self.genres : genres // ignore: cast_nullable_to_non_nullable
as List<String>,platform: freezed == platform ? _self.platform : platform // ignore: cast_nullable_to_non_nullable
as GamePlatform?,ordering: null == ordering ? _self.ordering : ordering // ignore: cast_nullable_to_non_nullable
as GameOrdering,searchPrecise: null == searchPrecise ? _self.searchPrecise : searchPrecise // ignore: cast_nullable_to_non_nullable
as bool,searchExact: null == searchExact ? _self.searchExact : searchExact // ignore: cast_nullable_to_non_nullable
as bool,reverseOrder: null == reverseOrder ? _self.reverseOrder : reverseOrder // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [SearchQueryParams].
extension SearchQueryParamsPatterns on SearchQueryParams {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SearchQueryParams value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SearchQueryParams() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SearchQueryParams value)  $default,){
final _that = this;
switch (_that) {
case _SearchQueryParams():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SearchQueryParams value)?  $default,){
final _that = this;
switch (_that) {
case _SearchQueryParams() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? query,  List<Tag> tags,  List<String> genres,  GamePlatform? platform,  GameOrdering ordering,  bool searchPrecise,  bool searchExact,  bool reverseOrder)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SearchQueryParams() when $default != null:
return $default(_that.query,_that.tags,_that.genres,_that.platform,_that.ordering,_that.searchPrecise,_that.searchExact,_that.reverseOrder);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? query,  List<Tag> tags,  List<String> genres,  GamePlatform? platform,  GameOrdering ordering,  bool searchPrecise,  bool searchExact,  bool reverseOrder)  $default,) {final _that = this;
switch (_that) {
case _SearchQueryParams():
return $default(_that.query,_that.tags,_that.genres,_that.platform,_that.ordering,_that.searchPrecise,_that.searchExact,_that.reverseOrder);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? query,  List<Tag> tags,  List<String> genres,  GamePlatform? platform,  GameOrdering ordering,  bool searchPrecise,  bool searchExact,  bool reverseOrder)?  $default,) {final _that = this;
switch (_that) {
case _SearchQueryParams() when $default != null:
return $default(_that.query,_that.tags,_that.genres,_that.platform,_that.ordering,_that.searchPrecise,_that.searchExact,_that.reverseOrder);case _:
  return null;

}
}

}

/// @nodoc


class _SearchQueryParams implements SearchQueryParams {
  const _SearchQueryParams({this.query, final  List<Tag> tags = const [], final  List<String> genres = const [], this.platform, this.ordering = GameOrdering.rating, this.searchPrecise = true, this.searchExact = false, this.reverseOrder = true}): _tags = tags,_genres = genres;
  

@override final  String? query;
 final  List<Tag> _tags;
@override@JsonKey() List<Tag> get tags {
  if (_tags is EqualUnmodifiableListView) return _tags;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_tags);
}

 final  List<String> _genres;
@override@JsonKey() List<String> get genres {
  if (_genres is EqualUnmodifiableListView) return _genres;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_genres);
}

@override final  GamePlatform? platform;
@override@JsonKey() final  GameOrdering ordering;
@override@JsonKey() final  bool searchPrecise;
@override@JsonKey() final  bool searchExact;
@override@JsonKey() final  bool reverseOrder;

/// Create a copy of SearchQueryParams
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SearchQueryParamsCopyWith<_SearchQueryParams> get copyWith => __$SearchQueryParamsCopyWithImpl<_SearchQueryParams>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SearchQueryParams&&(identical(other.query, query) || other.query == query)&&const DeepCollectionEquality().equals(other._tags, _tags)&&const DeepCollectionEquality().equals(other._genres, _genres)&&(identical(other.platform, platform) || other.platform == platform)&&(identical(other.ordering, ordering) || other.ordering == ordering)&&(identical(other.searchPrecise, searchPrecise) || other.searchPrecise == searchPrecise)&&(identical(other.searchExact, searchExact) || other.searchExact == searchExact)&&(identical(other.reverseOrder, reverseOrder) || other.reverseOrder == reverseOrder));
}


@override
int get hashCode => Object.hash(runtimeType,query,const DeepCollectionEquality().hash(_tags),const DeepCollectionEquality().hash(_genres),platform,ordering,searchPrecise,searchExact,reverseOrder);

@override
String toString() {
  return 'SearchQueryParams(query: $query, tags: $tags, genres: $genres, platform: $platform, ordering: $ordering, searchPrecise: $searchPrecise, searchExact: $searchExact, reverseOrder: $reverseOrder)';
}


}

/// @nodoc
abstract mixin class _$SearchQueryParamsCopyWith<$Res> implements $SearchQueryParamsCopyWith<$Res> {
  factory _$SearchQueryParamsCopyWith(_SearchQueryParams value, $Res Function(_SearchQueryParams) _then) = __$SearchQueryParamsCopyWithImpl;
@override @useResult
$Res call({
 String? query, List<Tag> tags, List<String> genres, GamePlatform? platform, GameOrdering ordering, bool searchPrecise, bool searchExact, bool reverseOrder
});




}
/// @nodoc
class __$SearchQueryParamsCopyWithImpl<$Res>
    implements _$SearchQueryParamsCopyWith<$Res> {
  __$SearchQueryParamsCopyWithImpl(this._self, this._then);

  final _SearchQueryParams _self;
  final $Res Function(_SearchQueryParams) _then;

/// Create a copy of SearchQueryParams
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? query = freezed,Object? tags = null,Object? genres = null,Object? platform = freezed,Object? ordering = null,Object? searchPrecise = null,Object? searchExact = null,Object? reverseOrder = null,}) {
  return _then(_SearchQueryParams(
query: freezed == query ? _self.query : query // ignore: cast_nullable_to_non_nullable
as String?,tags: null == tags ? _self._tags : tags // ignore: cast_nullable_to_non_nullable
as List<Tag>,genres: null == genres ? _self._genres : genres // ignore: cast_nullable_to_non_nullable
as List<String>,platform: freezed == platform ? _self.platform : platform // ignore: cast_nullable_to_non_nullable
as GamePlatform?,ordering: null == ordering ? _self.ordering : ordering // ignore: cast_nullable_to_non_nullable
as GameOrdering,searchPrecise: null == searchPrecise ? _self.searchPrecise : searchPrecise // ignore: cast_nullable_to_non_nullable
as bool,searchExact: null == searchExact ? _self.searchExact : searchExact // ignore: cast_nullable_to_non_nullable
as bool,reverseOrder: null == reverseOrder ? _self.reverseOrder : reverseOrder // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
