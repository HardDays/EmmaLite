// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_settings.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AppSettingsAdapter extends TypeAdapter<AppSettings> {
  @override
  final int typeId = 8;

  @override
  AppSettings read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AppSettings(
      currentProfileIndex: fields[0] as int,
      isFirstRun: fields[1] as bool,
      showProfilePlusHelp: fields[2] as bool,
      showProfileCreateHelp: fields[3] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, AppSettings obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.currentProfileIndex)
      ..writeByte(1)
      ..write(obj.isFirstRun)
      ..writeByte(2)
      ..write(obj.showProfilePlusHelp)
      ..writeByte(3)
      ..write(obj.showProfileCreateHelp);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppSettingsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
