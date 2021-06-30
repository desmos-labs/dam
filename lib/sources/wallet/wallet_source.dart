import 'package:dam/sources/secure/secure_source.dart';

class WalletSource extends SecureSource {
  static const _SECURE_SOURCE_NAME = 'wallet';
  static const _MNEMONIC_KEY = 'mnemonic';

  WalletSource() : super(_SECURE_SOURCE_NAME);

  void storeMnemonic(String mnemonic) {
    preferences.putString(_MNEMONIC_KEY, mnemonic);
    preferences.save();
  }

  String? getMnemonic() {
    return preferences.getString(_MNEMONIC_KEY);
  }
}
