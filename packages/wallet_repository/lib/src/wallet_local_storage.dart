import 'package:key_value_storage/key_value_storage.dart';

class WalletLocalStorage {
  WalletLocalStorage({
    required this.keyValueStorage,
  });

  final KeyValueStorage keyValueStorage;
  static const _balanceBoxKey = 'wallet-balance';

  Future<void> upsertWalletBalance(BalanceCM balance) async {
    final box = await keyValueStorage.balanceBox;
    return box.put(
      _balanceBoxKey,
      balance,
    );
  }

  Future<void> clear() async {
    await Future.wait([
      keyValueStorage.balanceBox.then(
        (box) => box.clear(),
      ),
    ]);
  }

  Future<BalanceCM?> getWalletBalance() async {
    final box = await keyValueStorage.balanceBox;
    return box.get(_balanceBoxKey);
  }
}
