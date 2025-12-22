// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_record.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_GameRecord _$GameRecordFromJson(Map<String, dynamic> json) => _GameRecord(
  id: json['id'] as String,
  source: json['source'] as String,
  title: json['title'] as String,
  platforms:
      (json['platforms'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
  releaseDate: json['release_date'] as String?,
  description: json['description'] as String?,
  imageUrl: json['image_url'] as String?,
  score: (json['score'] as num?)?.toDouble(),
  extra: json['extra'] as Map<String, dynamic>? ?? const {},
);

Map<String, dynamic> _$GameRecordToJson(_GameRecord instance) =>
    <String, dynamic>{
      'id': instance.id,
      'source': instance.source,
      'title': instance.title,
      'platforms': instance.platforms,
      'release_date': instance.releaseDate,
      'description': instance.description,
      'image_url': instance.imageUrl,
      'score': instance.score,
      'extra': instance.extra,
    };
