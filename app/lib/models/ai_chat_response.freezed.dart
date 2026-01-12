// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ai_chat_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AiChatResponse {

 String get message; List<Game> get results;
/// Create a copy of AiChatResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AiChatResponseCopyWith<AiChatResponse> get copyWith => _$AiChatResponseCopyWithImpl<AiChatResponse>(this as AiChatResponse, _$identity);

  /// Serializes this AiChatResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AiChatResponse&&(identical(other.message, message) || other.message == message)&&const DeepCollectionEquality().equals(other.results, results));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,message,const DeepCollectionEquality().hash(results));

@override
String toString() {
  return 'AiChatResponse(message: $message, results: $results)';
}


}

/// @nodoc
abstract mixin class $AiChatResponseCopyWith<$Res>  {
  factory $AiChatResponseCopyWith(AiChatResponse value, $Res Function(AiChatResponse) _then) = _$AiChatResponseCopyWithImpl;
@useResult
$Res call({
 String message, List<Game> results
});




}
/// @nodoc
class _$AiChatResponseCopyWithImpl<$Res>
    implements $AiChatResponseCopyWith<$Res> {
  _$AiChatResponseCopyWithImpl(this._self, this._then);

  final AiChatResponse _self;
  final $Res Function(AiChatResponse) _then;

/// Create a copy of AiChatResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? message = null,Object? results = null,}) {
  return _then(_self.copyWith(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,results: null == results ? _self.results : results // ignore: cast_nullable_to_non_nullable
as List<Game>,
  ));
}

}


/// Adds pattern-matching-related methods to [AiChatResponse].
extension AiChatResponsePatterns on AiChatResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AiChatResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AiChatResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AiChatResponse value)  $default,){
final _that = this;
switch (_that) {
case _AiChatResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AiChatResponse value)?  $default,){
final _that = this;
switch (_that) {
case _AiChatResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String message,  List<Game> results)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AiChatResponse() when $default != null:
return $default(_that.message,_that.results);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String message,  List<Game> results)  $default,) {final _that = this;
switch (_that) {
case _AiChatResponse():
return $default(_that.message,_that.results);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String message,  List<Game> results)?  $default,) {final _that = this;
switch (_that) {
case _AiChatResponse() when $default != null:
return $default(_that.message,_that.results);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AiChatResponse implements AiChatResponse {
  const _AiChatResponse({required this.message, required final  List<Game> results}): _results = results;
  factory _AiChatResponse.fromJson(Map<String, dynamic> json) => _$AiChatResponseFromJson(json);

@override final  String message;
 final  List<Game> _results;
@override List<Game> get results {
  if (_results is EqualUnmodifiableListView) return _results;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_results);
}


/// Create a copy of AiChatResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AiChatResponseCopyWith<_AiChatResponse> get copyWith => __$AiChatResponseCopyWithImpl<_AiChatResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AiChatResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AiChatResponse&&(identical(other.message, message) || other.message == message)&&const DeepCollectionEquality().equals(other._results, _results));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,message,const DeepCollectionEquality().hash(_results));

@override
String toString() {
  return 'AiChatResponse(message: $message, results: $results)';
}


}

/// @nodoc
abstract mixin class _$AiChatResponseCopyWith<$Res> implements $AiChatResponseCopyWith<$Res> {
  factory _$AiChatResponseCopyWith(_AiChatResponse value, $Res Function(_AiChatResponse) _then) = __$AiChatResponseCopyWithImpl;
@override @useResult
$Res call({
 String message, List<Game> results
});




}
/// @nodoc
class __$AiChatResponseCopyWithImpl<$Res>
    implements _$AiChatResponseCopyWith<$Res> {
  __$AiChatResponseCopyWithImpl(this._self, this._then);

  final _AiChatResponse _self;
  final $Res Function(_AiChatResponse) _then;

/// Create a copy of AiChatResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? message = null,Object? results = null,}) {
  return _then(_AiChatResponse(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,results: null == results ? _self._results : results // ignore: cast_nullable_to_non_nullable
as List<Game>,
  ));
}


}


/// @nodoc
mixin _$Game {

@JsonKey(fromJson: _fromJson) String? get id; String get name; String get reason; String get compatibility;@JsonKey(fromJson: _fromJson) String? get rating; List<String> get tags;@JsonKey(name: 'background_image') String? get backgroundImage;
/// Create a copy of Game
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GameCopyWith<Game> get copyWith => _$GameCopyWithImpl<Game>(this as Game, _$identity);

  /// Serializes this Game to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Game&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.reason, reason) || other.reason == reason)&&(identical(other.compatibility, compatibility) || other.compatibility == compatibility)&&(identical(other.rating, rating) || other.rating == rating)&&const DeepCollectionEquality().equals(other.tags, tags)&&(identical(other.backgroundImage, backgroundImage) || other.backgroundImage == backgroundImage));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,reason,compatibility,rating,const DeepCollectionEquality().hash(tags),backgroundImage);

@override
String toString() {
  return 'Game(id: $id, name: $name, reason: $reason, compatibility: $compatibility, rating: $rating, tags: $tags, backgroundImage: $backgroundImage)';
}


}

