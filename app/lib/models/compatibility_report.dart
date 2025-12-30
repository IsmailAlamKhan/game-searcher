import 'package:freezed_annotation/freezed_annotation.dart';

part 'compatibility_report.freezed.dart';
part 'compatibility_report.g.dart';

@freezed
abstract class CompatibilityReport with _$CompatibilityReport {
  const factory CompatibilityReport({
    required String overall,
    @JsonKey(name: 'predicted_preset') String? predictedPreset,
    @Default({}) Map<String, ComponentResult> details,
    @Default([]) List<String> warnings,
  }) = _CompatibilityReport;

  factory CompatibilityReport.fromJson(Map<String, dynamic> json) => _$CompatibilityReportFromJson(json);
}

@freezed
abstract class ComponentResult with _$ComponentResult {
  const factory ComponentResult({
    required String user,
    required String status,
    String? requirement,
    String? message,
  }) = _ComponentResult;

  factory ComponentResult.fromJson(Map<String, dynamic> json) => _$ComponentResultFromJson(json);
}
