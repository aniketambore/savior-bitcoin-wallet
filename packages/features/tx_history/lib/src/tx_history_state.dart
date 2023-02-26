part of 'tx_history_cubit.dart';

abstract class TxHistoryState extends Equatable {
  const TxHistoryState();

  @override
  List<Object?> get props => [];
}

class TxHistoryInProgress extends TxHistoryState {
  const TxHistoryInProgress();

  @override
  List<Object?> get props => [];
}

class TxHistorySuccess extends TxHistoryState {
  const TxHistorySuccess({
    required this.txList,
    this.syncStatus = SyncStatus.success,
  });

  final TxList txList;
  final SyncStatus syncStatus;

  @override
  List<Object?> get props => [
        txList,
        syncStatus,
      ];
}

class TxHistoryFailure extends TxHistoryState {
  const TxHistoryFailure();

  @override
  List<Object?> get props => [];
}

enum SyncStatus {
  idle,
  inProgress,
  success,
  error,
}
