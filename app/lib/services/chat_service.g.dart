// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(aiChatService)
const aiChatServiceProvider = AiChatServiceProvider._();

final class AiChatServiceProvider
    extends $FunctionalProvider<AiChatService, AiChatService, AiChatService>
    with $Provider<AiChatService> {
  const AiChatServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'aiChatServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$aiChatServiceHash();

  @$internal
  @override
  $ProviderElement<AiChatService> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  AiChatService create(Ref ref) {
    return aiChatService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AiChatService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AiChatService>(value),
    );
  }
}

String _$aiChatServiceHash() => r'145d0c687ca0a04cfccac204af471ca52472ade8';
