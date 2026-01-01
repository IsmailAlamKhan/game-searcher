// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_record.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_GameRecord _$GameRecordFromJson(Map<String, dynamic> json) => _GameRecord(
  id: json['id'] as String,
  title: json['title'] as String,
  platforms:
      (json['platforms'] as List<dynamic>?)
          ?.map((e) => Platform.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  releaseDate: const StringToDateConverter().fromJson(
    json['release_date'] as String?,
  ),
  description: json['description'] as String?,
  imageUrl: json['image_url'] as String?,
  score: (json['score'] as num?)?.toDouble(),
  stores:
      (json['stores'] as List<dynamic>?)
          ?.map((e) => Store.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  website: json['website'] as String?,
  screenshots:
      (json['screenshots'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  trailers:
      (json['trailers'] as List<dynamic>?)
          ?.map((e) => Trailer.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  dlcs:
      (json['dlcs'] as List<dynamic>?)
          ?.map((e) => DLC.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  sameSeries:
      (json['same_series'] as List<dynamic>?)
          ?.map((e) => SameSeries.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  redditPosts:
      (json['reddit_posts'] as List<dynamic>?)
          ?.map((e) => RedditPost.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  extra: json['extra'] as Map<String, dynamic>? ?? const {},
  esrbRating: json['esrb_rating'] == null
      ? null
      : EsrbRating.fromJson(json['esrb_rating'] as Map<String, dynamic>),
);

Map<String, dynamic> _$GameRecordToJson(
  _GameRecord instance,
) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'platforms': instance.platforms,
  'release_date': const StringToDateConverter().toJson(instance.releaseDate),
  'description': instance.description,
  'image_url': instance.imageUrl,
  'score': instance.score,
  'stores': instance.stores,
  'website': instance.website,
  'screenshots': instance.screenshots,
  'trailers': instance.trailers,
  'dlcs': instance.dlcs,
  'same_series': instance.sameSeries,
  'reddit_posts': instance.redditPosts,
  'extra': instance.extra,
  'esrb_rating': instance.esrbRating,
};

_Store _$StoreFromJson(Map<String, dynamic> json) => _Store(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String?,
  url: json['url'] as String?,
  image: json['image'] as String?,
  color: const StringToColorConverter().fromJson(json['color'] as String?),
);

Map<String, dynamic> _$StoreToJson(_Store instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'url': instance.url,
  'image': instance.image,
  'color': const StringToColorConverter().toJson(instance.color),
};

_Trailer _$TrailerFromJson(Map<String, dynamic> json) => _Trailer(
  name: json['name'] as String?,
  preview: json['preview'] as String?,
  video: json['video'] as String?,
);

Map<String, dynamic> _$TrailerToJson(_Trailer instance) => <String, dynamic>{
  'name': instance.name,
  'preview': instance.preview,
  'video': instance.video,
};

_RedditPost _$RedditPostFromJson(Map<String, dynamic> json) => _RedditPost(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  url: json['url'] as String?,
  image: json['image'] as String?,
);

Map<String, dynamic> _$RedditPostToJson(_RedditPost instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'url': instance.url,
      'image': instance.image,
    };

_Achievement _$AchievementFromJson(Map<String, dynamic> json) => _Achievement(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String?,
  description: json['description'] as String?,
  image: json['image'] as String?,
);

Map<String, dynamic> _$AchievementToJson(_Achievement instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'image': instance.image,
    };

_DLC _$DLCFromJson(Map<String, dynamic> json) => _DLC(
  id: (json['id'] as num).toInt(),
  title: json['title'] as String?,
  url: json['url'] as String?,
  image: json['image'] as String?,
);

Map<String, dynamic> _$DLCToJson(_DLC instance) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'url': instance.url,
  'image': instance.image,
};

_SameSeries _$SameSeriesFromJson(Map<String, dynamic> json) => _SameSeries(
  id: (json['id'] as num).toInt(),
  title: json['title'] as String?,
  released: json['released'] as String?,
  image: json['image'] as String?,
);

Map<String, dynamic> _$SameSeriesToJson(_SameSeries instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'released': instance.released,
      'image': instance.image,
    };

_HorizontalList _$HorizontalListFromJson(Map<String, dynamic> json) =>
    _HorizontalList(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String?,
      url: json['url'] as String?,
      image: json['image'] as String?,
    );

Map<String, dynamic> _$HorizontalListToJson(_HorizontalList instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'url': instance.url,
      'image': instance.image,
    };

_Platform _$PlatformFromJson(Map<String, dynamic> json) => _Platform(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String?,
  requirements: json['requirements'] == null
      ? null
      : Requirements.fromJson(json['requirements'] as Map<String, dynamic>),
  released: json['released'] as String?,
  color: const StringToColorConverter().fromJson(json['color'] as String?),
  icon: json['icon'] as String?,
);

Map<String, dynamic> _$PlatformToJson(_Platform instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'requirements': instance.requirements,
  'released': instance.released,
  'color': const StringToColorConverter().toJson(instance.color),
  'icon': instance.icon,
};

_Requirements _$RequirementsFromJson(Map<String, dynamic> json) =>
    _Requirements(
      minimum: json['minimum'] as String?,
      recommended: json['recommended'] as String?,
    );

Map<String, dynamic> _$RequirementsToJson(_Requirements instance) =>
    <String, dynamic>{
      'minimum': instance.minimum,
      'recommended': instance.recommended,
    };

_GameScreenshot _$GameScreenshotFromJson(Map<String, dynamic> json) =>
    _GameScreenshot(
      id: (json['id'] as num).toInt(),
      image: json['image'] as String?,
      width: (json['width'] as num?)?.toInt(),
      height: (json['height'] as num?)?.toInt(),
      isDeleted: json['is_deleted'] as bool? ?? false,
    );

Map<String, dynamic> _$GameScreenshotToJson(_GameScreenshot instance) =>
    <String, dynamic>{
      'id': instance.id,
      'image': instance.image,
      'width': instance.width,
      'height': instance.height,
      'is_deleted': instance.isDeleted,
    };

_EsrbRating _$EsrbRatingFromJson(Map<String, dynamic> json) => _EsrbRating(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String?,
  slug: const EsrbRatingSlugConverter().fromJson(json['slug'] as String?),
  nameEn: json['nameEn'] as String?,
  nameRu: json['nameRu'] as String?,
);

Map<String, dynamic> _$EsrbRatingToJson(_EsrbRating instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'slug': const EsrbRatingSlugConverter().toJson(instance.slug),
      'nameEn': instance.nameEn,
      'nameRu': instance.nameRu,
    };
