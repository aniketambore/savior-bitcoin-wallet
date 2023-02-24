import 'package:bdk_api/bdk_api.dart';
import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';
import 'package:key_value_storage/key_value_storage.dart';
import 'package:routemaster/routemaster.dart';
import 'package:wallet_repository/wallet_repository.dart';

import 'routing_table.dart';

void main() {
  runApp(
    const SaviorBitcoinWallet(),
  );
}

class SaviorBitcoinWallet extends StatefulWidget {
  const SaviorBitcoinWallet({super.key});

  @override
  State<SaviorBitcoinWallet> createState() => _SaviorBitcoinWalletState();
}

class _SaviorBitcoinWalletState extends State<SaviorBitcoinWallet> {
  final _keyValueStorage = KeyValueStorage();
  late final dynamic _bdkApi = BDKApi();

  late final dynamic _walletRepository = WalletRepository(
    bdkApi: _bdkApi,
    keyValueStorage: _keyValueStorage,
  );

  late final dynamic _routerDelegate = RoutemasterDelegate(
    routesBuilder: (context) {
      return RouteMap(
        routes: buildRoutingTable(
          routerDelegate: _routerDelegate,
          walletRepository: _walletRepository,
        ),
      );
    },
  );

  final _lightTheme = LightWalletThemeData();
  final _darkTheme = DarkWalletThemeData();

  @override
  Widget build(BuildContext context) {
    return WalletTheme(
      lightTheme: _lightTheme,
      darkTheme: _darkTheme,
      child: MaterialApp.router(
        title: 'Savior Bitcoin Wallet',
        theme: _lightTheme.materialThemeData,
        darkTheme: _darkTheme.materialThemeData,
        themeMode: ThemeMode.light,
        routerDelegate: _routerDelegate,
        routeInformationParser: const RoutemasterParser(),
      ),
    );
  }
}
