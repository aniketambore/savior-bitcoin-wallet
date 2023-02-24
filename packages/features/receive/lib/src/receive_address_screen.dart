import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:receive/src/receive_address_cubit.dart';
import 'package:wallet_repository/wallet_repository.dart';

class ReceiveAddressScreen extends StatelessWidget {
  const ReceiveAddressScreen({
    super.key,
    required this.walletRepository,
  });

  final WalletRepository walletRepository;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ReceiveAddressCubit>(
      create: (_) => ReceiveAddressCubit(
        walletRepository: walletRepository,
      ),
      child: const ReceiveAddressView(),
    );
  }
}

class ReceiveAddressView extends StatelessWidget {
  const ReceiveAddressView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ReceiveAddressCubit, ReceiveAddressState>(
      listener: (context, state) {
        final receiveAddressError =
            state is ReceiveAddressSuccess ? state.receiveAddressError : null;

        if (receiveAddressError != null) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const GenericErrorSnackBar(),
            );
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Savior Bitcoin Wallet'),
            centerTitle: true,
            automaticallyImplyLeading: false,
          ),
          body: SafeArea(
            child: Center(
              child: state is ReceiveAddressFailure
                  ? ExceptionIndicator(
                      onTryAgain: () {
                        final cubit = context.read<ReceiveAddressCubit>();
                        cubit.refetch();
                      },
                    )
                  : Container(
                      padding: const EdgeInsets.all(Spacing.mediumLarge),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Receive Address',
                            style: TextStyle(
                              fontSize: FontSize.large,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          state is ReceiveAddressSuccess
                              ? _ReceiveAddressContent(
                                  address: state.receiveAddress,
                                )
                              : const CenteredCircularProgressIndicator(),
                          _ReceiveAddressActions(),
                        ],
                      ),
                    ),
            ),
          ),
        );
      },
    );
  }
}

class _ReceiveAddressContent extends StatelessWidget {
  const _ReceiveAddressContent({
    required this.address,
  });

  final String address;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: FittedBox(
        fit: BoxFit.contain,
        child: Container(
          padding: const EdgeInsets.all(Spacing.medium),
          child: Column(
            children: [
              QrCard(
                qrData: address,
              ),
              const SizedBox(
                height: Spacing.medium,
              ),
              FittedBox(
                fit: BoxFit.cover,
                child: SelectableText(
                  address,
                  style: const TextStyle(
                    fontSize: FontSize.medium,
                    fontWeight: FontWeight.w500,
                  ),
                  // maxLines: 1,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ReceiveAddressActions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ReceiveAddressCubit>();
    return Column(
      children: [
        ExpandedElevatedButton(
          label: 'Generate new addresss',
          onTap: () {
            cubit.refetch();
          },
          color: lighteningOrange,
        ),
        const SizedBox(
          height: Spacing.medium,
        ),
        ExpandedOutlinedButton(
          label: 'Back to wallet',
          onTap: () {
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}
