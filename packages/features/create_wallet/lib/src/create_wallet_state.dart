part of 'create_wallet_cubit.dart';

class CreateWalletState extends Equatable {
  const CreateWalletState({
    this.submissionStatus = SubmissionStatus.idle,
  });

  final SubmissionStatus submissionStatus;

  CreateWalletState copyWith({
    SubmissionStatus? submissionStatus,
  }) {
    return CreateWalletState(
      submissionStatus: submissionStatus ?? this.submissionStatus,
    );
  }

  @override
  List<Object?> get props => [
        submissionStatus,
      ];
}

enum SubmissionStatus {
  idle,
  inProgress,
  success,
  error,
}
