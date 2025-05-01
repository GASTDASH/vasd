// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tracking.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TrackingAdapter extends TypeAdapter<Tracking> {
  @override
  final int typeId = 2;

  @override
  Tracking read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Tracking(
      trackingId: fields[0] as int,
      deliveryId: fields[1] as String,
      status: fields[2] as Status,
      updateTime: fields[3] as DateTime,
      lat: fields[4] as double?,
      lng: fields[5] as double?,
    );
  }

  @override
  void write(BinaryWriter writer, Tracking obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.trackingId)
      ..writeByte(1)
      ..write(obj.deliveryId)
      ..writeByte(2)
      ..write(obj.status)
      ..writeByte(3)
      ..write(obj.updateTime)
      ..writeByte(4)
      ..write(obj.lat)
      ..writeByte(5)
      ..write(obj.lng);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TrackingAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
