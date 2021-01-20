// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pulse.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PulseAdapter extends TypeAdapter<Pulse> {
  @override
  final int typeId = 4;

  @override
  Pulse read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Pulse(
      id: fields[0] as int,
      date: fields[1] as String,
      pulse: fields[2] as int,
      pulseType: fields[3] as int,
    );
  }

  @override
  void write(BinaryWriter writer, Pulse obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.date)
      ..writeByte(2)
      ..write(obj.pulse)
      ..writeByte(3)
      ..write(obj.pulseType);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PulseAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
