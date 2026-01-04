// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AppState {

 int get selectedIndex; bool get blurAdultContent; Color? get themeSeedColor; ThemeMode get themeMode; bool get autoUpdateEnabled; Duration get autoUpdateInterval;
/// Create a copy of AppState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AppStateCopyWith<AppState> get copyWith => _$AppStateCopyWithImpl<AppState>(this as AppState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AppState&&(identical(other.selectedIndex, selectedIndex) || other.selectedIndex == selectedIndex)&&(identical(other.blurAdultContent, blurAdultContent) || other.blurAdultContent == blurAdultContent)&&(identical(other.themeSeedColor, themeSeedColor) || other.themeSeedColor == themeSeedColor)&&(identical(other.themeMode, themeMode) || other.themeMode == themeMode)&&(identical(other.autoUpdateEnabled, autoUpdateEnabled) || other.autoUpdateEnabled == autoUpdateEnabled)&&(identical(other.autoUpdateInterval, autoUpdateInterval) || other.autoUpdateInterval == autoUpdateInterval));
}


@override
int get hashCode => Object.hash(runtimeType,selectedIndex,blurAdultContent,themeSeedColor,themeMode,autoUpdateEnabled,autoUpdateInterval);

@override
String toString() {
  return 'AppState(selectedIndex: $selectedIndex, blurAdultContent: $blurAdultContent, themeSeedColor: $themeSeedColor, themeMode: $themeMode, autoUpdateEnabled: $autoUpdateEnabled, autoUpdateInterval: $autoUpdateInterval)';
}


}

/// @nodoc
abstract mixin class $AppStateCopyWith<$Res>  {
  factory $AppStateCopyWith(AppState value, $Res Function(AppState) _then) = _$AppStateCopyWithImpl;
@useResult
$Res call({
 int selectedIndex, bool blurAdultContent, Color? themeSeedColor, ThemeMode themeMode, bool autoUpdateEnabled, Duration autoUpdateInterval
});




}
/// @nodoc
class _$AppStateCopyWithImpl<$Res>
    implements $AppStateCopyWith<$Res> {
  _$AppStateCopyWithImpl(this._self, this._then);

  final AppState _self;
  final $Res Function(AppState) _then;

/// Create a copy of AppState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? selectedIndex = null,Object? blurAdultContent = null,Object? themeSeedColor = freezed,Object? themeMode = null,Object? autoUpdateEnabled = null,Object? autoUpdateInterval = null,}) {
  return _then(_self.copyWith(
selectedIndex: null == selectedIndex ? _self.selectedIndex : selectedIndex // ignore: cast_nullable_to_non_nullable
as int,blurAdultContent: null == blurAdultContent ? _self.blurAdultContent : blurAdultContent // ignore: cast_nullable_to_non_nullable
as bool,themeSeedColor: freezed == themeSeedColor ? _self.themeSeedColor : themeSeedColor // ignore: cast_nullable_to_non_nullable
as Color?,themeMode: null == themeMode ? _self.themeMode : themeMode // ignore: cast_nullable_to_non_nullable
as ThemeMode,autoUpdateEnabled: null == autoUpdateEnabled ? _self.autoUpdateEnabled : autoUpdateEnabled // ignore: cast_nullable_to_non_nullable
as bool,autoUpdateInterval: null == autoUpdateInterval ? _self.autoUpdateInterval : autoUpdateInterval // ignore: cast_nullable_to_non_nullable
as Duration,
  ));
}

}


/// Adds pattern-matching-related methods to [AppState].
extension AppStatePatterns on AppState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AppState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AppState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AppState value)  $default,){
final _that = this;
switch (_that) {
case _AppState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AppState value)?  $default,){
final _that = this;
switch (_that) {
case _AppState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int selectedIndex,  bool blurAdultContent,  Color? themeSeedColor,  ThemeMode themeMode,  bool autoUpdateEnabled,  Duration autoUpdateInterval)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AppState() when $default != null:
return $default(_that.selectedIndex,_that.blurAdultContent,_that.themeSeedColor,_that.themeMode,_that.autoUpdateEnabled,_that.autoUpdateInterval);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int selectedIndex,  bool blurAdultContent,  Color? themeSeedColor,  ThemeMode themeMode,  bool autoUpdateEnabled,  Duration autoUpdateInterval)  $default,) {final _that = this;
switch (_that) {
case _AppState():
return $default(_that.selectedIndex,_that.blurAdultContent,_that.themeSeedColor,_that.themeMode,_that.autoUpdateEnabled,_that.autoUpdateInterval);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int selectedIndex,  bool blurAdultContent,  Color? themeSeedColor,  ThemeMode themeMode,  bool autoUpdateEnabled,  Duration autoUpdateInterval)?  $default,) {final _that = this;
switch (_that) {
case _AppState() when $default != null:
return $default(_that.selectedIndex,_that.blurAdultContent,_that.themeSeedColor,_that.themeMode,_that.autoUpdateEnabled,_that.autoUpdateInterval);case _:
  return null;

}
}

}

