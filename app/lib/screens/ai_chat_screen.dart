import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:markdown_widget/markdown_widget.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

import '../models/ai_chat_response.dart';
import '../providers/ai_chat_provider.dart';

class AiChatScreen extends HookConsumerWidget {
  const AiChatScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(aiChatControllerProvider);
    final tec = useTextEditingController();
    final scrollController = useScrollController();
    final controller = ref.read(aiChatControllerProvider.notifier);
    final theme = Theme.of(context);

    // Auto-scroll to bottom when new messages arrive or loading state changes
    useEffect(() {
      if (scrollController.hasClients) {
        Future.delayed(const Duration(milliseconds: 100), () {
          if (scrollController.hasClients) {
            scrollController.animateTo(
              scrollController.position.maxScrollExtent,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOut,
            );
          }
        });
      }
      return null;
    }, [state.items.length, state.isLoading]);

    return Scaffold(
      appBar: AppBar(
        title: const Text('AI Chat'),
        elevation: 0,
        backgroundColor: theme.colorScheme.surface,
        centerTitle: true,
        actions: [
          if (kDebugMode)
            IconButton(
              icon: const Icon(Icons.clear_all),
              onPressed: () => controller.clear(),
            ),
        ],
      ),
      body: Column(
        children: [
          if (state.initialLoading)
            const Expanded(child: InitialLoadingView())
          else if (state.items.isEmpty)
            const Expanded(child: EmptyChatView())
          else
            Expanded(
              child: ListView.builder(
                controller: scrollController,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                itemCount: state.items.length + (state.isLoading ? 1 : 0),
                itemBuilder: (context, index) {
                  if (index == state.items.length) {
                    return const BotTypingIndicator();
                  }
                  final item = state.items[index];
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      if (item.query != null) UserMessageBubble(message: item.query!),
                      if (item.response != null) BotMessageBubble(response: item.response!),
                      if (item.error != null)
                        ErrorMessageBubble(
                          error: item.error!,
                          onRetry: () => controller.sendMessage(item.query ?? ""),
                        ),
                      const SizedBox(height: 16),
                    ],
                  );
                },
              ),
            ),
          _ChatInputField(
            controller: tec,
            isLoading: state.isLoading,
            onSend: (val) {
              controller.sendMessage(val);
              tec.clear();
            },
          ),
        ],
      ),
    );
  }
}

