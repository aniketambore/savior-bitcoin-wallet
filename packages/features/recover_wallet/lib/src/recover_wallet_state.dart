part of 'recover_wallet_cubit.dart';

class RecoverWalletState extends Equatable {
  const RecoverWalletState({
    this.w1 = const Word.unvalidated(),
    this.w2 = const Word.unvalidated(),
    this.w3 = const Word.unvalidated(),
    this.w4 = const Word.unvalidated(),
    this.w5 = const Word.unvalidated(),
    this.w6 = const Word.unvalidated(),
    this.w7 = const Word.unvalidated(),
    this.w8 = const Word.unvalidated(),
    this.w9 = const Word.unvalidated(),
    this.w10 = const Word.unvalidated(),
    this.w11 = const Word.unvalidated(),
    this.w12 = const Word.unvalidated(),
    this.submissionStatus = SubmissionStatus.idle,
  });
  final Word w1;
  final Word w2;
  final Word w3;
  final Word w4;
  final Word w5;
  final Word w6;
  final Word w7;
  final Word w8;
  final Word w9;
  final Word w10;
  final Word w11;
  final Word w12;
  final SubmissionStatus submissionStatus;

  RecoverWalletState copyWith({
    Word? w1,
    Word? w2,
    Word? w3,
    Word? w4,
    Word? w5,
    Word? w6,
    Word? w7,
    Word? w8,
    Word? w9,
    Word? w10,
    Word? w11,
    Word? w12,
    SubmissionStatus? submissionStatus,
  }) {
    return RecoverWalletState(
      w1: w1 ?? this.w1,
      w2: w2 ?? this.w2,
      w3: w3 ?? this.w3,
      w4: w4 ?? this.w4,
      w5: w5 ?? this.w5,
      w6: w6 ?? this.w6,
      w7: w7 ?? this.w7,
      w8: w8 ?? this.w8,
      w9: w9 ?? this.w9,
      w10: w10 ?? this.w10,
      w11: w11 ?? this.w11,
      w12: w12 ?? this.w12,
      submissionStatus: submissionStatus ?? this.submissionStatus,
    );
  }

  @override
  List<Object?> get props => [
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
        submissionStatus,
      ];
}

enum SubmissionStatus {
  idle,
  inProgress,
  success,
  genericError,
  invalidMnemonic,
}
