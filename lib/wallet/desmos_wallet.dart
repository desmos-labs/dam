import 'package:dam/crw-wallet/crw-wallet.dart';
import 'package:flutter/foundation.dart';
import 'package:sprintf/sprintf.dart';

class _AddressesData {
  final List<String> mnemonic;
  final int number;

  _AddressesData(this.mnemonic, this.number);
}

/// Utility class that allows to generate a Desmos Wallet given a
/// mnemonic phrase.
class DesmosWallet {
  static final _path = "m/44'/852'/%d'/0/0";

  static Future<List<String>> generateMnemonic() async {
    return CrwWallet.randomMnemonic().split(' ');
  }

  static String getPath(int index) {
    return sprintf(_path, [index]);
  }

  /// Generates [number] new wallet(s) from the given mnemonic phrase, and
  /// returns the associated Bech32 addresses.
  static Future<List<String>> getAddresses(
    List<String> mnemonic,
    int accountNumber,
  ) {
    return compute(_generateAddresses, _AddressesData(mnemonic, accountNumber));
  }

  static List<String> _generateAddresses(_AddressesData data) {
    return List.generate(data.number, (index) {
      var path = getPath(index);
      final wallet = CrwWallet.fromMnemonic(data.mnemonic.join(' '), path);
      return wallet.getBetch32Address('desmos');
    });
  }
}
