import 'package:hive/hive.dart';

part 'status.g.dart';

@HiveType(typeId: 5)
class Status {
  const Status({
    required this.statusCode,
    required this.name,
  });

  /// Код статуса
  @HiveField(0)
  final int statusCode;

  /// Название статуса
  @HiveField(1)
  final String name;

  factory Status.fromJson({
    required Map<String, dynamic> json,
  }) {
    return Status(
      statusCode: json["status_code"],
      name: json["name"],
    );
  }
}
