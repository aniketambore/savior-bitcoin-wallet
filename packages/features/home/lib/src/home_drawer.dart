import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home/src/home_cubit.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({
    super.key,
    required this.onRecoverPhraseTap,
    required this.onWalletDeleted,
  });

  final VoidCallback onRecoverPhraseTap;
  final VoidCallback onWalletDeleted;

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
                onWalletDeleted: onWalletDeleted,
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
        child: const Column(
          children: [
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
              'Version: 0.1.0',
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

class DrawerItems extends StatefulWidget {
  const DrawerItems({
    super.key,
    required this.onRecoverPhraseTap,
    required this.onWalletDeleted,
  });
  final VoidCallback onRecoverPhraseTap;
  final VoidCallback onWalletDeleted;

  @override
  State<DrawerItems> createState() => _DrawerItemsState();
}

class _DrawerItemsState extends State<DrawerItems> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          _buildListTile(title: 'About', onTap: () {}),
          _buildListTile(
            title: 'Recovery Phrase',
            onTap: widget.onRecoverPhraseTap,
          ),
          _buildListTile(
            title: 'Delete Wallet',
            onTap: () => _showDeleteWalletDialog(context),
            color: flamingo,
          )
        ],
      ),
    );
  }

  ListTile _buildListTile({
    required String title,
    required VoidCallback onTap,
    Color color = Colors.black,
  }) {
    return ListTile(
      title: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: color,
        ),
      ),
      onTap: onTap,
    );
  }

  void _showDeleteWalletDialog(BuildContext context) {
    final cubit = context.read<HomeCubit>();
    Navigator.pop(context);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Wallet'),
        content: const Text('Are you sure want to delete your wallet?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('No'),
          ),
          TextButton(
            onPressed: () {
              cubit.deleteWallet();
              widget.onWalletDeleted();
            },
            child: const Text('Yes'),
          ),
        ],
      ),
    );
  }
}
