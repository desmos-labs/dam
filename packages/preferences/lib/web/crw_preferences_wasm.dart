import 'dart:typed_data';

import '../preferences.dart';
import 'crw_preferences_binding.dart' as wasm;

class PreferencesWasm extends Preferences {
  wasm.WasmPreferences? _preferences;

  PreferencesWasm._(this._preferences);

  @override
  bool? getBool(String key) {
    return _preferences!.getBool(key);
  }

  @override
  Uint8List? getBytes(String key) {
    return _preferences!.getBytes(key);
  }

  @override
  int? getInt(String key) {
    return _preferences!.getI32(key);
  }

  @override
  String? getString(String key) {
    return _preferences!.getStr(key);
  }

  @override
  void putBool(String key, bool value) {
    _preferences!.putBool(key, value);
  }

  @override
  void putBytes(String key, Uint8List value) {
    _preferences!.putBytes(key, value);
  }

  @override
  void putInt(String key, int value) {
    _preferences!.putI32(key, value);
  }

  @override
  void putString(String key, String value) {
    _preferences!.putStr(key, value);
  }

  @override
  void save() {
    _preferences!.save();
  }

  @override
  void clear() {
    _preferences!.clear();
  }

  @override
  void erase() {
    _preferences!.erase();
  }

  @override
  void destroy() {
    _preferences!.free();
    _preferences = null;
  }
}

Preferences unencryptedPreferences(String name) {
  return PreferencesWasm._(wasm.preferences(name));
}

Preferences encryptedPreferences(String name, String key) {
  return PreferencesWasm._(wasm.encryptedPreferences(key, name));
}

void setPreferencesAppDir(String path) {
  throw Exception('Unsupported platform');
}

bool preferencesExists(String name) {
  return wasm.exist(name);
}

void preferencesDelete(String name) {
  wasm.delete(name);
}
