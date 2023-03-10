import 'package:equatable/equatable.dart';

class Balance extends Equatable {
  const Balance({
    required this.immature,
    required this.trustedPending,
    required this.untrustedPending,
    required this.confirmed,
    required this.spendable,
    required this.total,
  });

  final int immature;

  /// Unconfirmed UTXOs generated by a wallet tx
  final int trustedPending;

  /// Unconfirmed UTXOs received from an external wallet
  final int untrustedPending;

  /// Confirmed and immediately spendable balance
  final int confirmed;

  /// Get sum of trusted_pending and confirmed coins
  final int spendable;

  /// Get the whole balance visible to the wallet
  final int total;

  @override
  List<Object?> get props => [
        immature,
        trustedPending,
        untrustedPending,
        confirmed,
        spendable,
        total,
      ];
}
