part of 'calculate_delivery_cost_bloc.dart';

sealed class CalculateDeliveryCostEvent {}

class CalculateDeliveryCostGetDistanceEvent extends CalculateDeliveryCostEvent {
  CalculateDeliveryCostGetDistanceEvent({
    required this.addresses,
    required this.packageSize,
  });

  final List<String> addresses;
  final PackageSize packageSize;
}

class CalculateDeliveryCostGetDeliveryVariantListEvent
    extends CalculateDeliveryCostEvent {}
