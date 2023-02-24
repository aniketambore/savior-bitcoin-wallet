import 'package:domain_models/domain_models.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_fields/form_fields.dart';
import 'package:wallet_repository/wallet_repository.dart';

part 'send_state.dart';

class SendCubit extends Cubit<SendState> {
  SendCubit({
    required this.walletRepository,
  }) : super(
          const SendState(),
        );

  final WalletRepository walletRepository;

  void onAddressChanged(String newValue) {
    final previousAddress = state.address;
    final shouldValidate = previousAddress.invalid;
    final newState = state.copyWith(
      address: shouldValidate
          ? Address.validated(
              newValue,
            )
          : Address.unvalidated(
              newValue,
            ),
    );
    emit(newState);
  }

  void onAddressUnfocused() {
    final newState = state.copyWith(
      address: Address.validated(
        state.address.value,
      ),
    );

    emit(newState);
  }

  void onAmountChanged(int newValue) {
    final previousAmount = state.amount;
    final shouldValidate = previousAmount.invalid;
    final newState = state.copyWith(
      amount: shouldValidate
          ? Amount.validated(
              newValue,
            )
          : Amount.unvalidated(
              newValue,
            ),
    );
    emit(newState);
  }

  void onAmountUnfocused() {
    final newState = state.copyWith(
      amount: Amount.validated(
        state.amount.value,
      ),
    );

    emit(newState);
  }

  void onFeeChanged(double newValue) {
    final previousFee = state.fee;
    final shouldValidate = previousFee.invalid;
    final newState = state.copyWith(
      fee: shouldValidate
          ? Fee.validated(
              newValue,
            )
          : Fee.unvalidated(
              newValue,
            ),
    );
    emit(newState);
  }

  void onFeeUnfocused() {
    final newState = state.copyWith(
      fee: Fee.validated(
        state.fee.value,
      ),
    );

    emit(newState);
  }

  void onSubmit() async {
    final address = Address.validated(
      state.address.value,
    );

    final amount = Amount.validated(
      state.amount.value,
    );

    final fee = Fee.validated(
      state.fee.value,
    );

    final isFormValid = Formz.validate([
          address,
          amount,
          fee,
        ]) ==
        FormzStatus.valid;

    final newState = state.copyWith(
      address: address,
      amount: amount,
      fee: fee,
      submissionStatus: isFormValid ? SubmissionStatus.inProgress : null,
    );

    emit(newState);

    if (isFormValid) {
      try {
        await walletRepository.sendTx(
          addressStr: address.value,
          amount: amount.value,
          fee: fee.value,
        );
        final newState = state.copyWith(
          submissionStatus: SubmissionStatus.success,
        );
        emit(newState);
      } catch (error) {
        final newState = state.copyWith(
          submissionStatus: error is SendTxException
              ? SubmissionStatus.sendTxError
              : SubmissionStatus.genericError,
        );
        emit(newState);
      }
    }
  }
}
