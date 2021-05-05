import 'dart:ffi';
import 'dart:io';
import 'dart:typed_data';
import 'package:dam/crw-wallet/crw-wallet.dart';
import 'package:ffi/ffi.dart';
import 'package:dam/util/export.dart';
import 'package:flutter/foundation.dart';
import 'crw_wallet_binding.dart' as crw;

late final crw.WalletBinding _walletBinding = _loadDynamicLib();

crw.WalletBinding _loadDynamicLib() {
  DynamicLibrary lib;

  if (Platform.isLinux) {
    if (kDebugMode) {
      lib = DynamicLibrary.open('./linux/lib/libcrw_wallet.so');
    }
    else {
      lib = DynamicLibrary.process();
    }
  }
  else if (Platform.isAndroid) {
    lib = DynamicLibrary.open('libcrw_wallet.so');
  }
  else {
    throw Exception('libcrw is not compatible with this platform');
  }

  return crw.WalletBinding(lib);
}

/// Represents a wallet tha can sign transactions.
class CrwWalletNative extends CrwWallet {
  Pointer<crw.wallet> _wallet;

  CrwWalletNative._(this._wallet);

  static String _getLastErrorMessage() {
    var error = using((Pool pool) {
      // Get the last error length
      var len = _walletBinding.last_error_length();
      // Allocate the buffer where will be stored the error message on the heap
      var buf = pool.allocate<Int8>(len);

      var error = 'Unknown error';
      // Passe the pointer to the native code to get the message
      if (_walletBinding.error_message_utf8(buf, len) > 0) {
        error = buf.cast<Utf8>().toDartString();
      }

      // Clear the error on the native side
      _walletBinding.clear_last_error();
      return error;
    });

    return error;
  }

  factory CrwWalletNative.fromMnemonic(
      String mnemonic,
      String derivationPath
  ) {
    var utf8_mnemonic = mnemonic.toNativeUtf8();
    var utf8_path = derivationPath.toNativeUtf8();
    var native_wallet = _walletBinding.wallet_from_mnemonic(utf8_mnemonic.cast(), utf8_path.cast());

    if (native_wallet == nullptr) {
      throw Exception(_getLastErrorMessage());
    }

    return CrwWalletNative._(native_wallet);
  }

  @override
  Uint8List getPublicKey([bool compressed = true]) {
    if (_wallet == nullptr) {
      throw Exception('This wallet was destroyed');
    }

    return using((Pool pool) {
      final KEY_SIZE = 65;
      var out_buf = pool.allocate<Uint8>(KEY_SIZE);

      var key_len = _walletBinding.wallet_get_public_key(_wallet, compressed ? 1 : 0, out_buf, KEY_SIZE);
      if (key_len > 0) {
        return Uint8List.fromList(out_buf.asTypedList(key_len));
      }
      else {
        throw Exception('Cant get pubkey from wallet error: $key_len');
      }
    });
  }

  @override
  String getBetch32Address(String hrp) {
    if (_wallet == nullptr) {
      throw Exception('This wallet was freed');
    }

    // Gets the address from the native code
    var utf8_address = _walletBinding.wallet_get_bech32_address(_wallet, hrp.toNativeUtf8().cast());

    if (utf8_address == nullptr) {
      throw Exception(_getLastErrorMessage());
    }
    // Convert the native string to dart
    var string = utf8_address.cast<Utf8>().toDartString();
    // Free the native string since is not managed from the dart GC.
    _walletBinding.cstring_free(utf8_address);

    return string;
  }

  @override
  Uint8List sign(Uint8List data) {
    if (_wallet == nullptr) {
      throw Exception('This wallet was freed');
    }

    var signature = using((Pool pool) {
      // Move the data to a buffer that can be accessed from the native code.
      var data_to_sign_ptr = data.getPointer(allocator: pool);

      var signature_ptr = _walletBinding.wallet_sign(_wallet, data_to_sign_ptr, data.length);

      if (signature_ptr == nullptr) {
        throw Exception(_getLastErrorMessage());
      }
      // Copy the native signature into a Uint8List managed by the dart GC.
      var signature = Uint8List.fromList(signature_ptr.ref.data.asTypedList(signature_ptr.ref.len));

      // Free the native signature
      _walletBinding.wallet_sign_free(signature_ptr);

      return signature;
    });

    return signature;
  }

  @override
  void destroy() {
    if (_wallet == nullptr) {
      return;
    }

    // Free the native wallet reference.
    _walletBinding.wallet_free(_wallet);
    _wallet = nullptr;
  }

}

String generateRandomMnemonic() {
  // Gets the string from the native code
  var native_str = _walletBinding.wallet_random_mnemonic();
  // Convert the native string to dart string.
  var dart_str = native_str.cast<Utf8>().toDartString();
  // free the native string since is not managed from the dart GC.
  _walletBinding.cstring_free(native_str);

  return dart_str;
}

CrwWallet walletFromMnemonic(String mnemonic, String derivation_path) {
  return CrwWalletNative.fromMnemonic(mnemonic, derivation_path);
}