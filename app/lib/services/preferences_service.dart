import 'dart:ui';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/get_color_from_int.dart';

part 'preferences_service.g.dart';

@Riverpod(keepAlive: true)
PreferencesService preferencesService(Ref ref) {
  return PreferencesService();
}

enum PrefKey {
  autoUpdateEnabled('auto_update_enabled'),
  lastUpdateCheck('last_update_check'),
  updateCheckInterval('update_check_interval'),
  autoDownloadEnabled('auto_download_enabled'),
  downloadedUpdatePath('downloaded_update_path'),
  downloadedUpdateVersion('downloaded_update_version'),
  themeMode('theme_mode'),
  themeSeedColor('theme_seed_color'),
  adultContentBlur('adult_content_blur'),
  ;

  final String key;
  const PrefKey(this.key);
}

class PreferencesService {
  SharedPreferences? _prefs;

  SharedPreferences get _sharedPref {
    if (_prefs == null) {
      throw StateError('PreferencesService not initialized');
    }
    return _prefs!;
  }

  PreferencesService();

  Future<void> init() async {
    final prefs = await SharedPreferences.getInstance();
    _prefs = prefs;
  }

  T? get<T>(PrefKey key, {T? defaultValue}) {
    final value = _sharedPref.get(key.key);
    if (value == null) return defaultValue;
    if (T == Color) {
      return getColorFromInt(value as int) as T;
    } else if (T == Duration) {
      return Duration(milliseconds: value as int) as T;
    } else if (T == DateTime) {
      return DateTime.fromMillisecondsSinceEpoch(value as int) as T;
    }
    return value as T;
  }

  void set<T>(PrefKey key, T value) {
    if (T == String) {
      _sharedPref.setString(key.key, value as String);
    } else if (T == int) {
      _sharedPref.setInt(key.key, value as int);
    } else if (T == double) {
      _sharedPref.setDouble(key.key, value as double);
    } else if (T == bool) {
      _sharedPref.setBool(key.key, value as bool);
    } else if (T == List<String>) {
      _sharedPref.setStringList(key.key, value as List<String>);
    } else if (T == Color) {
      final _value = (value as Color).toARGB32();
      _sharedPref.setInt(key.key, _value);
    } else if (T == Duration) {
      _sharedPref.setInt(key.key, (value as Duration).inMilliseconds);
    } else if (T == DateTime) {
      _sharedPref.setInt(key.key, (value as DateTime).millisecondsSinceEpoch);
    } else {
      throw UnsupportedError('Unsupported type: $T');
    }
  }

  void remove(PrefKey key) {
    _sharedPref.remove(key.key);
  }
}
