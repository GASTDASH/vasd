part of 'delivery_bloc.dart';

sealed class DeliveryEvent extends Equatable {
  const DeliveryEvent();

  @override
  List<Object> get props => [];
}

class DeliveryCreate extends DeliveryEvent {
  const DeliveryCreate({
    required this.delivery,
  });

  final Delivery delivery;
}
