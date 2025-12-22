import 'package:freezed_annotation/freezed_annotation.dart';

part 'tag.freezed.dart';
part 'tag.g.dart';

@freezed
abstract class Tag with _$Tag {
  const factory Tag({
    required int id,
    required String name,
    required String slug,
    @JsonKey(name: 'games_count') required int gamesCount,
    @JsonKey(name: 'image_background') String? imageBackground,
  }) = _Tag;

  factory Tag.fromJson(Map<String, dynamic> json) => _$TagFromJson(json);
}
