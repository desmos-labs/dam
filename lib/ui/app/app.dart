import 'package:dam/blocs/wallet/export.dart';
import 'package:dam/ui/screens/export.dart';
import 'package:flutter/material.dart';
import 'package:dam/ui/export.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
      home: _getPageContent(),
    );
  }

  Widget _getPageContent() {
    return BlocProvider<WalletBloc>(
        create: (_) => WalletBloc.newInstance(),
        child: BlocBuilder<WalletBloc, WalletState>(
          builder: (context, state) {
            if (state is WalletStateNotInitialized) {
              return InitWalletPage();
            } else if (state is WalletStateLocked) {
              return UnlockWalletPage();
            } else if (state is WalletStateUnlocked) {
              return ShowAddressesPage(
                  accountsNumber: 3, mnemonic: state.mnemonic);
            } else {
              return Text('Unknown state...');
            }
          },
        ));
  }
}
