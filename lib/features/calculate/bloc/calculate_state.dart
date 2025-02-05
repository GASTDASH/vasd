part of 'calculate_bloc.dart';

sealed class CalculateState {
  const CalculateState({
    required this.currentStep,
    required this.delivery,
  });

  final int currentStep;
  final Delivery delivery;
}

class CalculateLoaded extends CalculateState {
  const CalculateLoaded({required super.currentStep, required super.delivery});
}

class CalculateSelectingPackageSize extends CalculateState {
  const CalculateSelectingPackageSize(
      {required super.currentStep, required super.delivery});
}
