import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../models/game_record.dart';
import '../services/api_service.dart';
import '../utils/get_colors_from_image.dart';
import '../utils/logger.dart';
import 'app_provider.dart';

part 'game_details_provider.g.dart';

@riverpod
class GameDetails extends _$GameDetails {
  @override
  Future<GameRecord> build(String id) async {
    final api = ref.watch(apiServiceProvider);

    return api
        .getGameDetails(id)
        .then((value) async {
          List<Color> colors;
          if (value.imageUrl != null) {
            try {
              final imageProvider = CachedNetworkImageProvider(value.imageUrl!);
              colors = await getColorsFromImage(imageProvider);
              ref
                  .read(appControllerProvider.notifier)
                  .setThemeSeedColor(color: colors.first, shouldUpdateStorage: false);
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
