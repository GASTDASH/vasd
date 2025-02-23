import 'package:vasd/repositories/status/status.dart';

class Tracking {
  const Tracking({
    required this.trackingId,
    required this.deliveryId,
    required this.status,
    required this.updateTime,
    required this.lat,
    required this.lng,
  });

  final int trackingId;
  final String deliveryId;
  final Status status;
  final DateTime updateTime;
  final double lat;
  final double lng;

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
