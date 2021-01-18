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
    );
  }

  @override
  void write(BinaryWriter writer, HeightModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.date)
      ..writeByte(2)
      ..write(obj.height);
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
