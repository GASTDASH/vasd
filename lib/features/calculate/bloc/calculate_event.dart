part of 'calculate_bloc.dart';

sealed class CalculateEvent {}

class CalculateSetCity extends CalculateEvent {
  CalculateSetCity({
    this.cityFrom,
    this.cityTo,
  });

  final String? cityFrom;
  final String? cityTo;
}

class CalculateStepTapped extends CalculateEvent {
  CalculateStepTapped({
    required this.tappedStep,
  });

  final int tappedStep;
}

class CalculateContinue extends CalculateEvent {}

class CalculateSetPackageSize extends CalculateEvent {
  CalculateSetPackageSize({
    required this.packageSize,
  });

  final PackageSize packageSize;
}
