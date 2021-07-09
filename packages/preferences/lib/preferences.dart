import 'dart:typed_data';

import 'preferences_stub.dart'
    if (dart.library.js) 'web/crw_preferences_wasm.dart'
    if (dart.library.io) 'native/crw_preferences_native.dart';

/// Abstract class that represents the Preference trait exposed from the
/// crw-preferences library.
abstract class Preferences {
  /// Sets the application [dir] where will be stored the preferences.
  /// The [dir] should be just a name for windows, mac, and linux. The complete
  /// directory path on android.
  ///
  /// This function is available only outside the browser.
  static void setAppDir(String dir) {
    setPreferencesAppDir(dir);
  }

  /// Creates a new preferences or reload the existing preferences
  /// with the same name.
  ///
  /// Throw a [PreferencesException] in case of error.
  static Preferences unencrypted(String name) {
    return unencryptedPreferences(name);
  }

  /// Creates a new encrypted preferences or reload the existing preferences
  /// with the same name.
  ///
  /// Throws a [InvalidPreferencesPassword] if the provided password is invalid.
  /// Throw a [PreferencesException] in case of error.
  static Preferences encrypted(String name, String key) {
    return encryptedPreferences(name, key);
  }

  /// Check if exist a preference with the provided name.
  static bool exist(String name) {
    return preferencesExists(name);
  }

  /// Deletes a preferences with the provided name from the device storage.1
  static void delete(String name) {
    preferencesDelete(name);
  }

  /// Gets a int value from the preferences.
  int? getInt(String key);

  /// Puts a the int value into the preferences.
  void putInt(String key, int value);

  /// Gets a string value from the preferences.
  String? getString(String key);

  void putString(String key, String value);

  /// Gets a bool value from the preferences.
  bool? getBool(String key);

  void putBool(String key, bool value);

  /// Gets an array of bytes from the preferences.
  Uint8List? getBytes(String key);

  void putBytes(String key, Uint8List value);

  /// Clear all the value from the preferences.
  void clear();

  /// Save the preferences to the device disk.
  void save();

  /// Delete all the values from the preferences and also the
  /// data stored on the device disk.
  void erase();

  /// Release the memory owned by the native library.
  void destroy();
}

class PreferencesException implements Exception {
  String message;

  PreferencesException(this.message);
}

class InvalidPreferencesPassword extends PreferencesException {
  InvalidPreferencesPassword() : super('invalid password');
}
