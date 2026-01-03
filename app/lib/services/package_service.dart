import 'package:package_info_plus/package_info_plus.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'package_service.g.dart';

class PackageService {
  PackageInfo? _packageInfo;

  PackageService();

  Future<void> init() async {
    _packageInfo = await PackageInfo.fromPlatform();
  }

  PackageInfo get packageInfo {
    if (_packageInfo == null) {
      throw Exception("PackageInfo not initialized");
    }
    return _packageInfo!;
  }
}

@Riverpod(keepAlive: true)
PackageService packageService(Ref ref) {
  return PackageService();
}

@riverpod
PackageInfo packageInfo(Ref ref) {
  return ref.watch(packageServiceProvider).packageInfo;
}
