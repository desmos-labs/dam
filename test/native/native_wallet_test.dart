import 'package:dam/crw-wallet/crw-wallet.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:alan/wallet/export.dart';
import 'package:hex/hex.dart';

void main() {

  var TEST_MNEMONIC = 'battle call once stool three mammal hybrid list sign field athlete amateur cinnamon eagle shell erupt voyage hero assist maple matrix maximum able barrel';
  var TEST_ADDRESS = 'desmos1k8u92hx3k33a5vgppkyzq6m4frxx7ewnlkyjrh';
  var DESMOS_DP = "m/44'/852'/0'/0/0";

  test('Test wallet generation from mnemonic', () {
    var wallet = CrwWallet.fromMnemonic(TEST_MNEMONIC, DESMOS_DP);
    expect(TEST_ADDRESS, wallet.getBetch32Address('desmos'));
    wallet.destroy();
  });

  test('Test wallet generation with invalid mnemonic', () {
    expect(() {
        CrwWallet.fromMnemonic('an invalid mnemonic', DESMOS_DP);
    }, throwsException);
  });

  test('Test wallet generation with invalid derivation path', () {
    expect(() {
      CrwWallet.fromMnemonic(TEST_MNEMONIC, 'invalid dp');
    }, throwsException);
  });

  test('Wallet generation crw vs alan.dart', () {
    var ALAN_TEST_MNEMONIC = TEST_MNEMONIC.split(' ');
    var networkInfo = NetworkInfo(bech32Hrp: 'desmos', fullNodeHost: 'localhost');

    var s = Stopwatch()..start();
    for (var i = 0; i < 10; i++) {
      var w = Wallet.derive(ALAN_TEST_MNEMONIC, networkInfo, derivationPath: DESMOS_DP);
      w.bech32Address;
    }
    print('10x Wallet from mnemonic with alan: ${s.elapsed}');

    s.reset();
    s.start();
    for (var i = 0; i < 10; i++) {
      var w = CrwWallet.fromMnemonic(TEST_MNEMONIC, DESMOS_DP);
      var address = w.getBetch32Address('desmos');
      w.destroy();
    }
    print('10x Wallet from mnemonic with crw: ${s.elapsed}');
  });

  test('Wallet generation with random mnemonic crw vs alan.dart', () {
    var networkInfo = NetworkInfo(bech32Hrp: 'desmos', fullNodeHost: 'localhost');

    var s = Stopwatch()..start();
    for (var i = 0; i < 10; i++) {
      var w = Wallet.random(networkInfo, derivationPath: DESMOS_DP);
      w.bech32Address;
    }
    print('10x Wallet from random mnemonic with alan: ${s.elapsed}');

    s.reset();
    s.start();
    for (var i = 0; i < 10; i++) {
      var mnemonic = CrwWallet.randomMnemonic();
      var w = CrwWallet.fromMnemonic(mnemonic, DESMOS_DP);
      var address = w.getBetch32Address('desmos');
      w.destroy();
    }
    print('10x Wallet from random mnemonic with crw: ${s.elapsed}');
  });

  test('Wallet compressed pubkey generation test', () {
    var expectedKey = '02f5bf794ef934cb419bb9113f3a94c723ec6c2881a8d99eef851fd05b61ad698d';
    var wallet = CrwWallet.fromMnemonic(TEST_MNEMONIC, DESMOS_DP);
    var pubKey = wallet.getPublicKey();

    expect(33, pubKey.length);
    expect(expectedKey, HEX.encode(pubKey));

    wallet.destroy();
  });

  test('Wallet uncompressed pubkey generation test', () {
    var expectedKey = '04f5bf794ef934cb419bb9113f3a94c723ec6c2881a8d99eef851fd05b61ad698d06fd2f63cc0c2c1b764b45335f31c5e3a7c68dbe47c2fcd2c73b716e6f761402';
    var wallet = CrwWallet.fromMnemonic(TEST_MNEMONIC, DESMOS_DP);
    var pubKey = wallet.getPublicKey(false);

    expect(65, pubKey.length);
    expect(expectedKey, HEX.encode(pubKey));

    wallet.destroy();
  });

}