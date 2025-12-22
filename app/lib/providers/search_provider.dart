import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../models/game_record.dart';
import '../services/api_service.dart';

part 'search_provider.g.dart';

@riverpod
class SearchController extends _$SearchController {
  @override
  FutureOr<List<GameRecord>> build() {
    return [];
  }

  Future<void> search(String query) async {
    if (query.isEmpty) return;
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(
      () => ref.read(apiServiceProvider).search(query),
    );
  }
}
