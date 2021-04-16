import 'package:alan/alan.dart';

/// Utility class that allows to generate a Desmos Wallet given a
/// mnemonic phrase.
class DesmosWallet {
  static final _path = "44'/852'/0'/0/0";
  static final NetworkInfo _info = NetworkInfo(
    bech32Hrp: 'desmos',
    fullNodeHost: 'localhost',
  );

  static Future<List<String>> generateMnemonic() async {
    return Bip39.generateMnemonic(strength: 256);
  }

  /// Generates a new wallet from the given mnemonic phrase, and returns the
  /// associated Bech32 address.
  /// If there is any error while generating the wallet, [Null] is returned
  /// instead.
  static Future<String?> getAddress(List<String> mnemonic) async {
    try {
      final wallet = Wallet.derive(mnemonic, _info, derivationPath: _path);
      return wallet.bech32Address;
    } catch (e) {
      return null;
    }
  }
}
