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
      currentProfileId: fields[0] as int,
      isFirstRun: fields[1] as bool,
      showProfilePlusHelp: fields[2] as bool,
      showProfileCreateHelp: fields[3] as bool,
      showProfileSettingsHelp: fields[4] as bool,
      password: fields[5] as String,
      useFaceId: fields[7] as bool,
      usePassword: fields[6] as bool,
    )
      ..locale = fields[8] as String
      ..lightTheme = fields[9] as bool;
  }

  @override
  void write(BinaryWriter writer, AppSettings obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.currentProfileId)
      ..writeByte(1)
      ..write(obj.isFirstRun)
      ..writeByte(2)
      ..write(obj.showProfilePlusHelp)
      ..writeByte(3)
      ..write(obj.showProfileCreateHelp)
      ..writeByte(4)
      ..write(obj.showProfileSettingsHelp)
      ..writeByte(5)
      ..write(obj.password)
      ..writeByte(6)
      ..write(obj.usePassword)
      ..writeByte(7)
      ..write(obj.useFaceId)
      ..writeByte(8)
      ..write(obj.locale)
      ..writeByte(9)
      ..write(obj.lightTheme);
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
