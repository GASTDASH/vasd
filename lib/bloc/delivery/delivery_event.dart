part of 'delivery_bloc.dart';

sealed class DeliveryEvent extends Equatable {
  const DeliveryEvent();

  @override
  List<Object> get props => [];
}

final class DeliveryCreate extends DeliveryEvent {
  const DeliveryCreate({
    required this.delivery,
    this.isPaid = false,
  });

  final Delivery delivery;
  final bool isPaid;
}

final class DeliveryFind extends DeliveryEvent {
  const DeliveryFind({
    required this.deliveryId,
  });

  final String deliveryId;
}

final class DeliveryLoad extends DeliveryEvent {}

final class DeliveryLoadAll extends DeliveryEvent {}

final class DeliveryAddTracking extends DeliveryEvent {
  const DeliveryAddTracking({
    required this.statusCode,
    required this.delivery,
    this.point,
  });

  final int statusCode;
  final Delivery delivery;
  final List<double>? point;
}

final class DeliverySave extends DeliveryEvent {
  const DeliverySave({
    required this.delivery,
  });

  final Delivery delivery;
}

final class DeliveryRemove extends DeliveryEvent {
  const DeliveryRemove({
    required this.deliveryId,
  });

  final String deliveryId;
}
