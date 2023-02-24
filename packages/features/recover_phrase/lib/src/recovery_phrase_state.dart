part of 'recovery_phrase_cubit.dart';

abstract class RecoveryPhraseState extends Equatable {
  const RecoveryPhraseState();
}

class RecoveryPhraseInProgress extends RecoveryPhraseState {
  const RecoveryPhraseInProgress();

  @override
  List<Object?> get props => [];
}

class RecoveryPhraseSuccess extends RecoveryPhraseState {
  const RecoveryPhraseSuccess({
    required this.mnemonic,
    this.recoverPhraseError,
  });

  final List<String> mnemonic;
  final dynamic recoverPhraseError;

  @override
  List<Object?> get props => [
        mnemonic,
        recoverPhraseError,
      ];
}

class RecoveryPhraseFailure extends RecoveryPhraseState {
  const RecoveryPhraseFailure();

  @override
  List<Object?> get props => [];
}
