import 'package:domain_models/domain_models.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:form_fields/form_fields.dart';
import 'package:wallet_repository/wallet_repository.dart';

part 'recover_wallet_state.dart';

class RecoverWalletCubit extends Cubit<RecoverWalletState> {
  RecoverWalletCubit({
    required this.walletRepository,
  }) : super(
          const RecoverWalletState(),
        );
  final WalletRepository walletRepository;

  void onW1Changed(String newValue) {
    final previousWord = state.w1;
    final shouldValidate = previousWord.invalid;
    final newState = state.copyWith(
      w1: shouldValidate
          ? Word.validated(newValue)
          : Word.unvalidated(
              newValue,
            ),
    );
    emit(newState);
  }

  void onW1Unfocused() {
    final newState = state.copyWith(
      w1: Word.validated(
        state.w1.value,
      ),
    );
    emit(newState);
  }

  void onW2Changed(String newValue) {
    final previousWord = state.w2;
    final shouldValidate = previousWord.invalid;
    final newState = state.copyWith(
      w2: shouldValidate
          ? Word.validated(newValue)
          : Word.unvalidated(
              newValue,
            ),
    );
    emit(newState);
  }

  void onW2Unfocused() {
    final newState = state.copyWith(
      w2: Word.validated(
        state.w2.value,
      ),
    );
    emit(newState);
  }

  void onW3Changed(String newValue) {
    final previousWord = state.w3;
    final shouldValidate = previousWord.invalid;
    final newState = state.copyWith(
      w3: shouldValidate
          ? Word.validated(newValue)
          : Word.unvalidated(
              newValue,
            ),
    );
    emit(newState);
  }

  void onW3Unfocused() {
    final newState = state.copyWith(
      w3: Word.validated(
        state.w3.value,
      ),
    );
    emit(newState);
  }

  void onW4Changed(String newValue) {
    final previousWord = state.w4;
    final shouldValidate = previousWord.invalid;
    final newState = state.copyWith(
      w4: shouldValidate
          ? Word.validated(newValue)
          : Word.unvalidated(
              newValue,
            ),
    );
    emit(newState);
  }

  void onW4Unfocused() {
    final newState = state.copyWith(
      w4: Word.validated(
        state.w4.value,
      ),
    );
    emit(newState);
  }

  void onW5Changed(String newValue) {
    final previousWord = state.w5;
    final shouldValidate = previousWord.invalid;
    final newState = state.copyWith(
      w5: shouldValidate
          ? Word.validated(newValue)
          : Word.unvalidated(
              newValue,
            ),
    );
    emit(newState);
  }

  void onW5Unfocused() {
    final newState = state.copyWith(
      w5: Word.validated(
        state.w5.value,
      ),
    );
    emit(newState);
  }

  void onW6Changed(String newValue) {
    final previousWord = state.w6;
    final shouldValidate = previousWord.invalid;
    final newState = state.copyWith(
      w6: shouldValidate
          ? Word.validated(newValue)
          : Word.unvalidated(
              newValue,
            ),
    );
    emit(newState);
  }

  void onW6Unfocused() {
    final newState = state.copyWith(
      w6: Word.validated(
        state.w6.value,
      ),
    );
    emit(newState);
  }

  void onW7Changed(String newValue) {
    final previousWord = state.w7;
    final shouldValidate = previousWord.invalid;
    final newState = state.copyWith(
      w7: shouldValidate
          ? Word.validated(newValue)
          : Word.unvalidated(
              newValue,
            ),
    );
    emit(newState);
  }

  void onW7Unfocused() {
    final newState = state.copyWith(
      w7: Word.validated(
        state.w7.value,
      ),
    );
    emit(newState);
  }

  void onW8Changed(String newValue) {
    final previousWord = state.w8;
    final shouldValidate = previousWord.invalid;
    final newState = state.copyWith(
      w8: shouldValidate
          ? Word.validated(newValue)
          : Word.unvalidated(
              newValue,
            ),
    );
    emit(newState);
  }

