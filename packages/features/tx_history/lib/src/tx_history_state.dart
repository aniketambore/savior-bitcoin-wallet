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
    this.txListError,
  });

  final TxList txList;
  final dynamic txListError;

  @override
  List<Object?> get props => [
        txList,
        txListError,
      ];
}

class TxHistoryFailure extends TxHistoryState {
  const TxHistoryFailure();

  @override
  List<Object?> get props => [];
}
