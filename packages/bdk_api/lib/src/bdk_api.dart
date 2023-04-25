import 'package:bdk_flutter/bdk_flutter.dart';
import 'models/models.dart';

class BDKApi {
  late Wallet _wallet;
  late Blockchain _blockchain;

  Future<List<Descriptor>> _getDescriptors(String mnemonic) async {
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
  }

  Future<String> _generateMnemonic() async {
    final mnemonic = await Mnemonic.create(WordCount.Words12);
    return mnemonic.asString();
  }

  Future<void> _initWallet(
    List<Descriptor> descriptors,
    Network network,
  ) async {
    _wallet = await Wallet.create(
      descriptor: descriptors[0],
      changeDescriptor: descriptors[1],
      network: network,
      databaseConfig: const DatabaseConfig.memory(),
    );
    print('[+] Success: [bdk_api.dart | _initWallet');
  }

  Future<String> createWallet({
    Network? network,
    String? recoveryMnemonic,
  }) async {
    print('[+] Running: [bdk_api.dart | createWallet]');
    final mnemonic = recoveryMnemonic ?? await _generateMnemonic();
    try {
      final descriptors = await _getDescriptors(mnemonic);
      _blockchain = await _blockchainInit();
      await _initWallet(descriptors, network ?? Network.Testnet);
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
      final descriptors = await _getDescriptors(mnemonic);
      _blockchain = await _blockchainInit();
      await _initWallet(descriptors, network);
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
          await _wallet.getAddress(addressIndex: const AddressIndex());
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
      final txBuilderResult = await txBuilder
          .addRecipient(script, amount)
          .feeRate(fee)
          .finish(_wallet);
      final sbt = await _wallet.sign(txBuilderResult.psbt);
      final tx = await sbt.extractTx();
      await _blockchain.broadcast(tx);
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
