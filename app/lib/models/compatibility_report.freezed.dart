// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'compatibility_report.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CompatibilityReport {

 String get overall;@JsonKey(name: 'predicted_preset') String? get predictedPreset; Map<String, ComponentResult> get details; List<String> get warnings;
/// Create a copy of CompatibilityReport
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CompatibilityReportCopyWith<CompatibilityReport> get copyWith => _$CompatibilityReportCopyWithImpl<CompatibilityReport>(this as CompatibilityReport, _$identity);

  /// Serializes this CompatibilityReport to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CompatibilityReport&&(identical(other.overall, overall) || other.overall == overall)&&(identical(other.predictedPreset, predictedPreset) || other.predictedPreset == predictedPreset)&&const DeepCollectionEquality().equals(other.details, details)&&const DeepCollectionEquality().equals(other.warnings, warnings));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,overall,predictedPreset,const DeepCollectionEquality().hash(details),const DeepCollectionEquality().hash(warnings));

@override
String toString() {
  return 'CompatibilityReport(overall: $overall, predictedPreset: $predictedPreset, details: $details, warnings: $warnings)';
}


}

/// @nodoc
abstract mixin class $CompatibilityReportCopyWith<$Res>  {
  factory $CompatibilityReportCopyWith(CompatibilityReport value, $Res Function(CompatibilityReport) _then) = _$CompatibilityReportCopyWithImpl;
@useResult
$Res call({
 String overall,@JsonKey(name: 'predicted_preset') String? predictedPreset, Map<String, ComponentResult> details, List<String> warnings
});




}
/// @nodoc
class _$CompatibilityReportCopyWithImpl<$Res>
    implements $CompatibilityReportCopyWith<$Res> {
  _$CompatibilityReportCopyWithImpl(this._self, this._then);

  final CompatibilityReport _self;
  final $Res Function(CompatibilityReport) _then;

/// Create a copy of CompatibilityReport
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? overall = null,Object? predictedPreset = freezed,Object? details = null,Object? warnings = null,}) {
  return _then(_self.copyWith(
overall: null == overall ? _self.overall : overall // ignore: cast_nullable_to_non_nullable
as String,predictedPreset: freezed == predictedPreset ? _self.predictedPreset : predictedPreset // ignore: cast_nullable_to_non_nullable
as String?,details: null == details ? _self.details : details // ignore: cast_nullable_to_non_nullable
as Map<String, ComponentResult>,warnings: null == warnings ? _self.warnings : warnings // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

}


/// Adds pattern-matching-related methods to [CompatibilityReport].
extension CompatibilityReportPatterns on CompatibilityReport {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CompatibilityReport value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CompatibilityReport() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CompatibilityReport value)  $default,){
final _that = this;
switch (_that) {
case _CompatibilityReport():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CompatibilityReport value)?  $default,){
final _that = this;
switch (_that) {
case _CompatibilityReport() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String overall, @JsonKey(name: 'predicted_preset')  String? predictedPreset,  Map<String, ComponentResult> details,  List<String> warnings)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CompatibilityReport() when $default != null:
return $default(_that.overall,_that.predictedPreset,_that.details,_that.warnings);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String overall, @JsonKey(name: 'predicted_preset')  String? predictedPreset,  Map<String, ComponentResult> details,  List<String> warnings)  $default,) {final _that = this;
switch (_that) {
case _CompatibilityReport():
return $default(_that.overall,_that.predictedPreset,_that.details,_that.warnings);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String overall, @JsonKey(name: 'predicted_preset')  String? predictedPreset,  Map<String, ComponentResult> details,  List<String> warnings)?  $default,) {final _that = this;
switch (_that) {
case _CompatibilityReport() when $default != null:
return $default(_that.overall,_that.predictedPreset,_that.details,_that.warnings);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CompatibilityReport implements CompatibilityReport {
  const _CompatibilityReport({required this.overall, @JsonKey(name: 'predicted_preset') this.predictedPreset, final  Map<String, ComponentResult> details = const {}, final  List<String> warnings = const []}): _details = details,_warnings = warnings;
  factory _CompatibilityReport.fromJson(Map<String, dynamic> json) => _$CompatibilityReportFromJson(json);

@override final  String overall;
@override@JsonKey(name: 'predicted_preset') final  String? predictedPreset;
 final  Map<String, ComponentResult> _details;
@override@JsonKey() Map<String, ComponentResult> get details {
  if (_details is EqualUnmodifiableMapView) return _details;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_details);
}

 final  List<String> _warnings;
@override@JsonKey() List<String> get warnings {
  if (_warnings is EqualUnmodifiableListView) return _warnings;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_warnings);
}


/// Create a copy of CompatibilityReport
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CompatibilityReportCopyWith<_CompatibilityReport> get copyWith => __$CompatibilityReportCopyWithImpl<_CompatibilityReport>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CompatibilityReportToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CompatibilityReport&&(identical(other.overall, overall) || other.overall == overall)&&(identical(other.predictedPreset, predictedPreset) || other.predictedPreset == predictedPreset)&&const DeepCollectionEquality().equals(other._details, _details)&&const DeepCollectionEquality().equals(other._warnings, _warnings));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,overall,predictedPreset,const DeepCollectionEquality().hash(_details),const DeepCollectionEquality().hash(_warnings));

@override
String toString() {
  return 'CompatibilityReport(overall: $overall, predictedPreset: $predictedPreset, details: $details, warnings: $warnings)';
}


}

