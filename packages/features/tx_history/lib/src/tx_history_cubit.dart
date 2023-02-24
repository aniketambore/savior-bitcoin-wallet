import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallet_repository/wallet_repository.dart';
import 'package:domain_models/domain_models.dart';

part 'tx_history_state.dart';

class TxHistoryCubit extends Cubit<TxHistoryState> {
  TxHistoryCubit({
    required this.walletRepository,
  }) : super(
          const TxHistoryInProgress(),
        ) {
    _fetchTxList();
  }

  final WalletRepository walletRepository;

  Future<void> _fetchTxList() async {
    try {
      final txList = await walletRepository.getTransactions();
      emit(
        TxHistorySuccess(txList: txList),
      );
    } catch (error) {
      emit(
        const TxHistoryFailure(),
      );
    }
  }

  Future<void> refetch() async {
    emit(
      const TxHistoryInProgress(),
    );

    _fetchTxList();
  }
}
