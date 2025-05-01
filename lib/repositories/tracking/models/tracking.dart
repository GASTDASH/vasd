import 'package:hive/hive.dart';
import 'package:vasd/repositories/status/status.dart';

part 'tracking.g.dart';

@HiveType(typeId: 2)
class Tracking {
  const Tracking({
    required this.trackingId,
    required this.deliveryId,
    required this.status,
    required this.updateTime,
    this.lat,
    this.lng,
  });

  /// ID статуса отслеживания
  @HiveField(0)
  final int trackingId;

  /// ID принадлежащей доставки
  @HiveField(1)
  final String deliveryId;

  /// Статус
  @HiveField(2)
  final Status status;

  /// Дата обновления
  @HiveField(3)
  final DateTime updateTime;

  /// Широта текущего местонахождения
  @HiveField(4)
  final double? lat;

  /// Долгота текущего местонахождения
  @HiveField(5)
  final double? lng;

  factory Tracking.fromJson({required Map<String, dynamic> json}) {
    return Tracking(
      trackingId: json["tracking_id"],
      deliveryId: json["delivery_id"],
      status: Status.fromJson(json: json["status"]),
      updateTime: DateTime.parse(json["update_time"]),
      lat: json["lat"],
      lng: json["lng"],
    );
  }
}
