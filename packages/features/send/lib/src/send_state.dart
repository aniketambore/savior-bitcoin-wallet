part of 'send_cubit.dart';

class SendState extends Equatable {
  const SendState({
    this.address = const Address.unvalidated(),
    this.amount = const Amount.unvalidated(),
    this.fee = const Fee.unvalidated(),
    this.submissionStatus = SubmissionStatus.idle,
  });

  final Address address;
  final Amount amount;
  final Fee fee;
  final SubmissionStatus submissionStatus;

  SendState copyWith({
    Address? address,
    Amount? amount,
    Fee? fee,
    SubmissionStatus? submissionStatus,
  }) {
    return SendState(
      address: address ?? this.address,
      amount: amount ?? this.amount,
      fee: fee ?? this.fee,
      submissionStatus: submissionStatus ?? this.submissionStatus,
    );
  }

  @override
  List<Object?> get props => [
        address,
        amount,
        fee,
        submissionStatus,
      ];
}

enum SubmissionStatus {
  idle,
  inProgress,
  success,
  genericError,
  sendTxError,
}
