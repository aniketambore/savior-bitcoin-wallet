import 'package:component_library/component_library.dart';
import 'package:domain_models/domain_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home/src/home_cubit.dart';
import 'package:home/src/home_drawer.dart';
import 'package:wallet_repository/wallet_repository.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
    required this.onReceiveTap,
    required this.onSendTap,
    required this.onTxHistoryTap,
    required this.onRecoverPhraseTap,
    required this.onWalletDeleted,
    required this.walletRepository,
  });

  final VoidCallback onReceiveTap;
  final VoidCallback onSendTap;
  final VoidCallback onTxHistoryTap;
  final VoidCallback onRecoverPhraseTap;
  final VoidCallback onWalletDeleted;
  final WalletRepository walletRepository;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeCubit>(
      create: (_) => HomeCubit(
        walletRepository: walletRepository,
      ),
      child: HomeView(
        onReceiveTap: onReceiveTap,
        onSendTap: onSendTap,
        onTxHistoryTap: onTxHistoryTap,
        onRecoverPhraseTap: onRecoverPhraseTap,
        onWalletDeleted: onWalletDeleted,
      ),
    );
  }
}

class HomeView extends StatefulWidget {
  const HomeView({
    super.key,
    required this.onReceiveTap,
    required this.onSendTap,
    required this.onTxHistoryTap,
    required this.onRecoverPhraseTap,
    required this.onWalletDeleted,
  });

  final VoidCallback onReceiveTap;
  final VoidCallback onSendTap;
  final VoidCallback onTxHistoryTap;
  final VoidCallback onRecoverPhraseTap;
  final VoidCallback onWalletDeleted;

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Savior Bitcoin Wallet'),
        centerTitle: true,
      ),
      drawer: HomeDrawer(
        onRecoverPhraseTap: widget.onRecoverPhraseTap,
        onWalletDeleted: widget.onWalletDeleted,
      ),
      body: BlocConsumer<HomeCubit, HomeState>(
        listenWhen: (oldState, newState) =>
            oldState is HomeSuccess && newState is HomeSuccess
                ? oldState.syncStatus != newState.syncStatus
                : false,
        listener: (context, state) {
          if (state is HomeSuccess) {
            final hasSubmissionError = state.syncStatus == SyncStatus.error;

            if (hasSubmissionError) {
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  const GenericErrorSnackBar(),
                );
            }
          }
        },
        builder: (context, state) {
          return state is HomeSuccess
              ? _HomeWalletContent(
                  onReceiveTap: widget.onReceiveTap,
                  onSendTap: widget.onSendTap,
                  onTxHistoryTap: widget.onTxHistoryTap,
                  balance: state.balance,
                  syncStatus: state.syncStatus,
                )
              : state is HomeFailure
                  ? ExceptionIndicator(
                      onTryAgain: () {
                        final cubit = context.read<HomeCubit>();
                        cubit.refetch();
                      },
                    )
                  : const CenteredCircularProgressIndicator();
        },
      ),
    );
  }
}

class _HomeWalletContent extends StatefulWidget {
  const _HomeWalletContent({
    required this.onReceiveTap,
    required this.onSendTap,
    required this.onTxHistoryTap,
    required this.balance,
    required this.syncStatus,
  });

  final VoidCallback onReceiveTap;
  final VoidCallback onSendTap;
  final VoidCallback onTxHistoryTap;
  final Balance balance;
  final SyncStatus syncStatus;

  @override
  State<_HomeWalletContent> createState() => _HomeWalletContentState();
}

class _HomeWalletContentState extends State<_HomeWalletContent> {
  bool toBtc = false;
  @override
  Widget build(BuildContext context) {
    final cubit = context.read<HomeCubit>();
    return SafeArea(
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: Spacing.xLarge),
            color: athens,
            child: SizedBox(
              height: 110,
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.topCenter,
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.all(Spacing.mediumLarge),
                    child: const Text(
                      'TOTAL BALANCE:',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: FontSize.medium,
                        color: woodSmoke,
                      ),
                    ),
                  ),
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          'assets/icons/bitcoin_logo.svg',
                          height: 46,
                          width: 46,
                        ),
                        const SizedBox(width: 5),
                        BalanceFormatter(balance: widget.balance.total),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: Spacing.mediumLarge),
            child: Column(
              children: [
                widget.syncStatus == SyncStatus.inProgress
                    ? ExpandedElevatedButton.inProgress(
                        label: 'Syncing...',
                      )
                    : ExpandedElevatedButton(
                        label: 'Sync',
                        onTap: () {
                          cubit.refresh();
                        },
                      ),
                const SizedBox(
                  height: Spacing.medium,
                ),
                ExpandedElevatedButton(
                  label: 'Transaction History',
                  onTap: widget.onTxHistoryTap,
                ),
                const SizedBox(
                  height: Spacing.xLarge,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.only(
                          right: Spacing.small,
                        ),
                        child: BoxButton(
                          label: 'Receive',
                          onTap: widget.onReceiveTap,
                          color: lighteningOrange,
                          iconData: Icons.call_received_outlined,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.only(
                          left: Spacing.small,
                        ),
                        child: BoxButton(
                          label: 'Send',
                          onTap: widget.onSendTap,
                          color: flamingo,
                          iconData: Icons.call_made_outlined,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
