import 'dart:async';

import 'package:flutter/material.dart';
import 'package:wallet_repository/wallet_repository.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({
    super.key,
    required this.pushToCreateWallet,
    required this.pushToHome,
    required this.walletRepository,
  });

  final VoidCallback pushToCreateWallet;
  final VoidCallback pushToHome;
  final WalletRepository walletRepository;

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  WalletRepository get walletRepository => widget.walletRepository;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Timer(const Duration(milliseconds: 2000), () {
      _walletCheck();
    });
  }

  Future<void> _walletCheck() async {
    final walletMnemonic = await walletRepository.getWalletMnemonic();
    if (walletMnemonic != null) {
      try {
        await walletRepository.recoverWallet(walletMnemonic);
        widget.pushToHome();
      } catch (e) {
        print('Error: [splash_screen.dart | _walletCheck]: $e');
        widget.pushToHome();
      }
    } else {
      widget.pushToCreateWallet();
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(
              height: 180,
              image: AssetImage('assets/images/logo.png'),
            ),
            Text('Initializing...')
          ],
        ),
      ),
    );
  }
}
