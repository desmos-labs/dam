import 'dart:typed_data';
import 'crw-wallet_stub.dart'
if (dart.library.io) 'package:dam/crw-wallet/native/crw_wallet_native.dart';

/// Represents the native wallet exposed from the Cosmos rust wallet
/// library.
abstract class CrwWallet {

  /// Returns a randomly generated seed phrase.
  static String randomMnemonic() {
    return generateRandomMnemonic();
  }

  /// Generated a new [CrwWallet] using the specified [mnemonic] and [derivationPath].
  static CrwWallet fromMnemonic(String mnemonic, String derivationPath) {
    return walletFromMnemonic(mnemonic, derivationPath);
  }

  /// Returns the public key associated to the wallet.
  Uint8List getPublicKey([bool compressed = true]);

  /// Returns the address associated to the wallet as a Bech32 string.
  String getBetch32Address(String hrp);

  /// Hashes the given [data] with SHA-256, and then sign the hash using the
  /// private key associated with this wallet, returning the signature
  /// encoded as a 64 bytes array.
  Uint8List sign(Uint8List data);

  /// Release the memory owned by the internal native library.
  void destroy();
}