/// @nodoc


class _AppState implements AppState {
  const _AppState({this.selectedIndex = 0, this.blurAdultContent = true, this.themeSeedColor, this.themeMode = ThemeMode.system, this.autoUpdateEnabled = true, this.autoUpdateInterval = const Duration(hours: 1)});
  

@override@JsonKey() final  int selectedIndex;
@override@JsonKey() final  bool blurAdultContent;
@override final  Color? themeSeedColor;
@override@JsonKey() final  ThemeMode themeMode;
@override@JsonKey() final  bool autoUpdateEnabled;
@override@JsonKey() final  Duration autoUpdateInterval;

/// Create a copy of AppState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AppStateCopyWith<_AppState> get copyWith => __$AppStateCopyWithImpl<_AppState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AppState&&(identical(other.selectedIndex, selectedIndex) || other.selectedIndex == selectedIndex)&&(identical(other.blurAdultContent, blurAdultContent) || other.blurAdultContent == blurAdultContent)&&(identical(other.themeSeedColor, themeSeedColor) || other.themeSeedColor == themeSeedColor)&&(identical(other.themeMode, themeMode) || other.themeMode == themeMode)&&(identical(other.autoUpdateEnabled, autoUpdateEnabled) || other.autoUpdateEnabled == autoUpdateEnabled)&&(identical(other.autoUpdateInterval, autoUpdateInterval) || other.autoUpdateInterval == autoUpdateInterval));
}


@override
int get hashCode => Object.hash(runtimeType,selectedIndex,blurAdultContent,themeSeedColor,themeMode,autoUpdateEnabled,autoUpdateInterval);

@override
String toString() {
  return 'AppState(selectedIndex: $selectedIndex, blurAdultContent: $blurAdultContent, themeSeedColor: $themeSeedColor, themeMode: $themeMode, autoUpdateEnabled: $autoUpdateEnabled, autoUpdateInterval: $autoUpdateInterval)';
}


}

/// @nodoc
abstract mixin class _$AppStateCopyWith<$Res> implements $AppStateCopyWith<$Res> {
  factory _$AppStateCopyWith(_AppState value, $Res Function(_AppState) _then) = __$AppStateCopyWithImpl;
@override @useResult
$Res call({
 int selectedIndex, bool blurAdultContent, Color? themeSeedColor, ThemeMode themeMode, bool autoUpdateEnabled, Duration autoUpdateInterval
});




}
/// @nodoc
class __$AppStateCopyWithImpl<$Res>
    implements _$AppStateCopyWith<$Res> {
  __$AppStateCopyWithImpl(this._self, this._then);

  final _AppState _self;
  final $Res Function(_AppState) _then;

/// Create a copy of AppState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? selectedIndex = null,Object? blurAdultContent = null,Object? themeSeedColor = freezed,Object? themeMode = null,Object? autoUpdateEnabled = null,Object? autoUpdateInterval = null,}) {
  return _then(_AppState(
selectedIndex: null == selectedIndex ? _self.selectedIndex : selectedIndex // ignore: cast_nullable_to_non_nullable
as int,blurAdultContent: null == blurAdultContent ? _self.blurAdultContent : blurAdultContent // ignore: cast_nullable_to_non_nullable
as bool,themeSeedColor: freezed == themeSeedColor ? _self.themeSeedColor : themeSeedColor // ignore: cast_nullable_to_non_nullable
as Color?,themeMode: null == themeMode ? _self.themeMode : themeMode // ignore: cast_nullable_to_non_nullable
as ThemeMode,autoUpdateEnabled: null == autoUpdateEnabled ? _self.autoUpdateEnabled : autoUpdateEnabled // ignore: cast_nullable_to_non_nullable
as bool,autoUpdateInterval: null == autoUpdateInterval ? _self.autoUpdateInterval : autoUpdateInterval // ignore: cast_nullable_to_non_nullable
as Duration,
  ));
}


}

// dart format on
