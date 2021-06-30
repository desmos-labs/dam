import 'preferences.dart';

Preferences unencryptedPreferences(String name) {
  throw Exception('Unsupported platform');
}

Preferences encryptedPreferences(String name, String key) {
  throw Exception('Unsupported platform');
}

void setPreferencesAppDir(String path) {
  throw Exception('Unsupported platform');
}

bool preferencesExists(String name) {
  throw Exception('Unsupported platform');
}

void preferencesDelete(String name) {
  throw Exception('Unsupported platform');
}
