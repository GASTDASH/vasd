import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vasd/repositories/delivery/delivery_supabase_repo.dart';
import 'package:vasd/repositories/delivery/models/delivery.dart';

part 'delivery_event.dart';
part 'delivery_state.dart';

class DeliveryBloc extends Bloc<DeliveryEvent, DeliveryState> {
  final DeliverySupabaseRepo _deliveryRepo;

  DeliveryBloc({required DeliverySupabaseRepo deliveryRepo})
      : _deliveryRepo = deliveryRepo,
        super(DeliveryLoaded()) {
    on<DeliveryCreate>((event, emit) async {
      emit(DeliveryCreating());

      await Future.delayed(const Duration(seconds: 1));
      try {
        await _deliveryRepo.createDelivery(delivery: event.delivery);

        emit(DeliverySuccess());
      } catch (e) {
        emit(DeliveryError());
      }
    });
    on<DeliveryFind>((event, emit) async {
      emit(DeliveryFinding());

      await Future.delayed(const Duration(seconds: 1));
      final delivery =
          await _deliveryRepo.findDelivery(deliveryId: event.deliveryId);

      if (delivery == null) {
        emit(DeliveryLoaded());
      } else {
        emit(DeliveryFound(delivery: delivery));
      }
    });
  }
}
