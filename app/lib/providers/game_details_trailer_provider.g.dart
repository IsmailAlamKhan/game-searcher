// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_details_trailer_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(gameDetailsTrailerController)
const gameDetailsTrailerControllerProvider =
    GameDetailsTrailerControllerFamily._();

final class GameDetailsTrailerControllerProvider
    extends
        $FunctionalProvider<
          GameDetailsTrailerController,
          GameDetailsTrailerController,
          GameDetailsTrailerController
        >
    with $Provider<GameDetailsTrailerController> {
  const GameDetailsTrailerControllerProvider._({
    required GameDetailsTrailerControllerFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'gameDetailsTrailerControllerProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$gameDetailsTrailerControllerHash();

  @override
  String toString() {
    return r'gameDetailsTrailerControllerProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $ProviderElement<GameDetailsTrailerController> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  GameDetailsTrailerController create(Ref ref) {
    final argument = this.argument as String;
    return gameDetailsTrailerController(ref, argument);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GameDetailsTrailerController value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GameDetailsTrailerController>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is GameDetailsTrailerControllerProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$gameDetailsTrailerControllerHash() =>
    r'b5389aff839601ef011037c45196d897b9847849';

final class GameDetailsTrailerControllerFamily extends $Family
    with $FunctionalFamilyOverride<GameDetailsTrailerController, String> {
  const GameDetailsTrailerControllerFamily._()
    : super(
        retry: null,
        name: r'gameDetailsTrailerControllerProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  GameDetailsTrailerControllerProvider call(String gameId) =>
      GameDetailsTrailerControllerProvider._(argument: gameId, from: this);

  @override
  String toString() => r'gameDetailsTrailerControllerProvider';
}
