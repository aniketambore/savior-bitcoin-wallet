import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_fields/form_fields.dart';
import 'package:send/src/send_cubit.dart';
import 'package:wallet_repository/wallet_repository.dart';

class SendScreen extends StatelessWidget {
  const SendScreen({
    super.key,
    required this.onSendSuccess,
    required this.walletRepository,
  });

  final VoidCallback onSendSuccess;
  final WalletRepository walletRepository;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SendCubit>(
      create: (_) => SendCubit(
        walletRepository: walletRepository,
      ),
      child: SendView(
        onSendSuccess: onSendSuccess,
      ),
    );
  }
}

class SendView extends StatelessWidget {
  const SendView({
    super.key,
    required this.onSendSuccess,
  });
  final VoidCallback onSendSuccess;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Savior Bitcoin Wallet'),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: _SendForm(
            onSendSuccess: onSendSuccess,
          ),
        ),
      ),
    );
  }
}

class _SendForm extends StatefulWidget {
  const _SendForm({
    required this.onSendSuccess,
  });
  final VoidCallback onSendSuccess;

  @override
  State<_SendForm> createState() => __SendFormState();
}

class __SendFormState extends State<_SendForm> {
  final _addressFocusNode = FocusNode();
  final _amountFocusNode = FocusNode();
  final _feeFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    final cubit = context.read<SendCubit>();
    _addressFocusNode.addListener(() {
      if (!_addressFocusNode.hasFocus) {
        cubit.onAddressUnfocused();
      }
    });

    _amountFocusNode.addListener(() {
      if (!_amountFocusNode.hasFocus) {
        cubit.onAmountUnfocused();
      }
    });

    _feeFocusNode.addListener(() {
      if (!_feeFocusNode.hasFocus) {
        cubit.onFeeUnfocused();
      }
    });
  }

  @override
  void dispose() {
    _addressFocusNode.dispose();
    _amountFocusNode.dispose();
    _feeFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SendCubit, SendState>(
      listenWhen: (oldState, newState) =>
          oldState.submissionStatus != newState.submissionStatus,
      listener: (context, state) {
        if (state.submissionStatus == SubmissionStatus.success) {
          widget.onSendSuccess();
          return;
        }

        final hasSubmissionError =
            state.submissionStatus == SubmissionStatus.genericError ||
                state.submissionStatus == SubmissionStatus.sendTxError;

        if (hasSubmissionError) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              state.submissionStatus == SubmissionStatus.sendTxError
                  ? const SnackBar(
                      content: Text(
                        'There has been an error while sending transaction.',
                      ),
                    )
                  : const GenericErrorSnackBar(),
            );
        }
      },
      builder: (context, state) {
        final addressError = state.address.invalid ? state.address.error : null;
        final amountError = state.amount.invalid ? state.amount.error : null;
        final feeError = state.fee.invalid ? state.fee.error : null;
        final isSubmissionInProgress =
            state.submissionStatus == SubmissionStatus.inProgress;

        final cubit = context.read<SendCubit>();
        return Container(
          padding: const EdgeInsets.all(Spacing.mediumLarge),
          child: Column(
            children: [
              header(),
              Container(
                padding: const EdgeInsets.symmetric(
                  vertical: Spacing.mediumLarge,
                  horizontal: Spacing.small,
                ),
                child: Wrap(
                  runSpacing: Spacing.medium,
                  children: [
                    WalletTextField(
                      hintText: 'Recipient',
                      iconPath: 'assets/icons/user.svg',
                      focusNode: _addressFocusNode,
                      onChanged: cubit.onAddressChanged,
                      textInputAction: TextInputAction.next,
                      autoCorrect: false,
                      enabled: !isSubmissionInProgress,
                      errorText: addressError == null
                          ? null
                          : (addressError == AddressValidationError.empty
                              ? 'Recipient address can\'t be empty.'
                              : 'This address is not valid.'),
                    ),
                    WalletTextField(
                      hintText: 'Amount',
                      iconPath: 'assets/icons/satoshi.svg',
                      keyboardType: TextInputType.number,
                      focusNode: _amountFocusNode,
                      onChanged: (value) =>
                          cubit.onAmountChanged(int.tryParse(value) ?? 0),
                      textInputAction: TextInputAction.next,
                      autoCorrect: false,
                      enabled: !isSubmissionInProgress,
                      errorText: amountError == null
                          ? null
                          : 'This amount is not valid.',
                    ),
                    WalletTextField(
                      hintText: 'Fee rate',
                      iconPath: 'assets/icons/mining.svg',
                      keyboardType: TextInputType.number,
                      focusNode: _feeFocusNode,
                      onChanged: (value) =>
                          cubit.onFeeChanged(double.tryParse(value) ?? 0),
                      onEditingComplete: cubit.onSubmit,
                      enabled: !isSubmissionInProgress,
                      errorText: feeError == null
                          ? null
                          : 'This fee rate is not valid',
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  isSubmissionInProgress
                      ? ExpandedElevatedButton.inProgress(
                          label: 'Broadcast Transaction')
                      : ExpandedElevatedButton(
                          label: 'Broadcast Transaction',
                          onTap: () {
                            cubit.onSubmit();
                          },
                          color: flamingo,
                        ),
                  const SizedBox(
                    height: Spacing.medium,
                  ),
                  ExpandedOutlinedButton(
                    label: "Back to wallet",
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }

  Widget header() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: Spacing.mediumLarge),
      child: Column(
        children: const [
          CircleWidget(
            borderColor: woodSmoke,
            shadowColor: trout,
            bgColor: flamingo,
            iconData: Icons.call_made_outlined,
            size: 120,
          ),
          SizedBox(
            height: Spacing.medium,
          ),
          Text(
            'Send Bitcoin',
            style: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.w800,
              color: black,
            ),
          ),
        ],
      ),
    );
  }
}
