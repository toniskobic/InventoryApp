// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'userStorage.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserAdapter extends TypeAdapter<UserStorage> {
  @override
  final int typeId = 0;

  @override
  UserStorage read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserStorage()
      ..userId = fields[0] as int?
      ..jwt = fields[1] as String?
      ..organizationId = fields[2] as int?;
  }

  @override
  void write(BinaryWriter writer, UserStorage obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.userId)
      ..writeByte(1)
      ..write(obj.jwt)
      ..writeByte(2)
      ..write(obj.organizationId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