  void onW8Unfocused() {
    final newState = state.copyWith(
      w8: Word.validated(
        state.w8.value,
      ),
    );
    emit(newState);
  }

  void onW9Changed(String newValue) {
    final previousWord = state.w9;
    final shouldValidate = previousWord.invalid;
    final newState = state.copyWith(
      w9: shouldValidate
          ? Word.validated(newValue)
          : Word.unvalidated(
              newValue,
            ),
    );
    emit(newState);
  }

  void onW9Unfocused() {
    final newState = state.copyWith(
      w9: Word.validated(
        state.w9.value,
      ),
    );
    emit(newState);
  }

  void onW10Changed(String newValue) {
    final previousWord = state.w10;
    final shouldValidate = previousWord.invalid;
    final newState = state.copyWith(
      w10: shouldValidate
          ? Word.validated(newValue)
          : Word.unvalidated(
              newValue,
            ),
    );
    emit(newState);
  }

  void onW10Unfocused() {
    final newState = state.copyWith(
      w10: Word.validated(
        state.w10.value,
      ),
    );
    emit(newState);
  }

  void onW11Changed(String newValue) {
    final previousWord = state.w11;
    final shouldValidate = previousWord.invalid;
    final newState = state.copyWith(
      w11: shouldValidate
          ? Word.validated(newValue)
          : Word.unvalidated(
              newValue,
            ),
    );
    emit(newState);
  }

  void onW11Unfocused() {
    final newState = state.copyWith(
      w11: Word.validated(
        state.w11.value,
      ),
    );
    emit(newState);
  }

  void onW12Changed(String newValue) {
    final previousWord = state.w12;
    final shouldValidate = previousWord.invalid;
    final newState = state.copyWith(
      w12: shouldValidate
          ? Word.validated(newValue)
          : Word.unvalidated(
              newValue,
            ),
    );
    emit(newState);
  }

  void onW12Unfocused() {
    final newState = state.copyWith(
      w12: Word.validated(
        state.w12.value,
      ),
    );
    emit(newState);
  }

  void onSubmit() async {
    final w1 = Word.validated(state.w1.value);
    final w2 = Word.validated(state.w2.value);
    final w3 = Word.validated(state.w3.value);
    final w4 = Word.validated(state.w4.value);
    final w5 = Word.validated(state.w5.value);
    final w6 = Word.validated(state.w6.value);
    final w7 = Word.validated(state.w7.value);
    final w8 = Word.validated(state.w8.value);
    final w9 = Word.validated(state.w9.value);
    final w10 = Word.validated(state.w10.value);
    final w11 = Word.validated(state.w11.value);
    final w12 = Word.validated(state.w12.value);

    final isFormValid = Formz.validate([
      w1,
      w2,
      w3,
      w4,
      w5,
      w6,
      w7,
      w8,
      w9,
      w10,
      w11,
      w12,
    ]).isValid;

    final newState = state.copyWith(
      w1: w1,
      w2: w2,
      w3: w3,
      w4: w4,
      w5: w5,
      w6: w6,
      w7: w7,
      w8: w8,
      w9: w9,
      w10: w10,
      w11: w11,
      w12: w12,
      submissionStatus: isFormValid ? SubmissionStatus.inProgress : null,
    );

    emit(newState);

    if (isFormValid) {
      final mnemonic =
          '${w1.value} ${w2.value} ${w3.value} ${w4.value} ${w5.value} ${w6.value} ${w7.value} ${w8.value} ${w9.value} ${w10.value} ${w11.value} ${w12.value}';
      print('[+] [recover_wallet_cubit.dart | onSubmit]: $mnemonic');
      try {
        await walletRepository.createWallet(recoveryMnemonic: mnemonic);
        final newState = state.copyWith(
          submissionStatus: SubmissionStatus.success,
        );
        emit(newState);
      } catch (error) {
        final newState = state.copyWith(
          submissionStatus: error is CreateWalletException
              ? SubmissionStatus.invalidMnemonic
              : SubmissionStatus.genericError,
        );
        emit(newState);
      }
    }
  }
}
