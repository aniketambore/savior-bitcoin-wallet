import 'package:component_library/component_library.dart';
import 'package:create_wallet/src/create_wallet_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallet_repository/wallet_repository.dart';

class CreateWalletScreen extends StatelessWidget {
  const CreateWalletScreen({
    super.key,
    required this.walletRepository,
    required this.onCreateWalletSuccess,
    required this.onRecoverWalletTap,
  });

  final WalletRepository walletRepository;
  final VoidCallback onCreateWalletSuccess;
  final VoidCallback onRecoverWalletTap;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CreateWalletCubit>(
      create: (_) => CreateWalletCubit(
        walletRepository: walletRepository,
      ),
      child: CreateWalletView(
        onCreateWalletSuccess: onCreateWalletSuccess,
        onRecoverWalletTap: onRecoverWalletTap,
      ),
    );
  }
}

class CreateWalletView extends StatelessWidget {
  const CreateWalletView({
    super.key,
    required this.onCreateWalletSuccess,
    required this.onRecoverWalletTap,
  });

  final VoidCallback onCreateWalletSuccess;
  final VoidCallback onRecoverWalletTap;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Savior Bitcoin Wallet'),
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(Spacing.mediumLarge),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Image.asset(
                      'assets/images/logo.png',
                      width: 180,
                    ),
                    const Text(
                      'Bitcoin Testnet',
                      style: TextStyle(
                        fontSize: FontSize.large,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
                _CreateWalletForm(
                  onCreateWalletSuccess: onCreateWalletSuccess,
                  onRecoverWalletTap: onRecoverWalletTap,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _CreateWalletForm extends StatefulWidget {
  const _CreateWalletForm({
    required this.onCreateWalletSuccess,
    required this.onRecoverWalletTap,
  });

  final VoidCallback onCreateWalletSuccess;
  final VoidCallback onRecoverWalletTap;

  @override
  State<_CreateWalletForm> createState() => __CreateWalletFormState();
}

class __CreateWalletFormState extends State<_CreateWalletForm> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CreateWalletCubit, CreateWalletState>(
      listenWhen: (oldState, newState) =>
          oldState.submissionStatus != newState.submissionStatus,
      listener: (context, state) {
        if (state.submissionStatus == SubmissionStatus.success) {
          widget.onCreateWalletSuccess();
          return;
        }

        if (state.submissionStatus == SubmissionStatus.error) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const GenericErrorSnackBar(),
            );
        }
      },
      builder: (context, state) {
        final cubit = context.read<CreateWalletCubit>();
        final isSubmissionInProgress =
            state.submissionStatus == SubmissionStatus.inProgress;

        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            isSubmissionInProgress
                ? ExpandedElevatedButton.inProgress(
                    label: 'Create a New Wallet',
                  )
                : ExpandedElevatedButton(
                    label: 'Create a New Wallet',
                    onTap: cubit.onCreateWalletSubmit,
                  ),
            const SizedBox(
              height: Spacing.medium,
            ),
            isSubmissionInProgress
                ? const Text('Creating Wallet...')
                : ExpandedOutlinedButton(
                    label: 'Recover an Existing Wallet',
                    onTap: widget.onRecoverWalletTap,
                  ),
          ],
        );
      },
    );
  }
}
