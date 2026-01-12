// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dio.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(dio)
const dioProvider = DioFamily._();

final class DioProvider extends $FunctionalProvider<Dio, Dio, Dio>
    with $Provider<Dio> {
  const DioProvider._({
    required DioFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'dioProvider',
         isAutoDispose: false,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$dioHash();

  @override
  String toString() {
    return r'dioProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $ProviderElement<Dio> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  Dio create(Ref ref) {
    final argument = this.argument as String;
    return dio(ref, baseUrl: argument);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Dio value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Dio>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is DioProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$dioHash() => r'14a268baf82dfcc6751107272034604025bd55db';

final class DioFamily extends $Family
    with $FunctionalFamilyOverride<Dio, String> {
  const DioFamily._()
    : super(
        retry: null,
        name: r'dioProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: false,
      );

  DioProvider call({String baseUrl = ''}) =>
      DioProvider._(argument: baseUrl, from: this);

  @override
  String toString() => r'dioProvider';
}

@ProviderFor(engineDio)
const engineDioProvider = EngineDioProvider._();

final class EngineDioProvider extends $FunctionalProvider<Dio, Dio, Dio>
    with $Provider<Dio> {
  const EngineDioProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'engineDioProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$engineDioHash();

  @$internal
  @override
  $ProviderElement<Dio> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  Dio create(Ref ref) {
    return engineDio(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Dio value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Dio>(value),
    );
  }
}

String _$engineDioHash() => r'a4172f74dd600d144af20f6db5d444c17ce3b80c';

@ProviderFor(webhookDio)
const webhookDioProvider = WebhookDioFamily._();

final class WebhookDioProvider extends $FunctionalProvider<Dio, Dio, Dio>
    with $Provider<Dio> {
  const WebhookDioProvider._({
    required WebhookDioFamily super.from,
    required bool super.argument,
  }) : super(
         retry: null,
         name: r'webhookDioProvider',
         isAutoDispose: false,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$webhookDioHash();

  @override
  String toString() {
    return r'webhookDioProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $ProviderElement<Dio> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  Dio create(Ref ref) {
    final argument = this.argument as bool;
    return webhookDio(ref, isTest: argument);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Dio value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Dio>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is WebhookDioProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$webhookDioHash() => r'ca3f88b15c3288af0c81ba70fea39e3893102067';

final class WebhookDioFamily extends $Family
    with $FunctionalFamilyOverride<Dio, bool> {
  const WebhookDioFamily._()
    : super(
        retry: null,
        name: r'webhookDioProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: false,
      );

  WebhookDioProvider call({bool isTest = false}) =>
      WebhookDioProvider._(argument: isTest, from: this);

  @override
  String toString() => r'webhookDioProvider';
}

@ProviderFor(githubDio)
const githubDioProvider = GithubDioProvider._();

final class GithubDioProvider extends $FunctionalProvider<Dio, Dio, Dio>
    with $Provider<Dio> {
  const GithubDioProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'githubDioProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$githubDioHash();

  @$internal
  @override
  $ProviderElement<Dio> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  Dio create(Ref ref) {
    return githubDio(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Dio value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Dio>(value),
    );
  }
}

String _$githubDioHash() => r'b79622bdc3f77df6baca0a58aea4c25b0319ba64';
