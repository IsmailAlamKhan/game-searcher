// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'compatibility_report.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CompatibilityReport _$CompatibilityReportFromJson(
  Map<String, dynamic> json,
) => _CompatibilityReport(
  overall: json['overall'] as String,
  predictedPreset: json['predicted_preset'] as String?,
  details:
      (json['details'] as Map<String, dynamic>?)?.map(
        (k, e) =>
            MapEntry(k, ComponentResult.fromJson(e as Map<String, dynamic>)),
      ) ??
      const {},
  warnings:
      (json['warnings'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
);

Map<String, dynamic> _$CompatibilityReportToJson(
  _CompatibilityReport instance,
) => <String, dynamic>{
  'overall': instance.overall,
  'predicted_preset': instance.predictedPreset,
  'details': instance.details,
  'warnings': instance.warnings,
};

_ComponentResult _$ComponentResultFromJson(Map<String, dynamic> json) =>
    _ComponentResult(
      user: json['user'] as String,
      status: json['status'] as String,
      requirement: json['requirement'] as String?,
      message: json['message'] as String?,
    );

Map<String, dynamic> _$ComponentResultToJson(_ComponentResult instance) =>
    <String, dynamic>{
      'user': instance.user,
      'status': instance.status,
      'requirement': instance.requirement,
      'message': instance.message,
    };
