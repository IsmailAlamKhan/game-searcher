// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_details_gallery_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(gameDetailsGalleryController)
const gameDetailsGalleryControllerProvider =
    GameDetailsGalleryControllerFamily._();

final class GameDetailsGalleryControllerProvider
    extends
        $FunctionalProvider<
          GameDetailsGalleryController,
          GameDetailsGalleryController,
          GameDetailsGalleryController
        >
    with $Provider<GameDetailsGalleryController> {
  const GameDetailsGalleryControllerProvider._({
    required GameDetailsGalleryControllerFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'gameDetailsGalleryControllerProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$gameDetailsGalleryControllerHash();

  @override
  String toString() {
    return r'gameDetailsGalleryControllerProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $ProviderElement<GameDetailsGalleryController> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  GameDetailsGalleryController create(Ref ref) {
    final argument = this.argument as String;
    return gameDetailsGalleryController(ref, argument);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GameDetailsGalleryController value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GameDetailsGalleryController>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is GameDetailsGalleryControllerProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$gameDetailsGalleryControllerHash() =>
    r'0717159ed9034f49da122e0b139f56d14bc1a3b8';

final class GameDetailsGalleryControllerFamily extends $Family
    with $FunctionalFamilyOverride<GameDetailsGalleryController, String> {
  const GameDetailsGalleryControllerFamily._()
    : super(
        retry: null,
        name: r'gameDetailsGalleryControllerProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  GameDetailsGalleryControllerProvider call(String gameId) =>
      GameDetailsGalleryControllerProvider._(argument: gameId, from: this);

  @override
  String toString() => r'gameDetailsGalleryControllerProvider';
}