class UserMessageBubble extends StatelessWidget {
  final String message;
  const UserMessageBubble({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Align(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: const EdgeInsets.only(left: 40, bottom: 4),
        child: Card(
          margin: EdgeInsets.zero,
          elevation: 2,
          color: theme.colorScheme.primary,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(4),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Text(
              message,
              style: theme.textTheme.bodyLarge?.copyWith(
                color: theme.colorScheme.onPrimary,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class BotMessageBubble extends StatelessWidget {
  final AiChatResponse response;
  const BotMessageBubble({super.key, required this.response});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    var results = response.results.toList();
    results.sort((a, b) => b.rating!.compareTo(a.rating!));
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.only(right: 40),
            child: Card(
              margin: EdgeInsets.zero,
              elevation: 1,
              color: theme.colorScheme.surfaceContainerHighest,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                  bottomLeft: Radius.circular(4),
                  bottomRight: Radius.circular(20),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: MarkdownWidget(
                  data: response.message,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  config: MarkdownConfig(
                    configs: [
                      PConfig(
                        textStyle:
                            theme.textTheme.bodyLarge?.copyWith(
                              color: theme.colorScheme.onSurfaceVariant,
                            ) ??
                            const TextStyle(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        if (results.isNotEmpty) ...[
          const SizedBox(height: 12),
          SizedBox(
            height: 280,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: results.length,
              padding: const EdgeInsets.symmetric(horizontal: 4),
              itemBuilder: (context, index) {
                return AiGameCard(game: results[index]);
              },
            ),
          ),
        ],
      ],
    );
  }
}

class AiGameCard extends StatelessWidget {
  final Game game;
  const AiGameCard({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: 200,
      margin: const EdgeInsets.only(right: 12, bottom: 8, top: 4),
      child: Card(
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 4,
        child: InkWell(
          onTap: () => context.push('/details/${game.id}'),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  if (game.backgroundImage != null)
                    CachedNetworkImage(
                      imageUrl: game.backgroundImage!,
                      height: 120,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    )
                  else
                    Container(height: 120, color: theme.colorScheme.secondaryContainer),
                  // PositionResultBadge(compatibility: game.compatibility),
                ],
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        game.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 4),
                      Expanded(
                        child: Text(
                          game.reason,
                          maxLines: 4,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PositionResultBadge extends StatelessWidget {
  final String compatibility;
  const PositionResultBadge({super.key, required this.compatibility});

  @override
  Widget build(BuildContext context) {
    Color color;
    IconData icon;

    final lower = compatibility.toLowerCase();
    if (lower.contains('perfect') || lower.contains('great') || lower.contains('runs')) {
      color = Colors.green;
      icon = Icons.check_circle;
    } else if (lower.contains('struggle') || lower.contains('medium') || lower.contains('low')) {
      color = Colors.orange;
      icon = Icons.warning;
    } else {
      color = Colors.red;
      icon = Icons.error;
    }

    return Positioned(
      top: 8,
      right: 8,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.9),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 12, color: Colors.white),
            const SizedBox(width: 4),
            Text(
              compatibility.split(' ').first,
              style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}

class ErrorMessageBubble extends StatelessWidget {
  final String error;
  final VoidCallback onRetry;
  const ErrorMessageBubble({super.key, required this.error, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(right: 40),
        child: Card(
          margin: EdgeInsets.zero,
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: BorderSide(color: theme.colorScheme.error),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.error_outline, color: theme.colorScheme.error, size: 20),
                    const SizedBox(width: 8),
                    Text(
                      'Something went wrong',
                      style: theme.textTheme.titleSmall?.copyWith(
                        color: theme.colorScheme.error,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  error,
                  style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onErrorContainer),
                ),
                const SizedBox(height: 12),
                TextButton.icon(
                  onPressed: onRetry,
                  icon: const Icon(Icons.refresh, size: 18),
                  label: const Text('Try Again'),
                  style: TextButton.styleFrom(
                    foregroundColor: theme.colorScheme.error,
                    backgroundColor: theme.colorScheme.error.withValues(alpha: 0.1),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class BotTypingIndicator extends HookWidget {
  const BotTypingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final animationController = useAnimationController(
      duration: const Duration(milliseconds: 1000),
    )..repeat();

    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: theme.colorScheme.surfaceContainerHighest,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
            bottomLeft: Radius.circular(4),
            bottomRight: Radius.circular(20),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(3, (index) {
            return AnimatedBuilder(
              animation: animationController,
              builder: (context, child) {
                final delay = index * 0.2;
                final value = (animationController.value - delay).clamp(0.0, 1.0);
                final opacity = (1.0 - (value - 0.5).abs() * 2).clamp(0.2, 1.0);
                return Container(
                  width: 8,
                  height: 8,
                  margin: const EdgeInsets.symmetric(horizontal: 2),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.onSurfaceVariant.withValues(alpha: opacity),
                    shape: BoxShape.circle,
                  ),
                );
              },
            );
          }),
        ),
      ),
    );
  }
}

class InitialLoadingView extends StatelessWidget {
  const InitialLoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: 5,
      itemBuilder: (context, index) {
        final isLeft = index % 2 == 0;
        return Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: Shimmer(
            duration: const Duration(seconds: 2),
            child: Align(
              alignment: isLeft ? Alignment.centerLeft : Alignment.centerRight,
              child: Container(
                width: MediaQuery.of(context).size.width * 0.6,
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class EmptyChatView extends StatelessWidget {
  const EmptyChatView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(FontAwesomeIcons.robot, size: 64, color: theme.colorScheme.primary.withValues(alpha: 0.2)),
          const SizedBox(height: 24),
          Text(
            'How can I help you today?',
            style: theme.textTheme.headlineSmall?.copyWith(
              color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Ask me for game recommendations or technical help!',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurface.withValues(alpha: 0.4),
            ),
          ),
        ],
      ),
    );
  }
}

class _ChatInputField extends StatelessWidget {
  final TextEditingController controller;
  final bool isLoading;
  final Function(String) onSend;

  const _ChatInputField({
    required this.controller,
    required this.isLoading,
    required this.onSend,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            offset: const Offset(0, -4),
            blurRadius: 10,
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: ConstrainedBox(
                constraints: const BoxConstraints(minHeight: 60),
                child: Card(
                  margin: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: TextField(
                        maxLines: 5,
                        minLines: 1,
                        controller: controller,
                        decoration: const InputDecoration.collapsed(
                          hintText: 'Type a message...',
                        ),
                        onSubmitted: (val) {
                          if (val.trim().isNotEmpty && !isLoading) {
                            onSend(val);
                          }
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            SizedBox.square(
              dimension: 50,
              child: Card(
                shape: const CircleBorder(),
                color: theme.colorScheme.primary,
                clipBehavior: Clip.antiAlias,
                margin: EdgeInsets.zero,

                child: InkWell(
                  onTap: () {
                    if (controller.text.trim().isNotEmpty && !isLoading) {
                      onSend(controller.text);
                    }
                  },
                  child: isLoading
                      ? Center(
                          child: SizedBox.square(
                            dimension: 24,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: theme.colorScheme.onPrimary,
                            ),
                          ),
                        )
                      : Icon(Icons.send, color: theme.colorScheme.onPrimary, size: 24),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
