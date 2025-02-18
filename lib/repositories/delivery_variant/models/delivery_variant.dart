import 'package:equatable/equatable.dart';

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

  final int id;
  final String name;
  final double distanceRate;
  final double packageVolumeRate;
  final int minDays;
  final int maxDays;
  final String? description;

  @override
  List<Object?> get props => [name, distanceRate, minDays, maxDays];
}
