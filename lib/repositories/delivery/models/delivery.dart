import 'dart:math' as math;

import 'package:vasd/repositories/delivery_variant/models/delivery_variant.dart';
import 'package:vasd/repositories/package_size/models/package_size.dart';
import 'package:vasd/repositories/point/point.dart';
import 'package:vasd/repositories/tracking/tracking.dart';

class Delivery {
  Delivery({
    this.deliveryId,
    this.cityFrom = "",
    this.cityTo = "",
    this.pointFrom,
    this.pointTo,
    this.packageSize,
    this.cost = 0,
    this.distance = 0,
    this.deliveryVariant,
    this.senderFIO,
    this.senderPhone,
    this.receiverFIO,
    this.receiverPhone,
    this.trackingList,
  }) {
    deliveryId ??= _generateId();
  }

  String? deliveryId;
  final String cityFrom;
  final String cityTo;
  final Point? pointFrom;
  final Point? pointTo;
  final PackageSize? packageSize;
  final double cost;
  final double distance;
  final DeliveryVariant? deliveryVariant;
  final String? senderFIO;
  final String? senderPhone;
  final String? receiverFIO;
  final String? receiverPhone;
  final List<Tracking>? trackingList;

  factory Delivery.fromJson({required Map<String, dynamic> json}) => Delivery(
        deliveryId: json["delivery_id"],
        cityFrom: json["city_from"],
        cityTo: json["city_to"],
        pointFrom: json["point_from"] != null
            ? Point.fromJson(json: json["point_from"])
            : null,
        pointTo: json["point_to"] != null
            ? Point.fromJson(json: json["point_to"])
            : null,
        // packageSize: json[] // TODO
        cost: json["cost"],
        distance: json["distance"] ?? 0,
        deliveryVariant:
            DeliveryVariant.fromJson(json: json["delivery_variant"]),
        senderFIO: json["sender_FIO"],
        senderPhone: json["sender_phone"].toString(),
        receiverFIO: json["receiver_FIO"],
        receiverPhone: json["receiver_phone"].toString(),
        trackingList: (json["tracking"] as List<dynamic>?)
            ?.map(
              (row) => Tracking.fromJson(json: row),
            )
            .toList(),
      );

  Delivery copyWith({
    String? cityFrom,
    String? cityTo,
    Point? pointFrom,
    Point? pointTo,
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
      pointFrom: pointFrom ?? this.pointFrom,
      pointTo: pointTo ?? this.pointTo,
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
      pointFrom: pointFrom,
      pointTo: pointTo,
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

  String _generateId() {
    const chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    final math.Random rnd = math.Random();

    String id = "";

    // String.fromCharCodes(Iterable.generate(4, (index) => ,));
    id = String.fromCharCodes(
      Iterable.generate(
        4,
        (i) => chars.codeUnitAt(rnd.nextInt(chars.length)),
      ),
    );

    id = id.replaceRange(2, 2, (rnd.nextInt(9999999) + 1111111).toString());

    return id;
  }
}
