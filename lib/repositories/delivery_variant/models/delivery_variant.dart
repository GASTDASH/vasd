import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'delivery_variant.g.dart';

@HiveType(typeId: 4)
class DeliveryVariant extends Equatable {
  const DeliveryVariant({
    required this.id,
    required this.name,
    required this.distanceRate,
    required this.packageVolumeRate,
    required this.minDays,
    required this.maxDays,
    this.description,
  });

  /// ID варианта
  @HiveField(0)
  final int id;

  /// Название варианта
  @HiveField(1)
  final String name;

  /// Цена за километр
  @HiveField(2)
  final double distanceRate;

  /// Цена за единицу объёма
  @HiveField(3)
  final double packageVolumeRate;

  /// Минимальное количество дней
  @HiveField(4)
  final int minDays;

  /// Максимальное количество дней
  @HiveField(5)
  final int maxDays;

  /// Описание
  @HiveField(6)
  final String? description;

  @override
  List<Object?> get props => [name, distanceRate, minDays, maxDays];

  factory DeliveryVariant.fromJson({
    required Map<String, dynamic> json,
  }) =>
      DeliveryVariant(
        id: json["delivery_variant_id"],
        name: json["name"],
        distanceRate: json["distance_rate"],
        packageVolumeRate: json["package_volume_rate"],
        minDays: json["min_days"],
        maxDays: json["max_days"],
        description: json["description"],
      );
}