/// @nodoc
abstract mixin class _$CompatibilityReportCopyWith<$Res> implements $CompatibilityReportCopyWith<$Res> {
  factory _$CompatibilityReportCopyWith(_CompatibilityReport value, $Res Function(_CompatibilityReport) _then) = __$CompatibilityReportCopyWithImpl;
@override @useResult
$Res call({
 String overall,@JsonKey(name: 'predicted_preset') String? predictedPreset, Map<String, ComponentResult> details, List<String> warnings
});




}
/// @nodoc
class __$CompatibilityReportCopyWithImpl<$Res>
    implements _$CompatibilityReportCopyWith<$Res> {
  __$CompatibilityReportCopyWithImpl(this._self, this._then);

  final _CompatibilityReport _self;
  final $Res Function(_CompatibilityReport) _then;

/// Create a copy of CompatibilityReport
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? overall = null,Object? predictedPreset = freezed,Object? details = null,Object? warnings = null,}) {
  return _then(_CompatibilityReport(
overall: null == overall ? _self.overall : overall // ignore: cast_nullable_to_non_nullable
as String,predictedPreset: freezed == predictedPreset ? _self.predictedPreset : predictedPreset // ignore: cast_nullable_to_non_nullable
as String?,details: null == details ? _self._details : details // ignore: cast_nullable_to_non_nullable
as Map<String, ComponentResult>,warnings: null == warnings ? _self._warnings : warnings // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}


/// @nodoc
mixin _$ComponentResult {

 String get user; String get status; String? get requirement; String? get message;
/// Create a copy of ComponentResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ComponentResultCopyWith<ComponentResult> get copyWith => _$ComponentResultCopyWithImpl<ComponentResult>(this as ComponentResult, _$identity);

  /// Serializes this ComponentResult to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ComponentResult&&(identical(other.user, user) || other.user == user)&&(identical(other.status, status) || other.status == status)&&(identical(other.requirement, requirement) || other.requirement == requirement)&&(identical(other.message, message) || other.message == message));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,user,status,requirement,message);

@override
String toString() {
  return 'ComponentResult(user: $user, status: $status, requirement: $requirement, message: $message)';
}


}

/// @nodoc
abstract mixin class $ComponentResultCopyWith<$Res>  {
  factory $ComponentResultCopyWith(ComponentResult value, $Res Function(ComponentResult) _then) = _$ComponentResultCopyWithImpl;
@useResult
$Res call({
 String user, String status, String? requirement, String? message
});




}
/// @nodoc
class _$ComponentResultCopyWithImpl<$Res>
    implements $ComponentResultCopyWith<$Res> {
  _$ComponentResultCopyWithImpl(this._self, this._then);

  final ComponentResult _self;
  final $Res Function(ComponentResult) _then;

/// Create a copy of ComponentResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? user = null,Object? status = null,Object? requirement = freezed,Object? message = freezed,}) {
  return _then(_self.copyWith(
user: null == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,requirement: freezed == requirement ? _self.requirement : requirement // ignore: cast_nullable_to_non_nullable
as String?,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ComponentResult].
extension ComponentResultPatterns on ComponentResult {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ComponentResult value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ComponentResult() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ComponentResult value)  $default,){
final _that = this;
switch (_that) {
case _ComponentResult():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ComponentResult value)?  $default,){
final _that = this;
switch (_that) {
case _ComponentResult() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String user,  String status,  String? requirement,  String? message)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ComponentResult() when $default != null:
return $default(_that.user,_that.status,_that.requirement,_that.message);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String user,  String status,  String? requirement,  String? message)  $default,) {final _that = this;
switch (_that) {
case _ComponentResult():
return $default(_that.user,_that.status,_that.requirement,_that.message);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String user,  String status,  String? requirement,  String? message)?  $default,) {final _that = this;
switch (_that) {
case _ComponentResult() when $default != null:
return $default(_that.user,_that.status,_that.requirement,_that.message);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ComponentResult implements ComponentResult {
  const _ComponentResult({required this.user, required this.status, this.requirement, this.message});
  factory _ComponentResult.fromJson(Map<String, dynamic> json) => _$ComponentResultFromJson(json);

@override final  String user;
@override final  String status;
@override final  String? requirement;
@override final  String? message;

/// Create a copy of ComponentResult
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ComponentResultCopyWith<_ComponentResult> get copyWith => __$ComponentResultCopyWithImpl<_ComponentResult>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ComponentResultToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ComponentResult&&(identical(other.user, user) || other.user == user)&&(identical(other.status, status) || other.status == status)&&(identical(other.requirement, requirement) || other.requirement == requirement)&&(identical(other.message, message) || other.message == message));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,user,status,requirement,message);

@override
String toString() {
  return 'ComponentResult(user: $user, status: $status, requirement: $requirement, message: $message)';
}


}

/// @nodoc
abstract mixin class _$ComponentResultCopyWith<$Res> implements $ComponentResultCopyWith<$Res> {
  factory _$ComponentResultCopyWith(_ComponentResult value, $Res Function(_ComponentResult) _then) = __$ComponentResultCopyWithImpl;
@override @useResult
$Res call({
 String user, String status, String? requirement, String? message
});




}
/// @nodoc
class __$ComponentResultCopyWithImpl<$Res>
    implements _$ComponentResultCopyWith<$Res> {
  __$ComponentResultCopyWithImpl(this._self, this._then);

  final _ComponentResult _self;
  final $Res Function(_ComponentResult) _then;

/// Create a copy of ComponentResult
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? user = null,Object? status = null,Object? requirement = freezed,Object? message = freezed,}) {
  return _then(_ComponentResult(
user: null == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,requirement: freezed == requirement ? _self.requirement : requirement // ignore: cast_nullable_to_non_nullable
as String?,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
