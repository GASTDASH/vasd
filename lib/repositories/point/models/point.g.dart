// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'point.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PointAdapter extends TypeAdapter<Point> {
  @override
  final int typeId = 1;

  @override
  Point read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Point(
      id: fields[0] as int,
      address: fields[1] as String,
      lat: fields[2] as double,
      lng: fields[3] as double,
    );
  }

  @override
  void write(BinaryWriter writer, Point obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.address)
      ..writeByte(2)
      ..write(obj.lat)
      ..writeByte(3)
      ..write(obj.lng);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PointAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
