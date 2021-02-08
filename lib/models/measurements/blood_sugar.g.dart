// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'blood_sugar.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BloodSugarAdapter extends TypeAdapter<BloodSugar> {
  @override
  final int typeId = 2;

  @override
  BloodSugar read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BloodSugar(
      id: fields[0] as int,
      date: fields[1] as String,
      sugar: fields[2] as double,
      eatTime: fields[3] as String,
      userId: fields[4] as int,
    );
  }

  @override
  void write(BinaryWriter writer, BloodSugar obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.date)
      ..writeByte(2)
      ..write(obj.sugar)
      ..writeByte(3)
      ..write(obj.eatTime)
      ..writeByte(4)
      ..write(obj.userId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BloodSugarAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
