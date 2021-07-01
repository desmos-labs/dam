import 'dart:ffi';
import 'dart:io';
import 'dart:typed_data';

import 'package:dam/preferences/preferences.dart';
import 'package:dam/utils/export.dart';
import 'package:ffi/ffi.dart';
import 'package:flutter/foundation.dart';

import 'crw_preferences_binding.g.dart' as binding;

late final binding.PreferencesBinding _binding = _loadDynamicLib();

binding.PreferencesBinding _loadDynamicLib() {
  DynamicLibrary lib;

  if (Platform.isLinux) {
    if (kDebugMode) {
      lib = DynamicLibrary.open('./linux/lib/libcrw_preferences.so');
    } else {
      lib = DynamicLibrary.process();
    }
  } else if (Platform.isWindows) {
    if (kDebugMode) {
      lib = DynamicLibrary.open('.\\windows\\lib\\crw_preferences.dll');
    } else {
      lib = DynamicLibrary.open('crw_preferences.dll');
    }
  } else if (Platform.isAndroid) {
    lib = DynamicLibrary.open('libcrw_preferences.so');
  } else {
    throw PreferencesException(
        'libcrw_preferences is not compatible with this platform');
  }

  return binding.PreferencesBinding(lib);
}

String _getLastErrorMessage() {
  var error = using((Arena pool) {
    // Get the last error length
    var len = _binding.last_error_length();
    // Allocate the buffer where will be stored the error message on the heap
    var buf = pool.allocate<Int8>(len);

    var error = 'Unknown error';
    // Passe the pointer to the native code to get the message
    if (_binding.error_message_utf8(buf, len) > 0) {
      error = buf.cast<Utf8>().toDartString();
    }

    // Clear the error on the native side
    _binding.clear_last_error();
    return error;
  });

  return error;
}

/// Represents a wallet tha can sign transactions.
class PreferencesNative extends Preferences {
  Pointer<Void> _preferences;

  PreferencesNative._(this._preferences);

  /// Checks that the current instance was not freed with the
  /// destroy method.
  void _assertNotFreed() {
    if (_preferences == nullptr) {
      throw PreferencesException('instance was freed');
    }
  }

  @override
  int? getInt(String key) {
    _assertNotFreed();

    return using((Arena pool) {
      var i32_ptr = pool.allocate<Int32>(4);
      var rc = _binding.preferences_get_i32(
          _preferences, key.toNativeUtf8(allocator: pool).cast(), i32_ptr);
      if (rc == 0) {
        return i32_ptr.value;
      } else if (rc == -1) {
        return null;
      } else {
        throw PreferencesException(_getLastErrorMessage());
      }
    });
  }

  @override
  void putInt(String key, int value) {
    _assertNotFreed();

    using((Arena pool) {
      var rc = _binding.preferences_put_i32(
          _preferences, key.toNativeUtf8(allocator: pool).cast(), value);
      if (rc != 0) {
        throw PreferencesException(_getLastErrorMessage());
      }
    });
  }

  @override
  Uint8List? getBytes(String key) {
    _assertNotFreed();

    return using((Arena pool) {
      var out_buf = pool.allocate<Uint8>(256);
      var native_key = key.toNativeUtf8(allocator: pool).cast<Int8>();
      var rc = _binding.preferences_get_bytes(
          _preferences, native_key, out_buf, 256);

      if (rc > 256) {
        // The buffer was too small reallocate and get the value
        pool.free(out_buf);
        out_buf = pool.allocate<Uint8>(rc);
        rc = _binding.preferences_get_bytes(
            _preferences, native_key, out_buf, rc);
      }

      if (rc == 0) {
        return null;
      } else if (rc < 0) {
        throw PreferencesException(_getLastErrorMessage());
      }

      return Uint8List.fromList(out_buf.asTypedList(rc));
    });
  }

  @override
  void putBytes(String key, Uint8List value) {
    _assertNotFreed();

    return using((Arena pool) {
      var native_key = key.toNativeUtf8(allocator: pool).cast<Int8>();
      var native_binary = value.getPointer(allocator: pool);

      var rc = _binding.preferences_put_bytes(
          _preferences, native_key, native_binary, value.length);

      if (rc != 0) {
        throw PreferencesException(_getLastErrorMessage());
      }
    });
  }

