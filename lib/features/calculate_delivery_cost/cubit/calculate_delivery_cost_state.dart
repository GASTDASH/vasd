part of 'calculate_delivery_cost_cubit.dart';

sealed class CalculateDeliveryCostState {}

final class CalculateDeliveryCostLoaded extends CalculateDeliveryCostState {
  CalculateDeliveryCostLoaded({
    required this.step,
    this.packageSize,
    this.addresses = const [],
    this.distance = 0,
    this.deliveryVariantList = const [],
    this.cost = 0,
  });

  final int step;
  final PackageSize? packageSize;
  final List<String> addresses;
  final double distance;
  final List<DeliveryVariant> deliveryVariantList;
  final double cost;
}

final class CalculateDeliveryCostLoading extends CalculateDeliveryCostState {}
