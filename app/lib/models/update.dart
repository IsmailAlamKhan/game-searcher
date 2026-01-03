import 'package:freezed_annotation/freezed_annotation.dart';

part 'update.freezed.dart';

@freezed
abstract class Update with _$Update {
  const factory Update({required String version, required String changelog}) = _Update;
}
