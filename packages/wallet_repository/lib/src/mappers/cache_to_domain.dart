import 'package:domain_models/domain_models.dart';
import 'package:key_value_storage/key_value_storage.dart';

extension BalanceCMtoDomain on BalanceCM {
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

extension TxListCMtoDomain on TxListCM {
  TxList toDomainModel() {
    return TxList(
      txList: txList
          .map(
            (tx) => tx.toDomainModel(),
          )
          .toList(),
    );
  }
}

extension TxCMtoDomain on TxCM {
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

extension BlockTimeCMtoDomain on BlockTimeCM {
  BlockTime toDomainModel() {
    return BlockTime(
      height: height,
      timestamp: timestamp,
    );
  }
}
