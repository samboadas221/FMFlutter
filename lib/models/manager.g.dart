// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'manager.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ManagerAdapter extends TypeAdapter<Manager> {
  @override
  final int typeId = 0;

  @override
  Manager read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Manager(
      name: fields[0] as String,
      surname: fields[1] as String,
      style: fields[2] as String,
      avatar: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Manager obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.surname)
      ..writeByte(2)
      ..write(obj.style)
      ..writeByte(3)
      ..write(obj.avatar);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ManagerAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
