// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'balance_cm.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BalanceCMAdapter extends TypeAdapter<BalanceCM> {
  @override
  final int typeId = 0;

  @override
  BalanceCM read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BalanceCM(
      immature: fields[0] as int,
      trustedPending: fields[1] as int,
      untrustedPending: fields[2] as int,
      confirmed: fields[3] as int,
      spendable: fields[4] as int,
      total: fields[5] as int,
    );
  }

  @override
  void write(BinaryWriter writer, BalanceCM obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.immature)
      ..writeByte(1)
      ..write(obj.trustedPending)
      ..writeByte(2)
      ..write(obj.untrustedPending)
      ..writeByte(3)
      ..write(obj.confirmed)
      ..writeByte(4)
      ..write(obj.spendable)
      ..writeByte(5)
      ..write(obj.total);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BalanceCMAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
