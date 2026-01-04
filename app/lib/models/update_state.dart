import 'package:freezed_annotation/freezed_annotation.dart';

part 'update_state.freezed.dart';

enum UpdateStatus {
  idle,
  checking,
  available,
  downloading,
  downloaded,
  installing,
  error,
}

@freezed
abstract class UpdateState with _$UpdateState {
  const factory UpdateState({
    @Default(UpdateStatus.idle) UpdateStatus status,
    @Default(0.0) double downloadProgress,
    String? errorMessage,
    String? availableVersion,
  }) = _UpdateState;
}
