// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_details_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(GameDetails)
const gameDetailsProvider = GameDetailsFamily._();

final class GameDetailsProvider
    extends $AsyncNotifierProvider<GameDetails, GameRecord> {
  const GameDetailsProvider._({
    required GameDetailsFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'gameDetailsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$gameDetailsHash();

  @override
  String toString() {
    return r'gameDetailsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  GameDetails create() => GameDetails();

  @override
  bool operator ==(Object other) {
    return other is GameDetailsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$gameDetailsHash() => r'4f24085ab17db4daf2a7463999603eb6be966eeb';

final class GameDetailsFamily extends $Family
    with
        $ClassFamilyOverride<
          GameDetails,
          AsyncValue<GameRecord>,
          GameRecord,
          FutureOr<GameRecord>,
          String
        > {
  const GameDetailsFamily._()
    : super(
        retry: null,
        name: r'gameDetailsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  GameDetailsProvider call(String id) =>
      GameDetailsProvider._(argument: id, from: this);

  @override
  String toString() => r'gameDetailsProvider';
}

abstract class _$GameDetails extends $AsyncNotifier<GameRecord> {
  late final _$args = ref.$arg as String;
  String get id => _$args;

  FutureOr<GameRecord> build(String id);
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build(_$args);
    final ref = this.ref as $Ref<AsyncValue<GameRecord>, GameRecord>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<GameRecord>, GameRecord>,
              AsyncValue<GameRecord>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
