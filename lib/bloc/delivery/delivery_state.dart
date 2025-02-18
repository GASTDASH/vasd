part of 'delivery_bloc.dart';

sealed class DeliveryState extends Equatable {
  const DeliveryState();

  @override
  List<Object> get props => [];
}

final class DeliveryLoaded extends DeliveryState {}

final class DeliveryCreating extends DeliveryState {}

final class DeliverySuccess extends DeliveryLoaded {}

final class DeliveryError extends DeliveryLoaded {}
