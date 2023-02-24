import 'package:bdk_api/bdk_api.dart';
import 'package:domain_models/domain_models.dart';

extension WalletBalanceRMtoDomain on BalanceRM {
  Balance toDomainModel() {
    return Balance(
      immature: immature,
      trustedPending: trustedPending,
      untrustedPending: untrustedPending,
      confirmed: confirmed,
      spendable: spendable,
      total: total,
    );
  }
}

extension TxListRMtoDomain on TxListRM {
  TxList toDomainModel() {
    return TxList(
        txList: txList
            .map(
              (tx) => tx.toDomainModel(),
            )
            .toList());
  }
}

extension TxRMtoDomain on TxRM {
  Tx toDomainModel() {
    return Tx(
      txid: txid,
      received: received,
      sent: sent,
      fee: fee,
      confirmationTime: confirmationTime?.toDomainModel(),
    );
  }
}

extension BlockTimeRMtoDomain on BlockTimeRM {
  BlockTime toDomainModel() {
    return BlockTime(
      height: height,
      timestamp: timestamp,
    );
  }
}
