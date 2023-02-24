import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_fields/form_fields.dart';
import 'package:recover_wallet/src/recover_wallet_cubit.dart';
import 'package:wallet_repository/wallet_repository.dart';

class RecoverWalletScreen extends StatelessWidget {
  const RecoverWalletScreen({
    super.key,
    required this.walletRepository,
    required this.onRecoverWalletSuccess,
  });
  final WalletRepository walletRepository;
  final VoidCallback onRecoverWalletSuccess;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<RecoverWalletCubit>(
      create: (_) => RecoverWalletCubit(
        walletRepository: walletRepository,
      ),
      child: RecoverWalletView(
        onRecoverWalletSuccess: onRecoverWalletSuccess,
      ),
    );
  }
}

class RecoverWalletView extends StatelessWidget {
  const RecoverWalletView({
    super.key,
    required this.onRecoverWalletSuccess,
  });
  final VoidCallback onRecoverWalletSuccess;

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
          child: _MnemonicForm(
            onRecoverWalletSuccess: onRecoverWalletSuccess,
          ),
        ),
      ),
    );
  }
}

class _MnemonicForm extends StatefulWidget {
  const _MnemonicForm({
    required this.onRecoverWalletSuccess,
  });
  final VoidCallback onRecoverWalletSuccess;

  @override
  State<_MnemonicForm> createState() => __MnemonicFormState();
}

class __MnemonicFormState extends State<_MnemonicForm> {
  final _w1 = FocusNode();
  final _w2 = FocusNode();
  final _w3 = FocusNode();
  final _w4 = FocusNode();
  final _w5 = FocusNode();
  final _w6 = FocusNode();
  final _w7 = FocusNode();
  final _w8 = FocusNode();
  final _w9 = FocusNode();
  final _w10 = FocusNode();
  final _w11 = FocusNode();
  final _w12 = FocusNode();

  @override
  void initState() {
    super.initState();
    final cubit = context.read<RecoverWalletCubit>();
    _w1.addListener(() {
      if (!_w1.hasFocus) {
        cubit.onW1Unfocused();
      }
    });
    _w2.addListener(() {
      if (!_w2.hasFocus) {
        cubit.onW2Unfocused();
      }
    });
    _w3.addListener(() {
      if (!_w3.hasFocus) {
        cubit.onW3Unfocused();
      }
    });
    _w4.addListener(() {
      if (!_w4.hasFocus) {
        cubit.onW4Unfocused();
      }
    });
    _w5.addListener(() {
      if (!_w5.hasFocus) {
        cubit.onW5Unfocused();
      }
    });
    _w6.addListener(() {
      if (!_w6.hasFocus) {
        cubit.onW6Unfocused();
      }
    });
    _w7.addListener(() {
      if (!_w7.hasFocus) {
        cubit.onW7Unfocused();
      }
    });
    _w8.addListener(() {
      if (!_w8.hasFocus) {
        cubit.onW8Unfocused();
      }
    });
    _w9.addListener(() {
      if (!_w9.hasFocus) {
        cubit.onW9Unfocused();
      }
    });
    _w10.addListener(() {
      if (!_w10.hasFocus) {
        cubit.onW10Unfocused();
      }
    });
    _w11.addListener(() {
      if (!_w11.hasFocus) {
        cubit.onW11Unfocused();
      }
    });
    _w12.addListener(() {
      if (!_w12.hasFocus) {
        cubit.onW12Unfocused();
      }
    });
  }

