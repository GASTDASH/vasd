class DeliveryVariant {
  const DeliveryVariant({
    required this.name,
    required this.distanceRate,
    required this.minDays,
    required this.maxDays,
    this.description,
  });

  final String name;
  final double distanceRate;
  final int minDays;
  final int maxDays;
  final String? description;
}
