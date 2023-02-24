import 'package:create_wallet/create_wallet.dart';
import 'package:flutter/material.dart';
import 'package:home/home.dart';
import 'package:receive/receive.dart';
import 'package:recover_phrase/recover_phrase.dart';
import 'package:recover_wallet/recover_wallet.dart';
import 'package:routemaster/routemaster.dart';
import 'package:savior_bitcoin_wallet/splash_screen.dart';
import 'package:send/send.dart';
import 'package:success_indicator/success_indicator.dart';
import 'package:tx_history/tx_history.dart';
import 'package:wallet_repository/wallet_repository.dart';

Map<String, PageBuilder> buildRoutingTable({
  required RoutemasterDelegate routerDelegate,
  required WalletRepository walletRepository,
}) {
  return {
    _PathConstants.splashPath: (_) {
      return MaterialPage(
        name: 'splash',
        child: SplashScreen(
          walletRepository: walletRepository,
          pushToCreateWallet: () {
            routerDelegate.replace(
              _PathConstants.createWalletPath,
            );
          },
          pushToHome: () {
            routerDelegate.replace(
              _PathConstants.homePath,
            );
          },
        ),
      );
    },
    _PathConstants.createWalletPath: (_) {
      return MaterialPage(
        name: 'create-wallet',
        child: CreateWalletScreen(
          walletRepository: walletRepository,
          onCreateWalletSuccess: () {
            routerDelegate.replace(
              _PathConstants.homePath,
            );
          },
          onRecoverWalletTap: () {
            routerDelegate.push(
              _PathConstants.recoverWalletPath,
            );
          },
        ),
      );
    },
    _PathConstants.recoverWalletPath: (_) {
      return MaterialPage(
        name: 'recover-wallet',
        child: RecoverWalletScreen(
          walletRepository: walletRepository,
          onRecoverWalletSuccess: () {
            routerDelegate.replace(
              _PathConstants.homePath,
            );
          },
        ),
      );
    },
    _PathConstants.homePath: (_) {
      return MaterialPage(
        name: 'home',
        child: HomeScreen(
          onReceiveTap: () {
            routerDelegate.push(_PathConstants.receivePath);
          },
          onSendTap: () {
            routerDelegate.push(_PathConstants.sendPath);
          },
          walletRepository: walletRepository,
          onTxHistoryTap: () {
            routerDelegate.push(_PathConstants.txHistoryPath);
          },
          onRecoverPhraseTap: () {
            routerDelegate.pop();
            routerDelegate.push(_PathConstants.recoveryPhrasePath);
          },
        ),
      );
    },
    _PathConstants.receivePath: (_) {
      return MaterialPage(
        name: 'receive',
        child: ReceiveAddressScreen(
          walletRepository: walletRepository,
        ),
      );
    },
    _PathConstants.sendPath: (_) {
      return MaterialPage(
        name: 'send',
        child: SendScreen(
          onSendSuccess: () {
            routerDelegate.replace(_PathConstants.successIndicatorPath);
          },
          walletRepository: walletRepository,
        ),
      );
    },
    _PathConstants.txHistoryPath: (_) {
      return MaterialPage(
        name: 'tx-history',
        child: TxHistoryScreen(
          walletRepository: walletRepository,
        ),
      );
    },
    _PathConstants.recoveryPhrasePath: (_) {
      return MaterialPage(
        name: 'recovery-phrase',
        child: RecoveryPhraseScreen(
          walletRepository: walletRepository,
        ),
      );
    },
    _PathConstants.successIndicatorPath: (_) {
      return MaterialPage(
        name: 'success-indicator',
        child: SuccessIndicatorScreen(
          onOkayTap: () {
            routerDelegate.pop();
          },
        ),
      );
    }
  };
}

class _PathConstants {
  const _PathConstants._();

  static String get splashPath => '/';

  static String get createWalletPath => '/create-wallet';

  static String get recoverWalletPath => '${createWalletPath}recover';

  static String get homePath => '/home';

  static String get receivePath => '$homePath/receive';
  static String get sendPath => '$homePath/send';
  static String get txHistoryPath => '$homePath/txhistory';
  static String get recoveryPhrasePath => '$homePath/recovery-phrase';
  static String get successIndicatorPath => '$homePath/success';
}
