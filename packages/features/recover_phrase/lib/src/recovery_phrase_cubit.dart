import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:wallet_repository/wallet_repository.dart';

part 'recovery_phrase_state.dart';

class RecoveryPhraseCubit extends Cubit<RecoveryPhraseState> {
  RecoveryPhraseCubit({
    required this.walletRepository,
  }) : super(
          const RecoveryPhraseInProgress(),
        ) {
    _fetchWalletMnemonic();
  }

  final WalletRepository walletRepository;

  Future<void> _fetchWalletMnemonic() async {
    try {
      final mnemonic = await walletRepository.getWalletMnemonic();
      final mnemonicList = [for (var word in mnemonic!.split(' ')) word];
      emit(
        RecoveryPhraseSuccess(mnemonic: mnemonicList),
      );
    } catch (error) {
      emit(
        const RecoveryPhraseFailure(),
      );
    }
  }

  Future<void> refetch() async {
    emit(
      const RecoveryPhraseInProgress(),
    );

    _fetchWalletMnemonic();
  }
}
