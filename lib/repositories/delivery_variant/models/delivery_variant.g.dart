// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delivery_variant.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DeliveryVariantAdapter extends TypeAdapter<DeliveryVariant> {
  @override
  final int typeId = 4;

  @override
  DeliveryVariant read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DeliveryVariant(
      id: fields[0] as int,
      name: fields[1] as String,
      distanceRate: fields[2] as double,
      packageVolumeRate: fields[3] as double,
      minDays: fields[4] as int,
      maxDays: fields[5] as int,
      description: fields[6] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, DeliveryVariant obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.distanceRate)
      ..writeByte(3)
      ..write(obj.packageVolumeRate)
      ..writeByte(4)
      ..write(obj.minDays)
      ..writeByte(5)
      ..write(obj.maxDays)
      ..writeByte(6)
      ..write(obj.description);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DeliveryVariantAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
