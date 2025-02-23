part of 'delivery_bloc.dart';

sealed class DeliveryEvent extends Equatable {
  const DeliveryEvent();

  @override
  List<Object> get props => [];
}

final class DeliveryCreate extends DeliveryEvent {
  const DeliveryCreate({
    required this.delivery,
  });

  final Delivery delivery;
}

final class DeliveryFind extends DeliveryEvent {
  const DeliveryFind({
    required this.deliveryId,
  });

  final String deliveryId;
}

final class DeliveryLoad extends DeliveryEvent {}
