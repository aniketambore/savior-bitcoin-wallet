import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({
    super.key,
    required this.onRecoverPhraseTap,
  });

  final VoidCallback onRecoverPhraseTap;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topRight: Radius.circular(26),
      ),
      child: Drawer(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const DrawerHeader(),
              DrawerItems(
                onRecoverPhraseTap: onRecoverPhraseTap,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DrawerHeader extends StatelessWidget {
  const DrawerHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: lighteningOrange,
      child: Container(
        padding: EdgeInsets.only(
          top: 24 + MediaQuery.of(context).padding.top,
          bottom: 24,
        ),
        child: Column(
          children: const [
            CircleAvatar(
              radius: 52,
              backgroundImage: AssetImage('assets/images/logo.png'),
            ),
            SizedBox(
              height: 12,
            ),
            Text(
              'Savior Bitcoin Testnet Wallet',
              style: TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.bold,
                color: white,
              ),
            ),
            Text(
              'Version: 0.0.0',
              style: TextStyle(
                color: white,
                fontSize: 17,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DrawerItems extends StatelessWidget {
  const DrawerItems({
    super.key,
    required this.onRecoverPhraseTap,
  });
  final VoidCallback onRecoverPhraseTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          ListTile(
            title: const Text(
              'About',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            onTap: () {},
          ),
          ListTile(
            title: const Text(
              'Recovery Phrase',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            onTap: onRecoverPhraseTap,
          )
        ],
      ),
    );
  }
}
