@JS()
library cosmos_rust_wallet.packages.crw_wallet.pkg.crw_wallet;

import 'dart:js';
import 'package:js/js.dart';

@JS('crw_wallet.randomMnemonic')
external String randomMnemonic();

@JS('crw_wallet.MnemonicWallet')
class MnemonicWallet {
  external void free();
  external factory MnemonicWallet(String mnemonic, String derivation_path);
  external void setDerivationPath(String new_derivation_path);
  external String getBech32Address(String hrp);
  external JsArray<int> sign(JsArray<int> data);
  external JsArray<int> getPubKey(bool compressed);
}
