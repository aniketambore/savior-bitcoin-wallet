import 'package:bdk_flutter/bdk_flutter.dart';
import 'package:json_annotation/json_annotation.dart';
part 'tx_list_rm.g.dart';

class TxListRM {
  const TxListRM({
    required this.txList,
  });

  final List<TxRM> txList;

  factory TxListRM.fromJson(List<TransactionDetails> list) => TxListRM(
        txList: (list)
            .map(
              (tx) => TxRM.fromJson(
                {
                  'txid': tx.txid,
                  'received': tx.received,
                  'sent': tx.sent,
                  'fee': tx.fee,
                  'confirmationTime': {
                    'height': tx.confirmationTime?.height,
                    'timestamp': tx.confirmationTime?.timestamp
                  },
                },
              ),
            )
            .toList(),
      );
}

@JsonSerializable(createToJson: false)
class TxRM {
  const TxRM({
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
  final BlockTimeRM? confirmationTime;

  static const fromJson = _$TxRMFromJson;
}

@JsonSerializable(createToJson: false)
class BlockTimeRM {
  const BlockTimeRM({
    this.height,
    this.timestamp,
  });

  final int? height;
  final int? timestamp;

  static const fromJson = _$BlockTimeRMFromJson;
}
