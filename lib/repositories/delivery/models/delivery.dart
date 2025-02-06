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
  });

  final String cityFrom;
  final String cityTo;
  final PackageSize? packageSize;
  final double cost;
  final double distance;
  final DeliveryVariant? deliveryVariant;

  Delivery copyWith(
      {String? cityFrom,
      String? cityTo,
      PackageSize? packageSize,
      double? cost,
      double? distance,
      DeliveryVariant? deliveryVariant}) {
    return Delivery(
      cityFrom: cityFrom ?? this.cityFrom,
      cityTo: cityTo ?? this.cityTo,
      packageSize: packageSize ?? this.packageSize,
      cost: cost ?? this.cost,
      distance: distance ?? this.distance,
      deliveryVariant: deliveryVariant ?? this.deliveryVariant,
    );
  }
}