  @override
  void dispose() {
    _w1.dispose();
    _w2.dispose();
    _w3.dispose();
    _w4.dispose();
    _w5.dispose();
    _w6.dispose();
    _w7.dispose();
    _w8.dispose();
    _w9.dispose();
    _w10.dispose();
    _w11.dispose();
    _w12.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RecoverWalletCubit, RecoverWalletState>(
      listenWhen: (oldState, newState) =>
          oldState.submissionStatus != newState.submissionStatus,
      listener: (context, state) {
        if (state.submissionStatus == SubmissionStatus.success) {
          widget.onRecoverWalletSuccess();
          return;
        }

        final hasSubmissionError =
            state.submissionStatus == SubmissionStatus.genericError ||
                state.submissionStatus == SubmissionStatus.invalidMnemonic;

        if (hasSubmissionError) {
          ScaffoldMessenger.of(context)
            ..hideCurrentMaterialBanner()
            ..showSnackBar(
              state.submissionStatus == SubmissionStatus.invalidMnemonic
                  ? const SnackBar(
                      content: Text('Invalid Mnenomic.'),
                    )
                  : const GenericErrorSnackBar(),
            );
        }
      },
      builder: (context, state) {
        final w1Error = state.w1.invalid ? state.w1.error : null;
        final w2Error = state.w2.invalid ? state.w2.error : null;
        final w3Error = state.w3.invalid ? state.w3.error : null;
        final w4Error = state.w4.invalid ? state.w4.error : null;
        final w5Error = state.w5.invalid ? state.w5.error : null;
        final w6Error = state.w6.invalid ? state.w6.error : null;
        final w7Error = state.w7.invalid ? state.w7.error : null;
        final w8Error = state.w8.invalid ? state.w8.error : null;
        final w9Error = state.w9.invalid ? state.w9.error : null;
        final w10Error = state.w10.invalid ? state.w10.error : null;
        final w11Error = state.w11.invalid ? state.w11.error : null;
        final w12Error = state.w12.invalid ? state.w12.error : null;
        final isSubmissionInProgress =
            state.submissionStatus == SubmissionStatus.inProgress;

        final cubit = context.read<RecoverWalletCubit>();
        return Column(
          children: [
            const Text(
              'Recover Wallet',
              style: TextStyle(
                fontSize: FontSize.large,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(
              height: Spacing.medium,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Wrap(
                  runSpacing: Spacing.medium,
                  children: [
                    WalletTextField(
                      hintText: 'Word 1',
                      focusNode: _w1,
                      onChanged: cubit.onW1Changed,
                      textInputAction: TextInputAction.next,
                      autoCorrect: false,
                      enabled: !isSubmissionInProgress,
                      errorText: w1Error == null
                          ? null
                          : (w1Error == WordValidationError.empty
                              ? 'Word1 can\'t be empty.'
                              : 'Word must be at least three characters long.'),
                      onEditingComplete: () {
                        FocusScope.of(context).requestFocus(_w2);
                      },
                    ),
                    WalletTextField(
                      hintText: 'Word 2',
                      focusNode: _w2,
                      onChanged: cubit.onW2Changed,
                      textInputAction: TextInputAction.next,
                      autoCorrect: false,
                      enabled: !isSubmissionInProgress,
                      errorText: w2Error == null
                          ? null
                          : (w2Error == WordValidationError.empty
                              ? 'Word2 can\'t be empty.'
                              : 'Word must be at least three characters long.'),
                      onEditingComplete: () {
                        FocusScope.of(context).requestFocus(_w3);
                      },
                    ),
                    WalletTextField(
                      hintText: 'Word 3',
                      focusNode: _w3,
                      onChanged: cubit.onW3Changed,
                      textInputAction: TextInputAction.next,
                      autoCorrect: false,
                      enabled: !isSubmissionInProgress,
                      errorText: w3Error == null
                          ? null
                          : (w3Error == WordValidationError.empty
                              ? 'Word3 can\'t be empty.'
                              : 'Word must be at least three characters long.'),
                      onEditingComplete: () {
                        FocusScope.of(context).requestFocus(_w4);
                      },
                    ),
                    WalletTextField(
                      hintText: 'Word 4',
                      focusNode: _w4,
                      onChanged: cubit.onW4Changed,
                      textInputAction: TextInputAction.next,
                      autoCorrect: false,
                      enabled: !isSubmissionInProgress,
                      errorText: w4Error == null
                          ? null
                          : (w4Error == WordValidationError.empty
                              ? 'Word4 can\'t be empty.'
                              : 'Word must be at least three characters long.'),
                      onEditingComplete: () {
                        FocusScope.of(context).requestFocus(_w5);
                      },
                    ),
                    WalletTextField(
                      hintText: 'Word 5',
                      focusNode: _w5,
                      onChanged: cubit.onW5Changed,
                      textInputAction: TextInputAction.next,
                      autoCorrect: false,
                      enabled: !isSubmissionInProgress,
                      errorText: w5Error == null
                          ? null
                          : (w5Error == WordValidationError.empty
                              ? 'Word1 can\'t be empty.'
                              : 'Word must be at least three characters long.'),
                      onEditingComplete: () {
                        FocusScope.of(context).requestFocus(_w6);
                      },
                    ),
                    WalletTextField(
                      hintText: 'Word 6',
                      focusNode: _w6,
                      onChanged: cubit.onW6Changed,
                      textInputAction: TextInputAction.next,
                      autoCorrect: false,
                      enabled: !isSubmissionInProgress,
                      errorText: w6Error == null
                          ? null
                          : (w6Error == WordValidationError.empty
                              ? 'Word6 can\'t be empty.'
                              : 'Word must be at least three characters long.'),
                      onEditingComplete: () {
                        FocusScope.of(context).requestFocus(_w7);
                      },
                    ),
                    WalletTextField(
                      hintText: 'Word 7',
                      focusNode: _w7,
                      onChanged: cubit.onW7Changed,
                      textInputAction: TextInputAction.next,
                      autoCorrect: false,
                      enabled: !isSubmissionInProgress,
                      errorText: w7Error == null
                          ? null
                          : (w7Error == WordValidationError.empty
                              ? 'Word7 can\'t be empty.'
                              : 'Word must be at least three characters long.'),
                      onEditingComplete: () {
                        FocusScope.of(context).requestFocus(_w8);
                      },
                    ),
                    WalletTextField(
                      hintText: 'Word 8',
                      focusNode: _w8,
                      onChanged: cubit.onW8Changed,
                      textInputAction: TextInputAction.next,
                      autoCorrect: false,
                      enabled: !isSubmissionInProgress,
                      errorText: w8Error == null
                          ? null
                          : (w8Error == WordValidationError.empty
                              ? 'Word8 can\'t be empty.'
                              : 'Word must be at least three characters long.'),
                      onEditingComplete: () {
                        FocusScope.of(context).requestFocus(_w9);
                      },
                    ),
                    WalletTextField(
                      hintText: 'Word 9',
                      focusNode: _w9,
                      onChanged: cubit.onW9Changed,
                      textInputAction: TextInputAction.next,
                      autoCorrect: false,
                      enabled: !isSubmissionInProgress,
                      errorText: w9Error == null
                          ? null
                          : (w9Error == WordValidationError.empty
                              ? 'Word9 can\'t be empty.'
                              : 'Word must be at least three characters long.'),
                      onEditingComplete: () {
                        FocusScope.of(context).requestFocus(_w10);
                      },
                    ),
                    WalletTextField(
                      hintText: 'Word 10',
                      focusNode: _w10,
                      onChanged: cubit.onW10Changed,
                      textInputAction: TextInputAction.next,
                      autoCorrect: false,
                      enabled: !isSubmissionInProgress,
                      errorText: w10Error == null
                          ? null
                          : (w10Error == WordValidationError.empty
                              ? 'Word10 can\'t be empty.'
                              : 'Word must be at least three characters long.'),
                      onEditingComplete: () {
                        FocusScope.of(context).requestFocus(_w11);
                      },
                    ),
                    WalletTextField(
                      hintText: 'Word 11',
                      focusNode: _w11,
                      onChanged: cubit.onW11Changed,
                      textInputAction: TextInputAction.next,
                      autoCorrect: false,
                      enabled: !isSubmissionInProgress,
                      errorText: w11Error == null
                          ? null
                          : (w11Error == WordValidationError.empty
                              ? 'Word11 can\'t be empty.'
                              : 'Word must be at least three characters long.'),
                      onEditingComplete: () {
                        FocusScope.of(context).requestFocus(_w12);
                      },
                    ),
                    WalletTextField(
                      hintText: 'Word 12',
                      focusNode: _w12,
                      onChanged: cubit.onW12Changed,
                      onEditingComplete: cubit.onSubmit,
                      autoCorrect: false,
                      enabled: !isSubmissionInProgress,
                      errorText: w12Error == null
                          ? null
                          : (w12Error == WordValidationError.empty
                              ? 'Word12 can\'t be empty.'
                              : 'Word must be at least three characters long.'),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: Spacing.small,
            ),
            isSubmissionInProgress
                ? ExpandedElevatedButton.inProgress(
                    label: 'Recover Wallet',
                  )
                : ExpandedElevatedButton(
                    label: "Recover Wallet",
                    onTap: cubit.onSubmit,
                  ),
          ],
        );
      },
    );
  }
}
