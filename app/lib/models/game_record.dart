import 'package:freezed_annotation/freezed_annotation.dart';

part 'game_record.freezed.dart';
part 'game_record.g.dart';

@freezed
abstract class GameRecord with _$GameRecord {
  const factory GameRecord({
    required String id,
    required String source,
    required String title,
    @Default([]) List<String> platforms,
    @JsonKey(name: 'release_date') String? releaseDate,
    String? description,
    @JsonKey(name: 'image_url') String? imageUrl,
    double? score,
    @Default({}) Map<String, dynamic> extra,
  }) = _GameRecord;

  factory GameRecord.fromJson(Map<String, dynamic> json) =>
      _$GameRecordFromJson(json);
}
