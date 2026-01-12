import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';

import '../models/ai_chat_state.dart';
import '../services/chat_service.dart';
import '../services/preferences_service.dart';
import 'app_provider.dart';

part 'ai_chat_provider.g.dart';

@riverpod
class AiChatController extends _$AiChatController {
  late AiChatService _chatService;
  late PreferencesService _preferencesService;

  @override
  AiChatState build() {
    _chatService = ref.read(aiChatServiceProvider);
    _preferencesService = ref.read(preferencesServiceProvider);
    return AiChatState(items: _preferencesService.get(PrefKey.userChatHistory) ?? []);
  }

  Future<void> sendMessage(String message) async {
    final id = Uuid().v4();
    AiChatItem item = AiChatItem(id: id, query: message);
    List<AiChatItem> items = state.items.toList();
    items.add(item);
    state = state.copyWith(isLoading: true, items: items);
    final userid = ref.read(appControllerProvider).userId;
    try {
      final res = await _chatService.sendMessage(message, userid);
      item = item.copyWith(response: res);
    } catch (e) {
      item = item.copyWith(error: e.toString());
    }
    items = items.map((e) => e.id == id ? item : e).toList();
    state = state.copyWith(isLoading: false, items: items);
    _preferencesService.set(PrefKey.userChatHistory, items);
  }

  void clear() {
    const items = <AiChatItem>[];
    state = state.copyWith(items: items);
    _preferencesService.set(PrefKey.userChatHistory, items);
    ref.read(appControllerProvider.notifier).resetUserId();
  }
}
