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
