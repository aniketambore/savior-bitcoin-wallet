import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recover_phrase/src/recovery_phrase_cubit.dart';
import 'package:wallet_repository/wallet_repository.dart';

class RecoveryPhraseScreen extends StatelessWidget {
  const RecoveryPhraseScreen({
    super.key,
    required this.walletRepository,
  });
  final WalletRepository walletRepository;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<RecoveryPhraseCubit>(
      create: (_) => RecoveryPhraseCubit(
        walletRepository: walletRepository,
      ),
      child: const RecoveryPhraseView(),
    );
  }
}

class RecoveryPhraseView extends StatelessWidget {
  const RecoveryPhraseView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Savior Bitcoin Wallet'),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(Spacing.mediumLarge),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Recovery Phrase',
                style: TextStyle(
                  fontSize: FontSize.large,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const RecoveryPhraseCard(),
              ExpandedOutlinedButton(
                label: 'Back to wallet',
                onTap: () {
                  Navigator.pop(context);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

class RecoveryPhraseCard extends StatelessWidget {
  const RecoveryPhraseCard({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RecoveryPhraseCubit, RecoveryPhraseState>(
      listener: (context, state) {
        final recoverPhraseError =
            state is RecoveryPhraseSuccess ? state.recoverPhraseError : null;
        if (recoverPhraseError != null) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const GenericErrorSnackBar(),
            );
        }
      },
      builder: (context, state) {
        return state is RecoveryPhraseSuccess
            ? recoveryPhraseContainer(state.mnemonic)
            : state is RecoveryPhraseFailure
                ? ExceptionIndicator(
                    onTryAgain: () {
                      final cubit = context.read<RecoveryPhraseCubit>();
                      cubit.refetch();
                    },
                  )
                : const CenteredCircularProgressIndicator();
      },
    );
  }

  Widget recoveryPhraseContainer(List<String> mnemonic) {
    return Container(
      color: athens,
      padding: const EdgeInsets.all(Spacing.xLarge),
      child: Wrap(
        spacing: Spacing.medium,
        runSpacing: Spacing.medium,
        alignment: WrapAlignment.start,
        children: [
          for (var str in mnemonic)
            SelectableText(
              str,
              style: const TextStyle(
                fontSize: FontSize.mediumLarge,
                fontWeight: FontWeight.w800,
              ),
            ),
        ],
      ),
    );
  }
}
