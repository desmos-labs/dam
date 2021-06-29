import 'package:dam/preferences/preferences.dart';
import 'package:meta/meta.dart';

/// Source that can be used to securely store data into the device storage.
/// The data stored using this source are saved encrypted into the
/// device storage.
abstract class SecureSource {
  /// The source name, MUST be unique for every source.
  final String name;
  /// Reference to the crw-preference library object.
  Preferences? _preferences;

  SecureSource(this.name);

  /// Deletes the data of [SecureSource] that has been saved into the device disk.
  static void deleteSource(String name) {
    return Preferences.delete(name);
  }

  /// Resets the source password with the new one.
  /// NOTE: All the data inside the source will be deleted and the source will
  /// be reinitialized with the new password.
  void initEmpty(String password) {
    if(!isLocked()) {
      preferences.erase();
      preferences.destroy();
    }
    Preferences.delete(name);
    // Unlock with the new password.
    unlock(password);
  }

  /// Check if exist a secure source with the provided name into the device storage.
  bool isInitialized() {
    return Preferences.exist(name);
  }

  /// Checks if the source is locked.
  bool isLocked() {
    return _preferences == null;
  }

  /// Unlocks the source.
  void unlock(String password) {
    try {
      _preferences = Preferences.encrypted(name, password);
    } on InvalidPreferencesPassword {
      throw SecureSourceInvalidPassword();
    } on PreferencesException catch (e) {
      throw SecureSourceException(e.message);
    }
  }

  /// Locks the source saving all the data into the device storage.
  void lock() {
    if (_preferences != null) {
      _preferences!.save();
      _preferences!.destroy();
      _preferences = null;
    }
  }

  /// Gets the unlocked secure storage that can be used to store the data.
  /// If the source is locked will be raised a [SecureSourceLocked] exception.
  @protected
  Preferences get preferences {
    if (_preferences == null) {
      throw SecureSourceLocked();
    }

    return _preferences!;
  }
}

class SecureSourceException implements Exception {
  final String message;

  SecureSourceException(this.message);
}

class SecureSourceLocked extends SecureSourceException {
  SecureSourceLocked() : super('the secure storage is locked');
}

class SecureSourceInvalidPassword extends SecureSourceException {
  SecureSourceInvalidPassword() : super('invalid password');
}
