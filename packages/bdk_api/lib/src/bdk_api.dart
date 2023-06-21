// ignore_for_file: avoid_print

import 'package:bdk_flutter/bdk_flutter.dart';
import 'models/models.dart';

class BDKApi {
  late Wallet _wallet;
  Blockchain? _blockchain;

  Future<List<Descriptor>> _createDescriptors(String mnemonic) async {
    print('[BDK API] Creating descriptors...');
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
    print('[BDK API] Descriptors created successfully');
    return descriptors;
  }

  Future<Blockchain> _blockchainInit() async {
    print('[BDK API] Initializing blockchain...');
    final blockchain = await Blockchain.create(
      config: const BlockchainConfig.electrum(
        config: ElectrumConfig(
          stopGap: 10,
          timeout: 5,
          retry: 5,
          url: "ssl://electrum.blockstream.info:60002",
          validateDomain: false,
        ),
      ),
    );
    print('[BDK API] Blockchain initialized successfully');
    return blockchain;
  }

  Future<String> _generateMnemonic() async {
    print('[BDK API] Generating mnemonic...');
    final mnemonic = await Mnemonic.create(WordCount.Words12);
    return mnemonic.asString();
  }

  Future<void> _initializeBlockchainAndWallet(
    String mnemonic,
    Network network,
  ) async {
    print('[BDK API] Initializing blockchain and wallet...');
    final descriptors = await _createDescriptors(mnemonic);
    await _initWallet(descriptors, network);
    _blockchain = await _blockchainInit();
    print('[BDK API] Blockchain and wallet initialized successfully');
  }

  Future<void> _initWallet(
    List<Descriptor> descriptors,
    Network network,
  ) async {
    print('[BDK API] Initializing wallet...');
    _wallet = await Wallet.create(
      descriptor: descriptors[0],
      changeDescriptor: descriptors[1],
      network: network,
      databaseConfig: const DatabaseConfig.memory(),
    );
  }

  Future<String> createWallet({
    Network? network,
    String? recoveryMnemonic,
  }) async {
    print('[BDK API] Creating wallet...');
    final mnemonic = recoveryMnemonic ?? await _generateMnemonic();
    try {
      await _initializeBlockchainAndWallet(
        mnemonic,
        network ?? Network.Testnet,
      );
      print('[BDK API] Wallet created successfully');
      print('[BDK API] Mnemonic: $mnemonic');
      return mnemonic;
    } catch (e) {
      print('[BDK API] Error creating wallet: $e');
      throw CreateWalletBdkException();
    }
  }

  Future<void> recoverWallet(String mnemonic, Network network) async {
    print('[BDK API] Recovering wallet...');
    try {
      await _initializeBlockchainAndWallet(mnemonic, network);
      print('[BDK API] Wallet recovered successfully');
    } catch (e) {
      print('[BDK API] Error recovering wallet: $e');
      throw RecoverWalletBdkException();
    }
  }

  Future<String> getAddress() async {
    print('[BDK API] Getting address...');
    try {
      final addressInfo =
          await _wallet.getAddress(addressIndex: const AddressIndex());
      print('[BDK API] Address: ${addressInfo.address}');
      return addressInfo.address;
    } catch (e) {
      print('[BDK API] Error getting address: $e');
      throw GetAddressBdkException();
    }
  }

  Future<BalanceRM> getBalance() async {
    print('[BDK API] Getting balance...');
    try {
      _blockchain ??= await _blockchainInit();
      _wallet.sync(_blockchain!);
      final balance = await _wallet.getBalance();
      final balanceRM = BalanceRM(
        immature: balance.immature,
        trustedPending: balance.trustedPending,
        untrustedPending: balance.untrustedPending,
        confirmed: balance.confirmed,
        spendable: balance.spendable,
        total: balance.total,
      );
      print('[BDK API] Balance retrieved successfully');
      return balanceRM;
    } catch (e) {
      print('[BDK API] Error getting balance: $e');
      throw SyncWalletBdkException();
    }
  }

  Future<void> sendTx({
    required String addressStr,
    required int amount,
    required double fee,
  }) async {
    print('[BDK API] Sending transaction...');
    try {
      final txBuilder = TxBuilder();
      final address = await Address.create(address: addressStr);
      final script = await address.scriptPubKey();
      final txBuilderResult = await txBuilder
          .addRecipient(script, amount)
          .feeRate(fee)
          .finish(_wallet);
      final sbt = await _wallet.sign(psbt: txBuilderResult.psbt);
      final tx = await sbt.extractTx();
      _blockchain ??= await _blockchainInit();
      await _blockchain!.broadcast(tx);
      print('[BDK API] Transaction sent successfully');
    } catch (e) {
      print('[BDK API] Error sending transaction: ${e.runtimeType}');
      throw SendTxBdkException();
    }
  }

  Future<TxListRM> getTransactions() async {
    print('[BDK API] Getting transactions...');
    try {
      _blockchain ??= await _blockchainInit();
      _wallet.sync(_blockchain!);
      final response = await _wallet.listTransactions(true);
      final txList = TxListRM.fromJson(response);
      print('[BDK API] Transactions retrieved successfully');
      return txList;
    } catch (e) {
      print('[BDK API] Error getting transactions: $e');
      throw ListTxBdkException();
    }
  }

  Future<double> estimateFeeRate() async {
    print('[BDK API] Estimating fee rate...');
    _blockchain ??= await _blockchainInit();
    final feeRate = await _blockchain!.estimateFee(6);
    print('[BDK API] Fee rate estimated successfully');
    return feeRate.asSatPerVb();
  }
}
