part of 'calculate_delivery_cost_bloc.dart';

sealed class CalculateDeliveryCostState {}

final class CalculateDeliveryCostInitial extends CalculateDeliveryCostState {}

final class CalculateDeliveryCostLoadingState
    extends CalculateDeliveryCostState {}

final class CalculateDeliveryCostLoadedState
    extends CalculateDeliveryCostState {
  CalculateDeliveryCostLoadedState({
    required this.step,
    this.packageSize,
    this.addresses = const [],
    this.distance = 0,
    this.deliveryVariantList = const [],
  });

  final int step;
  final PackageSize? packageSize;
  final List<String> addresses;
  final double distance;
  final List<DeliveryVariant> deliveryVariantList;
}