/// @nodoc
abstract mixin class $GameCopyWith<$Res>  {
  factory $GameCopyWith(Game value, $Res Function(Game) _then) = _$GameCopyWithImpl;
@useResult
$Res call({
@JsonKey(fromJson: _fromJson) String? id, String name, String reason, String compatibility,@JsonKey(fromJson: _fromJson) String? rating, List<String> tags,@JsonKey(name: 'background_image') String? backgroundImage
});




}
/// @nodoc
class _$GameCopyWithImpl<$Res>
    implements $GameCopyWith<$Res> {
  _$GameCopyWithImpl(this._self, this._then);

  final Game _self;
  final $Res Function(Game) _then;

/// Create a copy of Game
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? name = null,Object? reason = null,Object? compatibility = null,Object? rating = freezed,Object? tags = null,Object? backgroundImage = freezed,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,reason: null == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String,compatibility: null == compatibility ? _self.compatibility : compatibility // ignore: cast_nullable_to_non_nullable
as String,rating: freezed == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as String?,tags: null == tags ? _self.tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>,backgroundImage: freezed == backgroundImage ? _self.backgroundImage : backgroundImage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [Game].
extension GamePatterns on Game {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Game value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Game() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Game value)  $default,){
final _that = this;
switch (_that) {
case _Game():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Game value)?  $default,){
final _that = this;
switch (_that) {
case _Game() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(fromJson: _fromJson)  String? id,  String name,  String reason,  String compatibility, @JsonKey(fromJson: _fromJson)  String? rating,  List<String> tags, @JsonKey(name: 'background_image')  String? backgroundImage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Game() when $default != null:
return $default(_that.id,_that.name,_that.reason,_that.compatibility,_that.rating,_that.tags,_that.backgroundImage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(fromJson: _fromJson)  String? id,  String name,  String reason,  String compatibility, @JsonKey(fromJson: _fromJson)  String? rating,  List<String> tags, @JsonKey(name: 'background_image')  String? backgroundImage)  $default,) {final _that = this;
switch (_that) {
case _Game():
return $default(_that.id,_that.name,_that.reason,_that.compatibility,_that.rating,_that.tags,_that.backgroundImage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(fromJson: _fromJson)  String? id,  String name,  String reason,  String compatibility, @JsonKey(fromJson: _fromJson)  String? rating,  List<String> tags, @JsonKey(name: 'background_image')  String? backgroundImage)?  $default,) {final _that = this;
switch (_that) {
case _Game() when $default != null:
return $default(_that.id,_that.name,_that.reason,_that.compatibility,_that.rating,_that.tags,_that.backgroundImage);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Game implements Game {
  const _Game({@JsonKey(fromJson: _fromJson) this.id, required this.name, required this.reason, required this.compatibility, @JsonKey(fromJson: _fromJson) this.rating, final  List<String> tags = const [], @JsonKey(name: 'background_image') this.backgroundImage}): _tags = tags;
  factory _Game.fromJson(Map<String, dynamic> json) => _$GameFromJson(json);

@override@JsonKey(fromJson: _fromJson) final  String? id;
@override final  String name;
@override final  String reason;
@override final  String compatibility;
@override@JsonKey(fromJson: _fromJson) final  String? rating;
 final  List<String> _tags;
@override@JsonKey() List<String> get tags {
  if (_tags is EqualUnmodifiableListView) return _tags;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_tags);
}

@override@JsonKey(name: 'background_image') final  String? backgroundImage;

/// Create a copy of Game
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GameCopyWith<_Game> get copyWith => __$GameCopyWithImpl<_Game>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$GameToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Game&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.reason, reason) || other.reason == reason)&&(identical(other.compatibility, compatibility) || other.compatibility == compatibility)&&(identical(other.rating, rating) || other.rating == rating)&&const DeepCollectionEquality().equals(other._tags, _tags)&&(identical(other.backgroundImage, backgroundImage) || other.backgroundImage == backgroundImage));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,reason,compatibility,rating,const DeepCollectionEquality().hash(_tags),backgroundImage);

@override
String toString() {
  return 'Game(id: $id, name: $name, reason: $reason, compatibility: $compatibility, rating: $rating, tags: $tags, backgroundImage: $backgroundImage)';
}


}

/// @nodoc
abstract mixin class _$GameCopyWith<$Res> implements $GameCopyWith<$Res> {
  factory _$GameCopyWith(_Game value, $Res Function(_Game) _then) = __$GameCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(fromJson: _fromJson) String? id, String name, String reason, String compatibility,@JsonKey(fromJson: _fromJson) String? rating, List<String> tags,@JsonKey(name: 'background_image') String? backgroundImage
});




}
/// @nodoc
class __$GameCopyWithImpl<$Res>
    implements _$GameCopyWith<$Res> {
  __$GameCopyWithImpl(this._self, this._then);

  final _Game _self;
  final $Res Function(_Game) _then;

/// Create a copy of Game
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? name = null,Object? reason = null,Object? compatibility = null,Object? rating = freezed,Object? tags = null,Object? backgroundImage = freezed,}) {
  return _then(_Game(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,reason: null == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String,compatibility: null == compatibility ? _self.compatibility : compatibility // ignore: cast_nullable_to_non_nullable
as String,rating: freezed == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as String?,tags: null == tags ? _self._tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>,backgroundImage: freezed == backgroundImage ? _self.backgroundImage : backgroundImage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
