import 'dart:js';
import 'dart:typed_data';
import 'package:dam/crw-wallet/crw-wallet.dart';
import 'crw_wallet_binding.dart';

class CrwWalletWasm extends CrwWallet {

  MnemonicWallet _wallet;

  CrwWalletWasm._(this._wallet);

  factory CrwWalletWasm.fromMnemonic(String mnemonic, String derivation_path) {
    return CrwWalletWasm._(MnemonicWallet(mnemonic, derivation_path));
  }

  @override
  Uint8List getPublicKey([bool compressed = true]) {
    var js_sign = _wallet.getPubKey(compressed);
    return Uint8List.fromList(js_sign);
  }

  @override
  String getBetch32Address(String hrp) {
    return _wallet.getBech32Address(hrp);
  }

  @override
  Uint8List sign(Uint8List data) {
    var js_array = JsArray<int>.from(data);
    var js_sign = _wallet.sign(js_array);
    return Uint8List.fromList(js_sign);
  }

  @override
  void destroy() {
    _wallet.free();
  }

}

String generateRandomMnemonic() {
  return randomMnemonic();
}

CrwWallet walletFromMnemonic(String mnemonic, String derivation_path) {
  return CrwWalletWasm.fromMnemonic(mnemonic, derivation_path);
}

