import 'package:hive/hive.dart';

part 'balance_cm.g.dart';

@HiveType(typeId: 0)
class BalanceCM {
  const BalanceCM({
    required this.immature,
    required this.trustedPending,
    required this.untrustedPending,
    required this.confirmed,
    required this.spendable,
    required this.total,
  });

  @HiveField(0)
  final int immature;
  @HiveField(1)
  final int trustedPending;
  @HiveField(2)
  final int untrustedPending;
  @HiveField(3)
  final int confirmed;
  @HiveField(4)
  final int spendable;
  @HiveField(5)
  final int total;
}
