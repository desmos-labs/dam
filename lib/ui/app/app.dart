import 'package:dam/sources/wallet/wallet_source.dart';
import 'package:dam/ui/screens/unlock_wallet/unlock_wallet_page.dart';
import 'package:flutter/material.dart';
import 'package:dam/ui/export.dart';
import 'package:kiwi/kiwi.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      title: 'Desmos Account Manager',
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: DesmosColors.orange,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        scaffoldBackgroundColor: Colors.white,
        pageTransitionsTheme: NoTransitionsOnWeb(),
        appBarTheme: AppBarTheme(
          elevation: 0,
          backgroundColor: Colors.transparent,
          iconTheme: Theme.of(context).iconTheme.copyWith(
                color: DesmosColors.grey,
              ),
        ),
      ),
      home: _walletInitialized() ? UnlockWalletPage() : HomePage(),
    );
  }
  
  bool _walletInitialized() {
    return KiwiContainer().resolve<WalletSource>().initialized();
  }
}
