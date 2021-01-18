// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'arterial_pressure.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ArterialPressureAdapter extends TypeAdapter<ArterialPressure> {
  @override
  final int typeId = 1;

  @override
  ArterialPressure read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ArterialPressure(
      id: fields[0] as int,
      date: fields[1] as String,
      top: fields[2] as int,
      under: fields[3] as int,
    );
  }

  @override
  void write(BinaryWriter writer, ArterialPressure obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.date)
      ..writeByte(2)
      ..write(obj.top)
      ..writeByte(3)
      ..write(obj.under);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ArterialPressureAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
