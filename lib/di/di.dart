import 'package:kiwi/kiwi.dart';
import 'package:dam/sources/wallet/wallet_source.dart';

part 'di.g.dart';

abstract class Injector {
  @Register.singleton(WalletSource)
  void configure();
}

class Di {
  static void setup() {
    var injector = _$Injector();
    injector.configure();
  }
}