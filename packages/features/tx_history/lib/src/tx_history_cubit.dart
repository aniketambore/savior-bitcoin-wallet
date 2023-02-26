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
    _fetchTxList(fetchPolicy: WalletSyncFetchPolicy.cacheAndNetwork);
  }

  final WalletRepository walletRepository;

  Future<void> _fetchTxList({
    required WalletSyncFetchPolicy fetchPolicy,
  }) async {
    final txListStream =
        walletRepository.getTransaction(fetchPolicy: fetchPolicy);
    try {
      await for (final newTxList in txListStream) {
        emit(
          TxHistorySuccess(
            txList: newTxList,
            syncStatus: SyncStatus.success,
          ),
        );
      }
    } catch (error) {
      final lastState = state;
      if (lastState is TxHistorySuccess) {
        emit(
          TxHistorySuccess(
            txList: lastState.txList,
            syncStatus: SyncStatus.error,
          ),
        );
      } else {
        emit(const TxHistoryFailure());
      }
    }
  }

  Future<void> refetch() async {
    emit(
      const TxHistoryInProgress(),
    );

    _fetchTxList(
      fetchPolicy: WalletSyncFetchPolicy.cacheAndNetwork,
    );
  }

  Future<void> refresh() async {
    final lastState = state;
    if (lastState is TxHistorySuccess) {
      emit(
        TxHistorySuccess(
          txList: lastState.txList,
          syncStatus: SyncStatus.inProgress,
        ),
      );

      _fetchTxList(
        fetchPolicy: WalletSyncFetchPolicy.networkOnly,
      );
    }
  }
}
