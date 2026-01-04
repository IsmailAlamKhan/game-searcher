// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(UpdateController)
const updateControllerProvider = UpdateControllerProvider._();

final class UpdateControllerProvider
    extends $NotifierProvider<UpdateController, UpdateState> {
  const UpdateControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'updateControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$updateControllerHash();

  @$internal
  @override
  UpdateController create() => UpdateController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(UpdateState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<UpdateState>(value),
    );
  }
}

String _$updateControllerHash() => r'f04f3a380a6af614d6455102e0bea88b54980753';

abstract class _$UpdateController extends $Notifier<UpdateState> {
  UpdateState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<UpdateState, UpdateState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<UpdateState, UpdateState>,
              UpdateState,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

@ProviderFor(LatestUpdate)
const latestUpdateProvider = LatestUpdateProvider._();

final class LatestUpdateProvider
    extends $NotifierProvider<LatestUpdate, Update?> {
  const LatestUpdateProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'latestUpdateProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$latestUpdateHash();

  @$internal
  @override
  LatestUpdate create() => LatestUpdate();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Update? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Update?>(value),
    );
  }
}

String _$latestUpdateHash() => r'105a615d52b4be8274782bc1223cab4f5e4dd4ff';

abstract class _$LatestUpdate extends $Notifier<Update?> {
  Update? build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<Update?, Update?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<Update?, Update?>,
              Update?,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
