import 'package:component_library/component_library.dart';
import 'package:converter/converter.dart';
import 'package:domain_models/domain_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tx_history/src/tx_history_cubit.dart';
import 'package:wallet_repository/wallet_repository.dart';

typedef TxSelected = Function(String label, String url, BuildContext context);

class TxHistoryScreen extends StatelessWidget {
  const TxHistoryScreen({
    super.key,
    required this.walletRepository,
    required this.onTxSelected,
  });

  final WalletRepository walletRepository;
  final TxSelected onTxSelected;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TxHistoryCubit>(
      create: (_) => TxHistoryCubit(
        walletRepository: walletRepository,
      ),
      child: TxHistoryView(
        onTxSelected: onTxSelected,
      ),
    );
  }
}

class TxHistoryView extends StatelessWidget {
  const TxHistoryView({
    super.key,
    required this.onTxSelected,
  });
  final TxSelected onTxSelected;

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
            children: [
              const Text(
                'Transaction History',
                style: TextStyle(
                  fontSize: FontSize.large,
                  fontWeight: FontWeight.w800,
                ),
              ),
              _TxListCardHolder(
                onTxSelected: onTxSelected,
              ),
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

class _TxListCardHolder extends StatelessWidget {
  const _TxListCardHolder({
    required this.onTxSelected,
  });
  final TxSelected onTxSelected;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TxHistoryCubit, TxHistoryState>(
      listener: (context, state) {
        final txListError =
            state is TxHistorySuccess ? state.txListError : null;
        if (txListError != null) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const GenericErrorSnackBar(),
            );
        }
      },
      builder: (context, state) {
        return Expanded(
          child: state is TxHistorySuccess
              ? _TxListCard(
                  txList: state.txList,
                  onTxSelected: onTxSelected,
                )
              : state is TxHistoryFailure
                  ? ExceptionIndicator(
                      onTryAgain: () {
                        final cubit = context.read<TxHistoryCubit>();
                        cubit.refetch();
                      },
                    )
                  : const CenteredCircularProgressIndicator(),
        );
      },
    );
  }
}

class _TxListCard extends StatelessWidget {
  const _TxListCard({
    required this.txList,
    required this.onTxSelected,
  });

  final TxList txList;
  final TxSelected onTxSelected;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 24),
        color: athens,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                color: persianBlue,
                width: double.infinity,
                padding: const EdgeInsets.all(Spacing.medium),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: const [
                        Padding(
                          padding: EdgeInsets.only(right: Spacing.small),
                          child: CircleWidget(
                            borderColor: white,
                            shadowColor: trout,
                            bgColor: persianBlue,
                          ),
                        ),
                        Text(
                          'Confirmed',
                          style: TextStyle(
                            fontSize: FontSize.mediumLarge,
                            fontWeight: FontWeight.w500,
                            color: white,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: Spacing.xSmall,
                    ),
                    Row(
                      children: const [
                        Padding(
                          padding: EdgeInsets.only(right: Spacing.small),
                          child: CircleWidget(
                            borderColor: white,
                            shadowColor: trout,
                            bgColor: flamingo,
                          ),
                        ),
                        Text(
                          'Pending',
                          style: TextStyle(
                            fontSize: FontSize.mediumLarge,
                            fontWeight: FontWeight.w500,
                            color: white,
                          ),
                        ),
                      ],
                    ),
                  ],
                )),
            Container(
              padding: const EdgeInsets.all(Spacing.medium),
              child: txList.txList.isEmpty
                  ? const Text(
                      'No confirmed transactions',
                      style: TextStyle(fontSize: FontSize.medium),
                    )
                  : _TxList(
                      txList: txList,
                      onTxSelected: onTxSelected,
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TxList extends StatefulWidget {
  const _TxList({
    required this.txList,
    required this.onTxSelected,
  });

  final TxList txList;
  final TxSelected onTxSelected;

  @override
  State<_TxList> createState() => _TxListState();
}

class _TxListState extends State<_TxList> {
  String getExplorerUrl(String txid) =>
      'https://blockstream.info/testnet/tx/$txid';

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      primary: false,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: widget.txList.txList.length,
      itemBuilder: (_, index) {
        final tx = widget.txList.txList[index];
        final timestamp = tx.confirmationTime?.timestamp?.d12() ?? 0;
        final received = tx.received.toBTC();
        final sent = tx.sent.toBTC();
        final fees = tx.fee;
        final height = tx.confirmationTime?.height ?? 0;
        final txid = tx.txid;
        return Column(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                text('Timestamp: $timestamp', height),
                text('Received: $received BTC', height),
                text('Sent: $sent BTC', height),
                text('Fees: $fees SATS', height),
                text('Height: $height', height),
                text('Txid: $txid', height),
              ],
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: IconButton(
                icon: const Icon(
                  Icons.open_in_new_outlined,
                  size: 30,
                ),
                onPressed: () {
                  widget.onTxSelected(
                    'Blockstream Explorer',
                    getExplorerUrl(txid),
                    context,
                  );
                },
              ),
            ),
          ],
        );
      },
      separatorBuilder: (context, index) {
        return const Divider(
          thickness: 3,
          color: woodSmoke,
        );
      },
    );
  }

  Widget text(String text, int height) {
    Color color = persianBlue;
    if (height == 0) color = flamingo;
    return SelectableText(
      text,
      style: TextStyle(
        fontSize: FontSize.mediumLarge,
        fontWeight: FontWeight.w500,
        color: color,
      ),
    );
  }
}
