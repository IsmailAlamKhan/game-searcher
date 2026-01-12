// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ai_chat_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AiChatState {

 List<AiChatItem> get items; bool get isLoading; bool get initialLoading;
/// Create a copy of AiChatState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AiChatStateCopyWith<AiChatState> get copyWith => _$AiChatStateCopyWithImpl<AiChatState>(this as AiChatState, _$identity);

  /// Serializes this AiChatState to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AiChatState&&const DeepCollectionEquality().equals(other.items, items)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.initialLoading, initialLoading) || other.initialLoading == initialLoading));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(items),isLoading,initialLoading);

@override
String toString() {
  return 'AiChatState(items: $items, isLoading: $isLoading, initialLoading: $initialLoading)';
}


}

/// @nodoc
abstract mixin class $AiChatStateCopyWith<$Res>  {
  factory $AiChatStateCopyWith(AiChatState value, $Res Function(AiChatState) _then) = _$AiChatStateCopyWithImpl;
@useResult
$Res call({
 List<AiChatItem> items, bool isLoading, bool initialLoading
});




}
/// @nodoc
class _$AiChatStateCopyWithImpl<$Res>
    implements $AiChatStateCopyWith<$Res> {
  _$AiChatStateCopyWithImpl(this._self, this._then);

  final AiChatState _self;
  final $Res Function(AiChatState) _then;

/// Create a copy of AiChatState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? items = null,Object? isLoading = null,Object? initialLoading = null,}) {
  return _then(_self.copyWith(
items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<AiChatItem>,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,initialLoading: null == initialLoading ? _self.initialLoading : initialLoading // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [AiChatState].
extension AiChatStatePatterns on AiChatState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AiChatState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AiChatState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AiChatState value)  $default,){
final _that = this;
switch (_that) {
case _AiChatState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AiChatState value)?  $default,){
final _that = this;
switch (_that) {
case _AiChatState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<AiChatItem> items,  bool isLoading,  bool initialLoading)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AiChatState() when $default != null:
return $default(_that.items,_that.isLoading,_that.initialLoading);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<AiChatItem> items,  bool isLoading,  bool initialLoading)  $default,) {final _that = this;
switch (_that) {
case _AiChatState():
return $default(_that.items,_that.isLoading,_that.initialLoading);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<AiChatItem> items,  bool isLoading,  bool initialLoading)?  $default,) {final _that = this;
switch (_that) {
case _AiChatState() when $default != null:
return $default(_that.items,_that.isLoading,_that.initialLoading);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AiChatState implements AiChatState {
  const _AiChatState({final  List<AiChatItem> items = const [], this.isLoading = false, this.initialLoading = false}): _items = items;
  factory _AiChatState.fromJson(Map<String, dynamic> json) => _$AiChatStateFromJson(json);

 final  List<AiChatItem> _items;
@override@JsonKey() List<AiChatItem> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}

@override@JsonKey() final  bool isLoading;
@override@JsonKey() final  bool initialLoading;

/// Create a copy of AiChatState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AiChatStateCopyWith<_AiChatState> get copyWith => __$AiChatStateCopyWithImpl<_AiChatState>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AiChatStateToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AiChatState&&const DeepCollectionEquality().equals(other._items, _items)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.initialLoading, initialLoading) || other.initialLoading == initialLoading));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_items),isLoading,initialLoading);

@override
String toString() {
  return 'AiChatState(items: $items, isLoading: $isLoading, initialLoading: $initialLoading)';
}


}

/// @nodoc
abstract mixin class _$AiChatStateCopyWith<$Res> implements $AiChatStateCopyWith<$Res> {
  factory _$AiChatStateCopyWith(_AiChatState value, $Res Function(_AiChatState) _then) = __$AiChatStateCopyWithImpl;
@override @useResult
$Res call({
 List<AiChatItem> items, bool isLoading, bool initialLoading
});




}
/// @nodoc
class __$AiChatStateCopyWithImpl<$Res>
    implements _$AiChatStateCopyWith<$Res> {
  __$AiChatStateCopyWithImpl(this._self, this._then);

  final _AiChatState _self;
  final $Res Function(_AiChatState) _then;

/// Create a copy of AiChatState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? items = null,Object? isLoading = null,Object? initialLoading = null,}) {
  return _then(_AiChatState(
items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<AiChatItem>,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,initialLoading: null == initialLoading ? _self.initialLoading : initialLoading // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$AiChatItem {

 String? get id; String? get query; String? get error; AiChatResponse? get response;
/// Create a copy of AiChatItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AiChatItemCopyWith<AiChatItem> get copyWith => _$AiChatItemCopyWithImpl<AiChatItem>(this as AiChatItem, _$identity);

  /// Serializes this AiChatItem to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AiChatItem&&(identical(other.id, id) || other.id == id)&&(identical(other.query, query) || other.query == query)&&(identical(other.error, error) || other.error == error)&&(identical(other.response, response) || other.response == response));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,query,error,response);

@override
String toString() {
  return 'AiChatItem(id: $id, query: $query, error: $error, response: $response)';
}


}

/// @nodoc
abstract mixin class $AiChatItemCopyWith<$Res>  {
  factory $AiChatItemCopyWith(AiChatItem value, $Res Function(AiChatItem) _then) = _$AiChatItemCopyWithImpl;
@useResult
$Res call({
 String? id, String? query, String? error, AiChatResponse? response
});


$AiChatResponseCopyWith<$Res>? get response;

}
/// @nodoc
class _$AiChatItemCopyWithImpl<$Res>
    implements $AiChatItemCopyWith<$Res> {
  _$AiChatItemCopyWithImpl(this._self, this._then);

  final AiChatItem _self;
  final $Res Function(AiChatItem) _then;

/// Create a copy of AiChatItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? query = freezed,Object? error = freezed,Object? response = freezed,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,query: freezed == query ? _self.query : query // ignore: cast_nullable_to_non_nullable
as String?,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,response: freezed == response ? _self.response : response // ignore: cast_nullable_to_non_nullable
as AiChatResponse?,
  ));
}
/// Create a copy of AiChatItem
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AiChatResponseCopyWith<$Res>? get response {
    if (_self.response == null) {
    return null;
  }

  return $AiChatResponseCopyWith<$Res>(_self.response!, (value) {
    return _then(_self.copyWith(response: value));
  });
}
}


