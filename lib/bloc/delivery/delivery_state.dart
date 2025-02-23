part of 'delivery_bloc.dart';

sealed class DeliveryState extends Equatable {
  const DeliveryState();

  @override
  List<Object> get props => [];
}

final class DeliveryLoaded extends DeliveryState {
  const DeliveryLoaded({
    this.deliveries = const [],
  });

  final List<Delivery> deliveries;
}

final class DeliveryCreating extends DeliveryState {}

final class DeliveryFinding extends DeliveryState {}

final class DeliverySuccess extends DeliveryState {}

final class DeliveryError extends DeliveryState {
  const DeliveryError({
    required this.error,
  });

  final Object? error;
}

final class DeliveryFound extends DeliveryState {
  const DeliveryFound({
    required this.delivery,
  });

  final Delivery delivery;
}

final class DeliveryLoading extends DeliveryState {}
