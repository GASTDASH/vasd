part of 'calculate_bloc.dart';

sealed class CalculateState {
  const CalculateState({
    required this.currentStep,
    required this.delivery,
    this.deliveryVariantList = const [],
  });

  final int currentStep;
  final Delivery delivery;
  final List<DeliveryVariant> deliveryVariantList;
}

class CalculateLoaded extends CalculateState {
  const CalculateLoaded({
    required super.currentStep,
    required super.delivery,
    super.deliveryVariantList,
  });
}

class CalculateSelectingPackageSize extends CalculateState {
  const CalculateSelectingPackageSize({
    required super.currentStep,
    required super.delivery,
    super.deliveryVariantList,
  });
}

class CalculateCalculating extends CalculateState {
  CalculateCalculating({
    required super.currentStep,
    required super.delivery,
    super.deliveryVariantList,
  });
}
