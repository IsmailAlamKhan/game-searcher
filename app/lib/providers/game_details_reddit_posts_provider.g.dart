// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_details_reddit_posts_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(gameDetailsRedditPostsController)
const gameDetailsRedditPostsControllerProvider =
    GameDetailsRedditPostsControllerFamily._();

final class GameDetailsRedditPostsControllerProvider
    extends
        $FunctionalProvider<
          GameDetailsRedditPostsController,
          GameDetailsRedditPostsController,
          GameDetailsRedditPostsController
        >
    with $Provider<GameDetailsRedditPostsController> {
  const GameDetailsRedditPostsControllerProvider._({
    required GameDetailsRedditPostsControllerFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'gameDetailsRedditPostsControllerProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$gameDetailsRedditPostsControllerHash();

  @override
  String toString() {
    return r'gameDetailsRedditPostsControllerProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $ProviderElement<GameDetailsRedditPostsController> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  GameDetailsRedditPostsController create(Ref ref) {
    final argument = this.argument as String;
    return gameDetailsRedditPostsController(ref, argument);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GameDetailsRedditPostsController value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GameDetailsRedditPostsController>(
        value,
      ),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is GameDetailsRedditPostsControllerProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$gameDetailsRedditPostsControllerHash() =>
    r'4e1b76b8d93714a1e2a56e0e09924d43ee399ee1';

final class GameDetailsRedditPostsControllerFamily extends $Family
    with $FunctionalFamilyOverride<GameDetailsRedditPostsController, String> {
  const GameDetailsRedditPostsControllerFamily._()
    : super(
        retry: null,
        name: r'gameDetailsRedditPostsControllerProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  GameDetailsRedditPostsControllerProvider call(String gameId) =>
      GameDetailsRedditPostsControllerProvider._(argument: gameId, from: this);

  @override
  String toString() => r'gameDetailsRedditPostsControllerProvider';
}
