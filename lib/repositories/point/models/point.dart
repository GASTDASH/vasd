class Point {
  const Point({
    required this.id,
    required this.address,
    required this.lat,
    required this.lng,
  });

  final int id;
  final String address;
  final double lat;
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
