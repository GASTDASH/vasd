part of 'calculate_bloc.dart';

sealed class CalculateEvent {}

@Deprecated("To remove")
class CalculateSetCity extends CalculateEvent {
  CalculateSetCity({
    this.cityFrom,
    this.cityTo,
  });

  final String? cityFrom;
  final String? cityTo;
}

class CalculateSetPoint extends CalculateEvent {
  CalculateSetPoint({
    this.pointFrom,
    this.pointTo,
  });

  final Point? pointFrom;
  final Point? pointTo;
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

class CalculateSetDeliveryVariant extends CalculateEvent {
  CalculateSetDeliveryVariant({
    required this.deliveryVariant,
  });

  final DeliveryVariant deliveryVariant;
}

class CalculateSetPaymentMethod extends CalculateEvent {
  CalculateSetPaymentMethod({
    required this.paymentMethod,
  });

  final PaymentMethod paymentMethod;
}

class CalculateSetInfo extends CalculateEvent {
  CalculateSetInfo({
    required this.fio,
    required this.phone,
  });

  final String fio;
  final String phone;
}

class CalculateSetSenderInfo extends CalculateSetInfo {
  CalculateSetSenderInfo({
    required super.fio,
    required super.phone,
  });
}

class CalculateSetReceiverInfo extends CalculateSetInfo {
  CalculateSetReceiverInfo({
    required super.fio,
    required super.phone,
  });
}
