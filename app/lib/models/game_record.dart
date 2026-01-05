import 'dart:ui';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'game_record.freezed.dart';
part 'game_record.g.dart';

enum GamePlatform {
  pc(1, 'PC'),
  playStation(2, 'PlayStation'),
  xbox(3, 'Xbox'),
  iOS(4, 'iOS'),
  android(8, 'Android'),
  macOS(5, 'macOS'),
  linux(6, 'Linux'),
  nintendoSwitch(7, 'Nintendo Switch')
  ;

  final int id;
  final String name;

  const GamePlatform(this.id, this.name);
}

enum GameOrdering {
  // name, released, added, created, updated, rating, metacritic
  name,
  released,
  added,
  created,
  updated,
  rating,
  metacritic
  ;

  String ordering(bool isReverse) => isReverse ? '-${this.name}' : this.name;
}

@freezed
abstract class GameRecord with _$GameRecord {
  const factory GameRecord({
    required String id,
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
    @JsonKey(name: 'esrb_rating') EsrbRating? esrbRating,
    @JsonKey(includeFromJson: false, includeToJson: false) List<Color>? colors,
  }) = _GameRecord;

  factory GameRecord.fromJson(Map<String, dynamic> json) => _$GameRecordFromJson(json);
}

@freezed
abstract class Store with _$Store {
  const factory Store({
    required int id,
    String? name,
    String? url,
    String? image,
    @StringToColorConverter() Color? color,
  }) = _Store;

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
  const Platform._();
  const factory Platform({
    required int id,
    String? name,
    Requirements? requirements,
    String? released,
    @StringToColorConverter() Color? color,
    String? icon,
  }) = _Platform;

  factory Platform.fromJson(Map<String, dynamic> json) => _$PlatformFromJson(json);

  GamePlatform get platform => GamePlatform.values.firstWhere((p) => p.id == id);
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

class StringToColorConverter implements JsonConverter<Color?, String?> {
  const StringToColorConverter();

  @override
  Color? fromJson(String? json) => json != null ? Color(int.parse(json, radix: 16)) : null;

  @override
  String? toJson(Color? object) => null;
}

@freezed
abstract class GameScreenshot with _$GameScreenshot {
  const factory GameScreenshot({
    required int id,
    String? image,
    int? width,
    int? height,
    @Default(false) @JsonKey(name: "is_deleted", defaultValue: false) bool isDeleted,
  }) = _GameScreenshot;

  factory GameScreenshot.fromJson(Map<String, dynamic> json) => _$GameScreenshotFromJson(json);
}

enum EsrbRatingSlug {
  adultsOnly,
  everyone,
  everyone10Plus,
  mature,
  teenagers,
  ratingPending
  ;

  String get name {
    switch (this) {
      case EsrbRatingSlug.adultsOnly:
        return 'Adults Only';
      case EsrbRatingSlug.everyone:
        return 'Everyone';
      case EsrbRatingSlug.everyone10Plus:
        return 'Everyone 10+';
      case EsrbRatingSlug.mature:
        return 'Mature';
      case EsrbRatingSlug.teenagers:
        return 'Teenagers';
      case EsrbRatingSlug.ratingPending:
        return 'Rating Pending';
    }
  }
}

@freezed
abstract class EsrbRating with _$EsrbRating {
  const EsrbRating._();
  const factory EsrbRating({
    required int id,
    String? name,
    @JsonKey(name: "slug") @EsrbRatingSlugConverter() EsrbRatingSlug? slug,
    String? nameEn,
    String? nameRu,
  }) = _EsrbRating;

  factory EsrbRating.fromJson(Map<String, dynamic> json) => _$EsrbRatingFromJson(json);

  bool get isAdultOnly => slug == EsrbRatingSlug.adultsOnly;
}

class EsrbRatingSlugConverter implements JsonConverter<EsrbRatingSlug?, String?> {
  const EsrbRatingSlugConverter();

  @override
  EsrbRatingSlug? fromJson(String? json) {
    if (json == null) return null;
    switch (json) {
      case 'adults-only':
        return EsrbRatingSlug.adultsOnly;
      case 'everyone':
        return EsrbRatingSlug.everyone;
      case 'everyone-10-plus':
        return EsrbRatingSlug.everyone10Plus;
      case 'mature':
        return EsrbRatingSlug.mature;
      case 'teen':
        return EsrbRatingSlug.teenagers;
      case 'rating-pending':
        return EsrbRatingSlug.ratingPending;
      default:
        return null;
    }
  }

  @override
  String? toJson(EsrbRatingSlug? object) {
    if (object == null) return null;
    switch (object) {
      case EsrbRatingSlug.adultsOnly:
        return 'adults-only';
      case EsrbRatingSlug.everyone:
        return 'everyone';
      case EsrbRatingSlug.everyone10Plus:
        return 'everyone-10-plus';
      case EsrbRatingSlug.mature:
        return 'mature';
      case EsrbRatingSlug.teenagers:
        return 'teen';
      case EsrbRatingSlug.ratingPending:
        return 'rating-pending';
    }
  }
}
