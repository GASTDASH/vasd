import 'package:vasd/repositories/delivery_variant/models/delivery_variant.dart';
import 'package:vasd/repositories/package_size/models/package_size.dart';

class Delivery {
  const Delivery({
    this.cityFrom = "",
    this.cityTo = "",
    this.packageSize,
    this.cost = 0,
    this.distance = 0,
    this.deliveryVariant,
    this.senderFIO,
    this.senderPhone,
    this.receiverFIO,
    this.receiverPhone,
  });

  final String cityFrom;
  final String cityTo;
  final PackageSize? packageSize;
  final double cost;
  final double distance;
  final DeliveryVariant? deliveryVariant;
  final String? senderFIO;
  final String? senderPhone;
  final String? receiverFIO;
  final String? receiverPhone;

  Delivery copyWith({
    String? cityFrom,
    String? cityTo,
    PackageSize? packageSize,
    double? cost,
    double? distance,
    DeliveryVariant? deliveryVariant,
    String? senderFIO,
    String? senderPhone,
    String? receiverFIO,
    String? receiverPhone,
  }) {
    return Delivery(
      cityFrom: cityFrom ?? this.cityFrom,
      cityTo: cityTo ?? this.cityTo,
      packageSize: packageSize ?? this.packageSize,
      cost: cost ?? this.cost,
      distance: distance ?? this.distance,
      deliveryVariant: deliveryVariant ?? this.deliveryVariant,
      senderFIO: senderFIO ?? this.senderFIO,
      senderPhone: senderPhone ?? this.senderPhone,
      receiverFIO: receiverFIO ?? this.receiverFIO,
      receiverPhone: receiverPhone ?? this.receiverPhone,
    );
  }

  Delivery removeDeliveryVariant() {
    return Delivery(
      cityFrom: cityFrom,
      cityTo: cityTo,
      packageSize: packageSize,
      cost: cost,
      distance: distance,
      senderFIO: senderFIO,
      senderPhone: senderPhone,
      receiverFIO: receiverFIO,
      receiverPhone: receiverPhone,
      deliveryVariant: null,
    );
  }

  double calculateCost({
    PackageSize? packageSize,
    double? distance,
    DeliveryVariant? variant,
  }) {
    double packageVolume = 0;

    if (packageSize != null) {
      final sizes = packageSize.size
          .split(' ')
          .first
          .split('x')
          .map((e) => double.parse(e))
          .toList();

      packageVolume = 1;
      for (var size in sizes) {
        packageVolume *= size;
      }
    }

    // double cost = ((((distance ?? 0) * (variant?.distanceRate ?? 0)) +
    //                 (packageVolume * (variant?.packageVolumeRate ?? 0))) *
    //             100)
    //         .roundToDouble() /
    //     100;

    double distanceCost = ((variant?.distanceRate ?? 0) * (distance ?? 0));
    double packageCost = (packageVolume * (variant?.packageVolumeRate ?? 0));

    double cost = ((distanceCost + packageCost) * 100).roundToDouble() / 100;

    return cost;
  }
}
