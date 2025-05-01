import 'package:hive/hive.dart';

part 'point.g.dart';

@HiveType(typeId: 1)
class Point {
  const Point({
    required this.id,
    required this.address,
    required this.lat,
    required this.lng,
  });

  /// ID пункта
  @HiveField(0)
  final int id;

  /// Адрес пункта
  @HiveField(1)
  final String address;

  /// Широта пункта
  @HiveField(2)
  final double lat;

  /// Долгота пункта
  @HiveField(3)
  final double lng;

  factory Point.fromJson({required Map<String, dynamic> json}) {
    return Point(
      id: json["point_id"],
      address: json["address"],
      lat: json["lat"],
      lng: json["lng"],
    );
  }
}
