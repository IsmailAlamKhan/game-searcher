import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../models/game_record.dart';
import '../services/api_service.dart';
import '../utils/get_colors_from_image.dart';
import '../utils/logger.dart';

part 'game_details_provider.g.dart';

@riverpod
class GameDetails extends _$GameDetails {
  @override
  Future<GameRecord> build(String id) async {
    appLogger.d('------ Building game details for $id');
    final api = ref.watch(apiServiceProvider);
    appLogger.d('------ Fetching game details for $id');
    return api
        .getGameDetails(id)
        .then((value) async {
          appLogger.d('------ Fetched game details for $id');
          List<Color> colors;
          appLogger.d('------ Fetching colors for $id');
          if (value.imageUrl != null) {
            try {
              final imageProvider = CachedNetworkImageProvider(value.imageUrl!);
              colors = await getColorsFromImage(imageProvider);
            } catch (e) {
              colors = [];
            }

            value = value.copyWith(colors: colors);
          }
          return value;
        })
        .catchError((e, s) {
          appLogger.e('------ Failed to fetch game details for $id', error: e, stackTrace: s);
          throw e;
        });
  }
}
