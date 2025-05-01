// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delivery.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DeliveryAdapter extends TypeAdapter<Delivery> {
  @override
  final int typeId = 0;

  @override
  Delivery read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Delivery(
      deliveryId: fields[0] as String?,
      cityFrom: fields[1] as String,
      cityTo: fields[2] as String,
      pointFrom: fields[3] as Point?,
      pointTo: fields[4] as Point?,
      packageSize: fields[5] as PackageSize?,
      cost: fields[6] as double,
      distance: fields[7] as double,
      deliveryVariant: fields[8] as DeliveryVariant?,
      senderFIO: fields[9] as String?,
      senderPhone: fields[10] as String?,
      receiverFIO: fields[11] as String?,
      receiverPhone: fields[12] as String?,
      trackingList: (fields[13] as List?)?.cast<Tracking>(),
      createdAt: fields[14] as DateTime?,
    );
  }

  @override
  void write(BinaryWriter writer, Delivery obj) {
    writer
      ..writeByte(15)
      ..writeByte(0)
      ..write(obj.deliveryId)
      ..writeByte(1)
      ..write(obj.cityFrom)
      ..writeByte(2)
      ..write(obj.cityTo)
      ..writeByte(3)
      ..write(obj.pointFrom)
      ..writeByte(4)
      ..write(obj.pointTo)
      ..writeByte(5)
      ..write(obj.packageSize)
      ..writeByte(6)
      ..write(obj.cost)
      ..writeByte(7)
      ..write(obj.distance)
      ..writeByte(8)
      ..write(obj.deliveryVariant)
      ..writeByte(9)
      ..write(obj.senderFIO)
      ..writeByte(10)
      ..write(obj.senderPhone)
      ..writeByte(11)
      ..write(obj.receiverFIO)
      ..writeByte(12)
      ..write(obj.receiverPhone)
      ..writeByte(13)
      ..write(obj.trackingList)
      ..writeByte(14)
      ..write(obj.createdAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DeliveryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
