import 'package:freezed_annotation/freezed_annotation.dart';

part 'game_record.freezed.dart';
part 'game_record.g.dart';

@freezed
abstract class GameRecord with _$GameRecord {
  const factory GameRecord({
    required String id,
    required String source,
    required String title,
    @Default([]) List<Platform> platforms,
    @JsonKey(name: 'release_date') @StringToDateConverter() DateTime? releaseDate,
    String? description,
    @JsonKey(name: 'image_url') String? imageUrl,
    double? score,
    @Default([]) List<Store> stores,
    String? website,
    @Default([]) List<String> screenshots,
    @Default([]) List<Trailer> trailers,
    @Default([]) List<DLC> dlcs,
    @JsonKey(name: 'same_series') @Default([]) List<SameSeries> sameSeries,
    @JsonKey(name: 'reddit_posts') @Default([]) List<RedditPost> redditPosts,
    @Default({}) Map<String, dynamic> extra,
  }) = _GameRecord;

  factory GameRecord.fromJson(Map<String, dynamic> json) => _$GameRecordFromJson(json);
}

@freezed
abstract class Store with _$Store {
  const factory Store({required int id, String? name, String? url, String? image}) = _Store;

  factory Store.fromJson(Map<String, dynamic> json) => _$StoreFromJson(json);
}

@freezed
abstract class Trailer with _$Trailer {
  const factory Trailer({String? name, String? preview, String? video}) = _Trailer;

  factory Trailer.fromJson(Map<String, dynamic> json) => _$TrailerFromJson(json);
}

@freezed
abstract class RedditPost with _$RedditPost {
  const factory RedditPost({required int id, required String name, String? url, String? image}) = _RedditPost;

  factory RedditPost.fromJson(Map<String, dynamic> json) => _$RedditPostFromJson(json);
}

@freezed
abstract class Achievement with _$Achievement {
  const factory Achievement({required int id, String? name, String? description, String? image}) = _Achievement;

  factory Achievement.fromJson(Map<String, dynamic> json) => _$AchievementFromJson(json);
}

@freezed
abstract class DLC with _$DLC {
  const DLC._();
  const factory DLC({required int id, String? title, String? url, String? image}) = _DLC;

  factory DLC.fromJson(Map<String, dynamic> json) => _$DLCFromJson(json);

  HorizontalList toHorizontalList() => HorizontalList(id: id, name: title, image: image);
}

@freezed
abstract class SameSeries with _$SameSeries {
  const SameSeries._();
  const factory SameSeries({required int id, String? title, String? released, String? image}) = _SameSeries;

  factory SameSeries.fromJson(Map<String, dynamic> json) => _$SameSeriesFromJson(json);

  HorizontalList toHorizontalList() => HorizontalList(id: id, name: title, image: image);
}

@freezed
abstract class HorizontalList with _$HorizontalList {
  const factory HorizontalList({required int id, String? name, String? url, String? image}) = _HorizontalList;

  factory HorizontalList.fromJson(Map<String, dynamic> json) => _$HorizontalListFromJson(json);
}

@freezed
abstract class Platform with _$Platform {
  const factory Platform({required int id, String? name, Requirements? requirements, String? released}) = _Platform;

  factory Platform.fromJson(Map<String, dynamic> json) => _$PlatformFromJson(json);
}

@freezed
abstract class Requirements with _$Requirements {
  const factory Requirements({String? minimum, String? recommended}) = _Requirements;

  factory Requirements.fromJson(Map<String, dynamic> json) => _$RequirementsFromJson(json);
}

class StringToDateConverter implements JsonConverter<DateTime?, String?> {
  const StringToDateConverter();

  @override
  DateTime? fromJson(String? json) => json != null ? DateTime.parse(json) : null;

  @override
  String? toJson(DateTime? object) => object?.toIso8601String();
}
