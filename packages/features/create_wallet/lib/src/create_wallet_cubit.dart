import 'package:domain_models/domain_models.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallet_repository/wallet_repository.dart';

part 'create_wallet_state.dart';

class CreateWalletCubit extends Cubit<CreateWalletState> {
  CreateWalletCubit({
    required this.walletRepository,
  }) : super(
          const CreateWalletState(),
        );

  final WalletRepository walletRepository;

  void onCreateWalletSubmit() async {
    final newState = state.copyWith(
      submissionStatus: SubmissionStatus.inProgress,
    );
    emit(newState);

    try {
      await walletRepository.createWallet();
      final newState = state.copyWith(
        submissionStatus: SubmissionStatus.success,
      );
      emit(newState);
    } catch (error) {
      final newState = state.copyWith(
        submissionStatus:
            (error is CreateWalletException) || (error is BlockchainException)
                ? SubmissionStatus.error
                : SubmissionStatus.idle,
      );

      emit(newState);
    }
  }
}
