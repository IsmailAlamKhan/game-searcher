// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tags_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(TagsController)
const tagsControllerProvider = TagsControllerProvider._();

final class TagsControllerProvider
    extends $AsyncNotifierProvider<TagsController, List<Tag>> {
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
  TagsController create() => TagsController();
}

String _$tagsControllerHash() => r'0ee6f5debe83bf328a27d556459216d85cb44e90';

abstract class _$TagsController extends $AsyncNotifier<List<Tag>> {
  FutureOr<List<Tag>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<List<Tag>>, List<Tag>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<Tag>>, List<Tag>>,
              AsyncValue<List<Tag>>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
