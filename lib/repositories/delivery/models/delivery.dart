import 'dart:math' as math;

import 'package:hive/hive.dart';
import 'package:vasd/repositories/delivery_variant/models/delivery_variant.dart';
import 'package:vasd/repositories/package_size/models/package_size.dart';
import 'package:vasd/repositories/point/point.dart';
import 'package:vasd/repositories/tracking/tracking.dart';

part 'delivery.g.dart';

@HiveType(typeId: 0)
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
    this.createdAt,
    this.isSaved = false,
  }) {
    deliveryId ??= _generateId();
  }

  /// Уникальный идентификатор заказа
  @HiveField(0)
  String? deliveryId;

  /// Город отправки
  @HiveField(1)
  final String cityFrom;

  /// Город назначения
  @HiveField(2)
  final String cityTo;

  /// Пункт отправки
  @HiveField(3)
  final Point? pointFrom;

  /// Пункт получения
  @HiveField(4)
  final Point? pointTo;

  /// Размер посылки
  @HiveField(5)
  final PackageSize? packageSize;

  /// Стоимость заказа
  @HiveField(6)
  final double cost;

  /// Расстояние между пунктами
  @HiveField(7)
  final double distance;

  /// Способ доставки заказа
  @HiveField(8)
  final DeliveryVariant? deliveryVariant;

  /// ФИО отправителя
  @HiveField(9)
  final String? senderFIO;

  /// Номер телефона отправителя
  @HiveField(10)
  final String? senderPhone;

  /// ФИО получателя
  @HiveField(11)
  final String? receiverFIO;

  /// Номер телефона получателя
  @HiveField(12)
  final String? receiverPhone;

  /// Список статусов отслеживания
  @HiveField(13)
  final List<Tracking>? trackingList;

  /// Дата создания заказа
  @HiveField(14)
  final DateTime? createdAt;

  /// Сохранённый ли заказ
  @HiveField(15)
  final bool isSaved;

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
      deliveryVariant: DeliveryVariant.fromJson(json: json["delivery_variant"]),
      senderFIO: json["sender_FIO"],
      senderPhone: json["sender_phone"].toString(),
      receiverFIO: json["receiver_FIO"],
      receiverPhone: json["receiver_phone"].toString(),
      trackingList: (json["tracking"] as List<dynamic>?)
          ?.map(
            (row) => Tracking.fromJson(json: row),
          )
          .toList(),
      createdAt: DateTime.parse(json["created_at"]));

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
    DateTime? createdAt,
    bool? isSaved,
    String? deliveryId,
    List<Tracking>? trackingList,
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
      createdAt: createdAt ?? this.createdAt,
      isSaved: isSaved ?? this.isSaved,
      deliveryId: deliveryId ?? this.deliveryId,
      trackingList: trackingList ?? this.trackingList,
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
      createdAt: createdAt,
      deliveryId: deliveryId,
      isSaved: isSaved,
      trackingList: trackingList,
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
