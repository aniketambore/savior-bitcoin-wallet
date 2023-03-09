import 'package:bdk_flutter/bdk_flutter.dart';
import 'models/models.dart';

class BDKApi {
  late Wallet _wallet;
  late Blockchain _blockchain;

  Future<List<Descriptor>> _getDescriptors({
    required String mnemonic,
  }) async {
    print('[+] Running: [bdk_api.dart | _getDescriptor]');
    final descriptors = <Descriptor>[];
    for (var e in [KeychainKind.External, KeychainKind.Internal]) {
      final mnemonicObj = await Mnemonic.fromString(mnemonic);
      final descriptorSecretKey = await DescriptorSecretKey.create(
        network: Network.Testnet,
        mnemonic: mnemonicObj,
      );
      final descriptor = await Descriptor.newBip84(
        secretKey: descriptorSecretKey,
        network: Network.Testnet,
        keychain: e,
      );
      descriptors.add(descriptor);
    }
    return descriptors;
  }

  Future<Blockchain> _blockchainInit() async {
    print('[+] Running: [bdk_api.dart | _blockchainInit]');
    try {
      final blockchain = await Blockchain.create(
        config: BlockchainConfig.electrum(
          config: ElectrumConfig(
            stopGap: 10,
            timeout: 5,
            retry: 5,
            url: "ssl://electrum.blockstream.info:60002",
            validateDomain: false,
          ),
        ),
      );
      return blockchain;
    } catch (e) {
      print('[!] Error: [bdk_api.dart | _blockchainInit]: $e');
      throw BlockchainBdkException();
    }
  }

  Future<String> _generateMnemonic() async {
    final mnemonic = await Mnemonic.create(WordCount.Words12);
    return mnemonic.asString();
  }

  Future<String> createWallet({
    Network? network,
    String? recoveryMnemonic,
  }) async {
    print('[+] Running: [bdk_api.dart | createWallet]');
    late String mnemonic;
    if (recoveryMnemonic != null) {
      mnemonic = recoveryMnemonic;
    } else {
      mnemonic = await _generateMnemonic();
    }
    try {
      final descriptors = await _getDescriptors(mnemonic: mnemonic);
      _blockchain = await _blockchainInit();
      _wallet = await Wallet.create(
        descriptor: descriptors[0],
        changeDescriptor: descriptors[1],
        network: network ?? Network.Testnet,
        databaseConfig: const DatabaseConfig.memory(),
      );
      print('[+] Success: [bdk_api.dart | createWallet');
      print('[+] Mnemonic: [bdk_api.dart | $mnemonic');
      return mnemonic;
    } catch (e) {
      print('[!] Error: [bdk_api.dart | createWallet]: $e');
      throw CreateWalletBdkException();
    }
  }

  Future<void> recoverWallet(String mnemonic, Network network) async {
    print('[+] Running: [bdk_api.dart | recoverWallet]');
    try {
      final descriptors = await _getDescriptors(mnemonic: mnemonic);
      _blockchain = await _blockchainInit();
      _wallet = await Wallet.create(
        descriptor: descriptors[0],
        changeDescriptor: descriptors[1],
        network: network,
        databaseConfig: const DatabaseConfig.memory(),
      );
      print('[+] Success: [bdk_api.dart | recoverWallet]');
    } catch (e) {
      print('[!] Error: [bdk_api.dart | recoverWallet]: $e');
      throw RecoverWalletBdkException();
    }
  }

  Future<String> getAddress() async {
    print('[+] Running: [bdk_api.dart | getAddress]');
    try {
      final addressInfo =
          await _wallet.getAddress(addressIndex: AddressIndex.New);
      print('[+] Address: ${addressInfo.address}');
      return addressInfo.address;
    } catch (e) {
      print('[!] Error: [bdk_api.dart | getAddress]: $e');
      throw GetAddressBdkException();
    }
  }

  Future<BalanceRM> getBalance() async {
    print('[+] Running: [bdk_api.dart | syncWallet]');
    try {
      _wallet.sync(_blockchain);
      final balance = await _wallet.getBalance();
      final balanceRM = BalanceRM(
        immature: balance.immature,
        trustedPending: balance.trustedPending,
        untrustedPending: balance.untrustedPending,
        confirmed: balance.confirmed,
        spendable: balance.spendable,
        total: balance.total,
      );
      return balanceRM;
    } catch (e) {
      print('[!] Error: [bdk_api.dart | syncWallet]: $e');
      throw SyncWalletBdkException();
    }
  }

  Future<void> sendTx({
    required String addressStr,
    required int amount,
    required double fee,
  }) async {
    print('[+] Running: [bdk_api.dart | sendTx]');
    try {
      final txBuilder = TxBuilder();
      final address = await Address.create(address: addressStr);
      final script = await address.scriptPubKey();
      final psbt = await txBuilder
          .addRecipient(script, amount)
          .feeRate(fee)
          .finish(_wallet);
      final sbt = await _wallet.sign(psbt);
      await _blockchain.broadcast(sbt);
    } catch (e) {
      print('[!] Error: [bdk_api.dart | sendTx]: ${e.runtimeType}');
      throw SendTxBdkException();
    }
  }

  Future<TxListRM> getTransactions() async {
    print('[+] Running: [bdk_api.dart | getTransaction]');
    try {
      _wallet.sync(_blockchain);
      final response = await _wallet.listTransactions();
      final txList = TxListRM.fromJson(response);

      return txList;
    } catch (e) {
      print('[!] Error: [bdk_api.dart | getTransaction]: $e');
      throw ListTxBdkException();
    }
  }
}
