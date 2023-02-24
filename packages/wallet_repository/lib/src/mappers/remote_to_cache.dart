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
