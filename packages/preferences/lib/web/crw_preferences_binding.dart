@JS()
library cosmos_rust_wallet.packages.crw_preferences.pkg.crw_preferences;

import 'dart:typed_data';

import 'package:js/js.dart';

@JS('crw_wallet.Preferences')
class WasmPreferences {
  external int? getI32(String key);

  external void putI32(String key, int value);

  external String? getStr(String key);

  external void putStr(String key, String value);

  external bool? getBool(String key);

  external void putBool(String key, bool value);

  external Uint8List? getBytes(String key);

  external void putBytes(String key, Uint8List value);

  external void free();

  external void clear();

  external void erase();

  external void save();
}

@JS('crw_preferences.preferences')
external WasmPreferences preferences(String name);

@JS('crw_preferences.encryptedPreferences')
external WasmPreferences encryptedPreferences(String password, String name);

@JS('crw_preferences.exist')
external bool exist(String name);

@JS('crw_preferences.delete')
external void delete(String name);
