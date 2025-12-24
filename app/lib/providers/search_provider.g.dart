// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(searchController)
const searchControllerProvider = SearchControllerProvider._();

final class SearchControllerProvider
    extends
        $FunctionalProvider<
          SearchController,
          SearchController,
          SearchController
        >
    with $Provider<SearchController> {
  const SearchControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'searchControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$searchControllerHash();

  @$internal
  @override
  $ProviderElement<SearchController> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  SearchController create(Ref ref) {
    return searchController(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SearchController value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SearchController>(value),
    );
  }
}

String _$searchControllerHash() => r'c5a9ec09f0ffa97b5e10035cdb7bd99c1f711ca0';