  @override
  bool? getBool(String key) {
    _assertNotFreed();

    return using((Arena pool) {
      var ptr = pool.allocate<Int32>(4);
      var rc = _binding.preferences_get_bool(
          _preferences, key.toNativeUtf8(allocator: pool).cast(), ptr);
      if (rc != 0) {
        throw PreferencesException(_getLastErrorMessage());
      } else {
        return ptr.value != 0;
      }
    });
  }

  @override
  String? getString(String key) {
    _assertNotFreed();

    return using((Arena pool) {
      var out_buf = pool.allocate<Uint8>(256);
      var native_key = key.toNativeUtf8(allocator: pool).cast<Int8>();
      var rc = _binding.preferences_get_string(
          _preferences, native_key, out_buf, 256);

      if (rc > 256) {
        // The buffer was too small reallocate and get the value
        pool.free(out_buf);
        out_buf = pool.allocate<Uint8>(rc);
        rc = _binding.preferences_get_string(
            _preferences, native_key, out_buf, rc);
      }

      if (rc == 0) {
        return null;
      } else if (rc < 0) {
        throw PreferencesException(_getLastErrorMessage());
      }

      return out_buf.cast<Utf8>().toDartString();
    });
  }

  @override
  void putBool(String key, bool value) {
    _assertNotFreed();

    return using((Arena pool) {
      var native_key = key.toNativeUtf8(allocator: pool).cast<Int8>();

      var rc = _binding.preferences_put_bool(
          _preferences, native_key, value ? 1 : 0);

      if (rc != 0) {
        throw PreferencesException(_getLastErrorMessage());
      }
    });
  }

  @override
  void putString(String key, String value) {
    _assertNotFreed();

    return using((Arena pool) {
      var native_key = key.toNativeUtf8(allocator: pool).cast<Int8>();
      var native_str = value.toNativeUtf8(allocator: pool).cast<Int8>();

      var rc =
          _binding.preferences_put_string(_preferences, native_key, native_str);
      if (rc != 0) {
        throw PreferencesException(_getLastErrorMessage());
      }
    });
  }

  @override
  void clear() {
    _assertNotFreed();

    var rc = _binding.preferences_clear(_preferences);
    if (rc != 0) {
      throw PreferencesException(_getLastErrorMessage());
    }
  }

  @override
  void destroy() {
    _assertNotFreed();

    _binding.preferences_free(_preferences);
    _preferences = nullptr;
  }

  @override
  void erase() {
    _assertNotFreed();

    var rc = _binding.preferences_erase(_preferences);
    if (rc != 0) {
      throw PreferencesException(_getLastErrorMessage());
    }
  }

  @override
  void save() {
    var rc = _binding.preferences_save(_preferences);
    if (rc != 0) {
      throw PreferencesException(_getLastErrorMessage());
    }
  }
}

void setPreferencesAppDir(String path) {
  using((Arena arena) {
    _binding
        .set_preferences_app_dir(path.toNativeUtf8(allocator: arena).cast());
  });
}

Preferences unencryptedPreferences(String name) {
  return using((Arena arena) {
    var ptr = _binding.preferences(name.toNativeUtf8(allocator: arena).cast());
    if (ptr == nullptr) {
      throw PreferencesException(_getLastErrorMessage());
    }
    return PreferencesNative._(ptr);
  });
}

Preferences encryptedPreferences(String name, String key) {
  return using((Arena arena) {
    var ptr = _binding.encrypted_preferences(
        name.toNativeUtf8(allocator: arena).cast(),
        key.toNativeUtf8(allocator: arena).cast());
    if (ptr == nullptr) {
      var msg = _getLastErrorMessage();
      if (msg.contains('error while decrypting')) {
        throw InvalidPreferencesPassword();
      }
      throw PreferencesException(_getLastErrorMessage());
    }
    return PreferencesNative._(ptr);
  });
}

bool preferencesExists(String name) {
  return using((Arena arena) {
    var nativeName = name.toNativeUtf8(allocator: arena);
    return _binding.preferences_exist(nativeName.cast()) != 0;
  });
}

void preferencesDelete(String name) {
  using((Arena arena) {
    var nativeName = name.toNativeUtf8(allocator: arena);
    _binding.preferences_delete(nativeName.cast());
  });
}
