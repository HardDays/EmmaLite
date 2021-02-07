// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'height_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HeightModelAdapter extends TypeAdapter<HeightModel> {
  @override
  final int typeId = 3;

  @override
  HeightModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HeightModel(
      id: fields[0] as int,
      date: fields[1] as String,
      height: fields[2] as double,
      userId: fields[3] as int,
    );
  }

  @override
  void write(BinaryWriter writer, HeightModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.date)
      ..writeByte(2)
      ..write(obj.height)
      ..writeByte(3)
      ..write(obj.userId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HeightModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
