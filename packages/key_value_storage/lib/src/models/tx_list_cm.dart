import 'package:hive/hive.dart';

part 'tx_list_cm.g.dart';

@HiveType(typeId: 1)
class TxListCM {
  const TxListCM({
    required this.txList,
  });

  @HiveField(0)
  final List<TxCM> txList;
}

@HiveType(typeId: 2)
class TxCM {
  const TxCM({
    required this.txid,
    required this.received,
    required this.sent,
    this.fee,
    this.confirmationTime,
  });

  @HiveField(0)
  final String txid;
  @HiveField(1)
  final int received;
  @HiveField(2)
  final int sent;
  @HiveField(3)
  final int? fee;
  @HiveField(4)
  final BlockTimeCM? confirmationTime;
}

@HiveType(typeId: 3)
class BlockTimeCM {
  const BlockTimeCM({
    this.height,
    this.timestamp,
  });

  @HiveField(0)
  final int? height;
  @HiveField(1)
  final int? timestamp;
}
