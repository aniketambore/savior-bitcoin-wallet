import 'package:bdk_api/bdk_api.dart';
import 'package:key_value_storage/key_value_storage.dart';

extension BalanceRMtoCM on BalanceRM {
  BalanceCM toCacheModel() {
    return BalanceCM(
      immature: immature,
      trustedPending: trustedPending,
      untrustedPending: untrustedPending,
      confirmed: confirmed,
      spendable: spendable,
      total: total,
    );
  }
}

extension TxListRMtoCM on TxListRM {
  TxListCM toCacheModel() {
    return TxListCM(
      txList: txList
          .map(
            (tx) => tx.toCacheModel(),
          )
          .toList(),
    );
  }
}

extension TxRMtoCM on TxRM {
  TxCM toCacheModel() {
    return TxCM(
      txid: txid,
      received: received,
      sent: sent,
      fee: fee,
      confirmationTime: confirmationTime?.toCacheModel(),
    );
  }
}

extension BlockTimeRMtoCM on BlockTimeRM {
  BlockTimeCM toCacheModel() {
    return BlockTimeCM(
      height: height,
      timestamp: timestamp,
    );
  }
}
