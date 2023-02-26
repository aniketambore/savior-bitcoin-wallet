import 'package:key_value_storage/key_value_storage.dart';

class WalletLocalStorage {
  WalletLocalStorage({
    required this.keyValueStorage,
  });

  final KeyValueStorage keyValueStorage;
  static const _balanceBoxKey = 'wallet-balance';
  static const _txListBoxKey = 'tx-list';

  Future<void> upsertWalletBalance(BalanceCM balance) async {
    final box = await keyValueStorage.balanceBox;
    return box.put(
      _balanceBoxKey,
      balance,
    );
  }

  Future<void> upsertTxList(TxListCM txList) async {
    final box = await keyValueStorage.txListBox;
    return box.put(
      _txListBoxKey,
      txList,
    );
  }

  Future<void> clearWalletBalance() async {
    final box = await keyValueStorage.balanceBox;
    await box.clear();
  }

  Future<void> clearTxList() async {
    final box = await keyValueStorage.txListBox;
    await box.clear();
  }

  Future<void> clear() async {
    await Future.wait([
      keyValueStorage.balanceBox.then(
        (box) => box.clear(),
      ),
      keyValueStorage.txListBox.then(
        (box) => box.clear(),
      ),
    ]);
  }

  Future<BalanceCM?> getWalletBalance() async {
    final box = await keyValueStorage.balanceBox;
    return box.get(_balanceBoxKey);
  }

  Future<TxListCM?> getTxList() async {
    final box = await keyValueStorage.txListBox;
    return box.get(_txListBoxKey);
  }
}
