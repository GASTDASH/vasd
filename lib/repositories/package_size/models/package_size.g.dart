// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'package_size.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PackageSizeAdapter extends TypeAdapter<PackageSize> {
  @override
  final int typeId = 3;

  @override
  PackageSize read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PackageSize(
      image: fields[0] as String?,
      title: fields[1] as String,
      size: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, PackageSize obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.image)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.size);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PackageSizeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
