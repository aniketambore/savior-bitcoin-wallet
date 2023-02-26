// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tx_list_cm.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TxListCMAdapter extends TypeAdapter<TxListCM> {
  @override
  final int typeId = 1;

  @override
  TxListCM read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TxListCM(
      txList: (fields[0] as List).cast<TxCM>(),
    );
  }

  @override
  void write(BinaryWriter writer, TxListCM obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.txList);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TxListCMAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class TxCMAdapter extends TypeAdapter<TxCM> {
  @override
  final int typeId = 2;

  @override
  TxCM read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TxCM(
      txid: fields[0] as String,
      received: fields[1] as int,
      sent: fields[2] as int,
      fee: fields[3] as int?,
      confirmationTime: fields[4] as BlockTimeCM?,
    );
  }

  @override
  void write(BinaryWriter writer, TxCM obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.txid)
      ..writeByte(1)
      ..write(obj.received)
      ..writeByte(2)
      ..write(obj.sent)
      ..writeByte(3)
      ..write(obj.fee)
      ..writeByte(4)
      ..write(obj.confirmationTime);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TxCMAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class BlockTimeCMAdapter extends TypeAdapter<BlockTimeCM> {
  @override
  final int typeId = 3;

  @override
  BlockTimeCM read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BlockTimeCM(
      height: fields[0] as int?,
      timestamp: fields[1] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, BlockTimeCM obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.height)
      ..writeByte(1)
      ..write(obj.timestamp);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BlockTimeCMAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
