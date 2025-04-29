part of 'delivery_bloc.dart';

sealed class DeliveryState extends Equatable {
  const DeliveryState({
    this.deliveries = const [],
  });

  final List<Delivery> deliveries;

  @override
  List<Object> get props => [];
}

final class DeliveryLoaded extends DeliveryState {
  const DeliveryLoaded({
    super.deliveries,
  });
}

final class DeliveryCreating extends DeliveryState {
  const DeliveryCreating({
    super.deliveries,
  });
}

final class DeliveryFinding extends DeliveryState {
  const DeliveryFinding({
    super.deliveries,
  });
}

final class DeliverySuccess extends DeliveryState {
  const DeliverySuccess({
    super.deliveries,
  });
}

final class DeliveryError extends DeliveryState {
  const DeliveryError({
    super.deliveries,
    required this.error,
  });

  final Object? error;
}

final class DeliveryFound extends DeliveryLoaded {
  const DeliveryFound({
    super.deliveries,
    required this.delivery,
  });

  final Delivery delivery;
}

final class DeliveryLoading extends DeliveryState {
  const DeliveryLoading({
    super.deliveries,
  });
}
