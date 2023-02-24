import 'package:equatable/equatable.dart';

class TxList extends Equatable {
  const TxList({
    required this.txList,
  });

  final List<Tx> txList;

  @override
  List<Object?> get props => [
        txList,
      ];
}

class Tx extends Equatable {
  const Tx({
    required this.txid,
    required this.received,
    required this.sent,
    this.fee,
    this.confirmationTime,
  });

  final String txid;
  final int received;
  final int sent;
  final int? fee;
  final BlockTime? confirmationTime;

  @override
  List<Object?> get props => [
        txid,
        received,
        sent,
        fee,
        confirmationTime,
      ];
}

class BlockTime extends Equatable {
  const BlockTime({
    this.height,
    this.timestamp,
  });

  final int? height;
  final int? timestamp;

  @override
  List<Object?> get props => [
        height,
        timestamp,
      ];
}
