import 'package:freezed_annotation/freezed_annotation.dart';

import 'game_record.dart';
import 'tag.dart';

part 'search.freezed.dart';

@freezed
abstract class SearchQueryParams with _$SearchQueryParams {
  const factory SearchQueryParams({
    String? query,
    @Default([]) List<Tag> tags,
    @Default([]) List<String> genres,
    GamePlatform? platform,
    @Default(GameOrdering.rating) GameOrdering ordering,
    @Default(true) bool searchPrecise,
    @Default(false) bool searchExact,
    @Default(true) bool reverseOrder,
  }) = _SearchQueryParams;
}
