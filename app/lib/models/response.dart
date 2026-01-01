import 'package:freezed_annotation/freezed_annotation.dart';

part 'response.freezed.dart';

@freezed
abstract class PagainatedApiResponse<T> with _$PagainatedApiResponse<T> {
  const factory PagainatedApiResponse({
    required int count,
    int? next,
    List<T>? results,
  }) = _PagainatedApiResponse;

  factory PagainatedApiResponse.fromJSON(Map<String, dynamic> json, T Function(Map<String, dynamic>) fromJsonT) {
    int? next;
    if (json['next'] is String) {
      next = int.parse(json['next']);
    }
    if (json['next'] case num value) {
      next = value.toInt();
    }
    return PagainatedApiResponse<T>(
      count: json['count'],
      next: next,
      results: (json['results'] as List?)?.cast<Map<String, dynamic>>().map((e) => fromJsonT(e)).toList(),
    );
  }
}
