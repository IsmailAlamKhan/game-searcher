// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'package_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(packageService)
const packageServiceProvider = PackageServiceProvider._();

final class PackageServiceProvider
    extends $FunctionalProvider<PackageService, PackageService, PackageService>
    with $Provider<PackageService> {
  const PackageServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'packageServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$packageServiceHash();

  @$internal
  @override
  $ProviderElement<PackageService> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  PackageService create(Ref ref) {
    return packageService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PackageService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PackageService>(value),
    );
  }
}

String _$packageServiceHash() => r'3fa15c462e981610becb7a9cb8db08ed2b363666';

@ProviderFor(packageInfo)
const packageInfoProvider = PackageInfoProvider._();

final class PackageInfoProvider
    extends $FunctionalProvider<PackageInfo, PackageInfo, PackageInfo>
    with $Provider<PackageInfo> {
  const PackageInfoProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'packageInfoProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$packageInfoHash();

  @$internal
  @override
  $ProviderElement<PackageInfo> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  PackageInfo create(Ref ref) {
    return packageInfo(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PackageInfo value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PackageInfo>(value),
    );
  }
}

String _$packageInfoHash() => r'4f5b85a72ef16ceadd49da6fc5be403a3d14a4c0';
