// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tx_list_rm.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TxRM _$TxRMFromJson(Map<String, dynamic> json) => TxRM(
      txid: json['txid'] as String,
      received: json['received'] as int,
      sent: json['sent'] as int,
      fee: json['fee'] as int?,
      confirmationTime: json['confirmationTime'] == null
          ? null
          : BlockTimeRM.fromJson(
              json['confirmationTime'] as Map<String, dynamic>),
    );

BlockTimeRM _$BlockTimeRMFromJson(Map<String, dynamic> json) => BlockTimeRM(
      height: json['height'] as int?,
      timestamp: json['timestamp'] as int?,
    );
