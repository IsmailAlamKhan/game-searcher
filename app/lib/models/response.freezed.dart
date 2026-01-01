// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PagainatedApiResponse<T> {

 int get count; int? get next; List<T>? get results;
/// Create a copy of PagainatedApiResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PagainatedApiResponseCopyWith<T, PagainatedApiResponse<T>> get copyWith => _$PagainatedApiResponseCopyWithImpl<T, PagainatedApiResponse<T>>(this as PagainatedApiResponse<T>, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PagainatedApiResponse<T>&&(identical(other.count, count) || other.count == count)&&(identical(other.next, next) || other.next == next)&&const DeepCollectionEquality().equals(other.results, results));
}


@override
int get hashCode => Object.hash(runtimeType,count,next,const DeepCollectionEquality().hash(results));

@override
String toString() {
  return 'PagainatedApiResponse<$T>(count: $count, next: $next, results: $results)';
}


}

/// @nodoc
abstract mixin class $PagainatedApiResponseCopyWith<T,$Res>  {
  factory $PagainatedApiResponseCopyWith(PagainatedApiResponse<T> value, $Res Function(PagainatedApiResponse<T>) _then) = _$PagainatedApiResponseCopyWithImpl;
@useResult
$Res call({
 int count, int? next, List<T>? results
});




}
/// @nodoc
class _$PagainatedApiResponseCopyWithImpl<T,$Res>
    implements $PagainatedApiResponseCopyWith<T, $Res> {
  _$PagainatedApiResponseCopyWithImpl(this._self, this._then);

  final PagainatedApiResponse<T> _self;
  final $Res Function(PagainatedApiResponse<T>) _then;

/// Create a copy of PagainatedApiResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? count = null,Object? next = freezed,Object? results = freezed,}) {
  return _then(_self.copyWith(
count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,next: freezed == next ? _self.next : next // ignore: cast_nullable_to_non_nullable
as int?,results: freezed == results ? _self.results : results // ignore: cast_nullable_to_non_nullable
as List<T>?,
  ));
}

}


/// Adds pattern-matching-related methods to [PagainatedApiResponse].
extension PagainatedApiResponsePatterns<T> on PagainatedApiResponse<T> {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PagainatedApiResponse<T> value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PagainatedApiResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PagainatedApiResponse<T> value)  $default,){
final _that = this;
switch (_that) {
case _PagainatedApiResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PagainatedApiResponse<T> value)?  $default,){
final _that = this;
switch (_that) {
case _PagainatedApiResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int count,  int? next,  List<T>? results)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PagainatedApiResponse() when $default != null:
return $default(_that.count,_that.next,_that.results);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int count,  int? next,  List<T>? results)  $default,) {final _that = this;
switch (_that) {
case _PagainatedApiResponse():
return $default(_that.count,_that.next,_that.results);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int count,  int? next,  List<T>? results)?  $default,) {final _that = this;
switch (_that) {
case _PagainatedApiResponse() when $default != null:
return $default(_that.count,_that.next,_that.results);case _:
  return null;

}
}

}

/// @nodoc


class _PagainatedApiResponse<T> implements PagainatedApiResponse<T> {
  const _PagainatedApiResponse({required this.count, this.next, final  List<T>? results}): _results = results;
  

@override final  int count;
@override final  int? next;
 final  List<T>? _results;
@override List<T>? get results {
  final value = _results;
  if (value == null) return null;
  if (_results is EqualUnmodifiableListView) return _results;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}


/// Create a copy of PagainatedApiResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PagainatedApiResponseCopyWith<T, _PagainatedApiResponse<T>> get copyWith => __$PagainatedApiResponseCopyWithImpl<T, _PagainatedApiResponse<T>>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PagainatedApiResponse<T>&&(identical(other.count, count) || other.count == count)&&(identical(other.next, next) || other.next == next)&&const DeepCollectionEquality().equals(other._results, _results));
}


@override
int get hashCode => Object.hash(runtimeType,count,next,const DeepCollectionEquality().hash(_results));

@override
String toString() {
  return 'PagainatedApiResponse<$T>(count: $count, next: $next, results: $results)';
}


}

/// @nodoc
abstract mixin class _$PagainatedApiResponseCopyWith<T,$Res> implements $PagainatedApiResponseCopyWith<T, $Res> {
  factory _$PagainatedApiResponseCopyWith(_PagainatedApiResponse<T> value, $Res Function(_PagainatedApiResponse<T>) _then) = __$PagainatedApiResponseCopyWithImpl;
@override @useResult
$Res call({
 int count, int? next, List<T>? results
});




}
/// @nodoc
class __$PagainatedApiResponseCopyWithImpl<T,$Res>
    implements _$PagainatedApiResponseCopyWith<T, $Res> {
  __$PagainatedApiResponseCopyWithImpl(this._self, this._then);

  final _PagainatedApiResponse<T> _self;
  final $Res Function(_PagainatedApiResponse<T>) _then;

/// Create a copy of PagainatedApiResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? count = null,Object? next = freezed,Object? results = freezed,}) {
  return _then(_PagainatedApiResponse<T>(
count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,next: freezed == next ? _self.next : next // ignore: cast_nullable_to_non_nullable
as int?,results: freezed == results ? _self._results : results // ignore: cast_nullable_to_non_nullable
as List<T>?,
  ));
}


}

// dart format on