/// Adds pattern-matching-related methods to [AiChatItem].
extension AiChatItemPatterns on AiChatItem {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AiChatItem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AiChatItem() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AiChatItem value)  $default,){
final _that = this;
switch (_that) {
case _AiChatItem():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AiChatItem value)?  $default,){
final _that = this;
switch (_that) {
case _AiChatItem() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? id,  String? query,  String? error,  AiChatResponse? response)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AiChatItem() when $default != null:
return $default(_that.id,_that.query,_that.error,_that.response);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? id,  String? query,  String? error,  AiChatResponse? response)  $default,) {final _that = this;
switch (_that) {
case _AiChatItem():
return $default(_that.id,_that.query,_that.error,_that.response);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? id,  String? query,  String? error,  AiChatResponse? response)?  $default,) {final _that = this;
switch (_that) {
case _AiChatItem() when $default != null:
return $default(_that.id,_that.query,_that.error,_that.response);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AiChatItem implements AiChatItem {
  const _AiChatItem({this.id, this.query, this.error, this.response});
  factory _AiChatItem.fromJson(Map<String, dynamic> json) => _$AiChatItemFromJson(json);

@override final  String? id;
@override final  String? query;
@override final  String? error;
@override final  AiChatResponse? response;

/// Create a copy of AiChatItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AiChatItemCopyWith<_AiChatItem> get copyWith => __$AiChatItemCopyWithImpl<_AiChatItem>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AiChatItemToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AiChatItem&&(identical(other.id, id) || other.id == id)&&(identical(other.query, query) || other.query == query)&&(identical(other.error, error) || other.error == error)&&(identical(other.response, response) || other.response == response));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,query,error,response);

@override
String toString() {
  return 'AiChatItem(id: $id, query: $query, error: $error, response: $response)';
}


}

/// @nodoc
abstract mixin class _$AiChatItemCopyWith<$Res> implements $AiChatItemCopyWith<$Res> {
  factory _$AiChatItemCopyWith(_AiChatItem value, $Res Function(_AiChatItem) _then) = __$AiChatItemCopyWithImpl;
@override @useResult
$Res call({
 String? id, String? query, String? error, AiChatResponse? response
});


@override $AiChatResponseCopyWith<$Res>? get response;

}
/// @nodoc
class __$AiChatItemCopyWithImpl<$Res>
    implements _$AiChatItemCopyWith<$Res> {
  __$AiChatItemCopyWithImpl(this._self, this._then);

  final _AiChatItem _self;
  final $Res Function(_AiChatItem) _then;

/// Create a copy of AiChatItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? query = freezed,Object? error = freezed,Object? response = freezed,}) {
  return _then(_AiChatItem(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,query: freezed == query ? _self.query : query // ignore: cast_nullable_to_non_nullable
as String?,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,response: freezed == response ? _self.response : response // ignore: cast_nullable_to_non_nullable
as AiChatResponse?,
  ));
}

/// Create a copy of AiChatItem
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AiChatResponseCopyWith<$Res>? get response {
    if (_self.response == null) {
    return null;
  }

  return $AiChatResponseCopyWith<$Res>(_self.response!, (value) {
    return _then(_self.copyWith(response: value));
  });
}
}

// dart format on
