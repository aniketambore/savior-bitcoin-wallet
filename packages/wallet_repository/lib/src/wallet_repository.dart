import 'package:bdk_api/bdk_api.dart';
import 'package:domain_models/domain_models.dart';
import 'package:key_value_storage/key_value_storage.dart';
import 'package:rxdart/rxdart.dart';
import 'package:wallet_repository/src/mappers/mappers.dart';
import 'wallet_local_storage.dart';

import 'wallet_secure_storage.dart';
import 'package:meta/meta.dart';

class WalletRepository {
  WalletRepository({
    required KeyValueStorage keyValueStorage,
    required this.bdkApi,
    @visibleForTesting WalletSecureStorage? secureStorage,
    @visibleForTesting WalletLocalStorage? localStorage,
  })  : _secureStorage = secureStorage ?? const WalletSecureStorage(),
        _localStorage = localStorage ??
            WalletLocalStorage(
              keyValueStorage: keyValueStorage,
            );

  final BDKApi bdkApi;
  final WalletLocalStorage _localStorage;
  final WalletSecureStorage _secureStorage;
  final BehaviorSubject<String?> _walletSubject = BehaviorSubject();

  Future<void> createWallet({String? recoveryMnemonic}) async {
    try {
      final bdk = await bdkApi.createWallet(recoveryMnemonic: recoveryMnemonic);

      await _secureStorage.upsertWalletMnemonic(mnemonic: bdk);

      _walletSubject.add(bdk);
    } catch (error) {
      if (error is CreateWalletBdkException) {
        throw CreateWalletException();
      } else if (error is BlockchainBdkException) {
        throw BlockchainException();
      }
      rethrow;
    }
  }

  Future<void> recoverWallet(String mnemonic) async {
    try {
      await bdkApi.recoverWallet(
        mnemonic,
        Network.Testnet,
      );
    } catch (error) {
      if (error is RecoverWalletBdkException) {
        throw RecoverWalletException();
      } else if (error is BlockchainBdkException) {
        throw BlockchainException();
      }
      rethrow;
    }
  }

  Stream<String?> getWallet() async* {
    if (!_walletSubject.hasValue) {
      final walletInfo = await Future.wait([
        _secureStorage.getWalletMnemonic(),
      ]);

      final mnemonic = walletInfo[0];

      if (mnemonic != null) {
        _walletSubject.add(mnemonic);
      } else {
        _walletSubject.add(null);
      }
    }

    yield* _walletSubject.stream;
  }

  Future<String?> getWalletMnemonic() {
    return _secureStorage.getWalletMnemonic();
  }

  Future<String> getAddress() {
    try {
      final address = bdkApi.getAddress();
      return address;
    } on GetAddressBdkException catch (_) {
      throw GetAddressException();
    }
  }

  Stream<Balance> getBalance({
    required WalletSyncFetchPolicy fetchPolicy,
  }) async* {
    final isFetchPolicyNetworkOnly =
        fetchPolicy == WalletSyncFetchPolicy.networkOnly;

    if (isFetchPolicyNetworkOnly) {
      final balance = await _getBalanceFromApi();
      yield balance;
    } else {
      final cachedBalance = await _localStorage.getWalletBalance();
      final isFetchPolicyCacheAndNetwork =
          fetchPolicy == WalletSyncFetchPolicy.cacheAndNetwork;

      final isFetchPolicyCachePreferably =
          fetchPolicy == WalletSyncFetchPolicy.cachePreferably;

      final shouldEmitCachedBalanceInAdvance =
          isFetchPolicyCachePreferably || isFetchPolicyCacheAndNetwork;

      if (shouldEmitCachedBalanceInAdvance && cachedBalance != null) {
        yield cachedBalance.toDomainModel();
        if (isFetchPolicyCachePreferably) {
          return;
        }
      }

      try {
        final freshBalance = await _getBalanceFromApi();
        yield freshBalance;
      } catch (_) {
        final isFetchPolicyNetworkPreferably =
            fetchPolicy == WalletSyncFetchPolicy.networkPreferably;
        if (cachedBalance != null && isFetchPolicyNetworkPreferably) {
          yield cachedBalance.toDomainModel();
          return;
        }
        rethrow;
      }
    }
  }

  Future<Balance> _getBalanceFromApi() async {
    try {
      final apiBalance = await bdkApi.getBalance();
      final cacheBalance = apiBalance.toCacheModel();
      await _localStorage.upsertWalletBalance(cacheBalance);
      final domainBalance = apiBalance.toDomainModel();
      return domainBalance;
    } on SyncWalletBdkException catch (_) {
      throw SyncWalletException();
    }
  }

  Future<void> sendTx({
    required String addressStr,
    required int amount,
    required double fee,
  }) async {
    try {
      await bdkApi.sendTx(
        addressStr: addressStr,
        amount: amount,
        fee: fee,
      );
    } catch (e) {
      if (e is SendTxBdkException) {
        throw SendTxException();
      }
      rethrow;
    }
  }

  Future<TxList> getTransactions() async {
    try {
      final txListRM = await bdkApi.getTransactions();
      final txList = txListRM.toDomainModel();
      return txList;
    } on ListTxBdkException catch (_) {
      throw ListTxException();
    }
  }
}

enum WalletSyncFetchPolicy {
  cacheAndNetwork,
  networkOnly,
  networkPreferably,
  cachePreferably,
}
