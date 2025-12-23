// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tags_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(tagsController)
const tagsControllerProvider = TagsControllerProvider._();

final class TagsControllerProvider
    extends $FunctionalProvider<TagsController, TagsController, TagsController>
    with $Provider<TagsController> {
  const TagsControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'tagsControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$tagsControllerHash();

  @$internal
  @override
  $ProviderElement<TagsController> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  TagsController create(Ref ref) {
    return tagsController(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(TagsController value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<TagsController>(value),
    );
  }
}

String _$tagsControllerHash() => r'cf3c0c9cc25071bd3c07a829765fb86884074464';
