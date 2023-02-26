import 'package:path_provider/path_provider.dart';
import 'package:meta/meta.dart';
import 'package:key_value_storage/key_value_storage.dart';

class KeyValueStorage {
  static const _balanceBoxKey = 'wallet-balance';
  static const _txListBoxKey = 'tx-list';

  KeyValueStorage({
    @visibleForTesting HiveInterface? hive,
  }) : _hive = hive ?? Hive {
    try {
      _hive
        ..registerAdapter(BalanceCMAdapter())
        ..registerAdapter(TxListCMAdapter())
        ..registerAdapter(TxCMAdapter())
        ..registerAdapter(BlockTimeCMAdapter());
    } catch (_) {
      throw Exception(
          'You shouldn\'t have more than one [KeyValueStorage] instance in your '
          'project');
    }
  }
  final HiveInterface _hive;

  Future<Box<BalanceCM>> get balanceBox => _openHiveBox<BalanceCM>(
        _balanceBoxKey,
        isTemporary: true,
      );

  Future<Box<TxListCM>> get txListBox => _openHiveBox<TxListCM>(
        _txListBoxKey,
        isTemporary: true,
      );

  Future<Box<T>> _openHiveBox<T>(
    String boxKey, {
    required bool isTemporary,
  }) async {
    if (_hive.isBoxOpen(boxKey)) {
      return _hive.box(boxKey);
    } else {
      final directory = await (isTemporary
          ? getTemporaryDirectory()
          : getApplicationDocumentsDirectory());
      return _hive.openBox<T>(
        boxKey,
        path: directory.path,
      );
    }
  }
}
