part of 'send_cubit.dart';

class SendState extends Equatable {
  const SendState({
    this.address = const Address.unvalidated(),
    this.amount = const Amount.unvalidated(),
    this.fee = const Fee.unvalidated(),
    this.submissionStatus = SubmissionStatus.idle,
    this.estimatingFeeStatus = EstimatingFeeStatus.idle,
  });

  final Address address;
  final Amount amount;
  final Fee fee;
  final SubmissionStatus submissionStatus;
  final EstimatingFeeStatus estimatingFeeStatus;

  SendState copyWith({
    Address? address,
    Amount? amount,
    Fee? fee,
    SubmissionStatus? submissionStatus,
    EstimatingFeeStatus? estimatingFeeStatus,
  }) {
    return SendState(
      address: address ?? this.address,
      amount: amount ?? this.amount,
      fee: fee ?? this.fee,
      submissionStatus: submissionStatus ?? this.submissionStatus,
      estimatingFeeStatus: estimatingFeeStatus ?? this.estimatingFeeStatus,
    );
  }

  @override
  List<Object?> get props => [
        address,
        amount,
        fee,
        submissionStatus,
        estimatingFeeStatus,
      ];
}

enum SubmissionStatus {
  idle,
  inProgress,
  success,
  genericError,
  sendTxError,
}

enum EstimatingFeeStatus {
  idle,
  inProgress,
  genericError,
}
