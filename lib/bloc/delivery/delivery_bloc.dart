import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vasd/repositories/auth/auth_interface.dart';
import 'package:vasd/repositories/delivery/delivery_supabase_repo.dart';
import 'package:vasd/repositories/delivery/models/delivery.dart';

part 'delivery_event.dart';
part 'delivery_state.dart';

class DeliveryBloc extends Bloc<DeliveryEvent, DeliveryState> {
  final AuthInterface _authRepo;
  final DeliverySupabaseRepo _deliveryRepo;

  DeliveryBloc({
    required AuthInterface authRepo,
    required DeliverySupabaseRepo deliveryRepo,
  })  : _deliveryRepo = deliveryRepo,
        _authRepo = authRepo,
        super(const DeliveryLoaded()) {
    on<DeliveryCreate>((event, emit) async {
      emit(DeliveryCreating());

      await Future.delayed(const Duration(seconds: 1));
      try {
        await _deliveryRepo.createDelivery(delivery: event.delivery);

        emit(DeliverySuccess());
      } catch (e) {
        emit(DeliveryError(error: e));
      }
    });
    on<DeliveryFind>((event, emit) async {
      emit(DeliveryFinding());

      await Future.delayed(const Duration(seconds: 1));
      final delivery =
          await _deliveryRepo.findDelivery(deliveryId: event.deliveryId);

      if (delivery == null) {
        emit(const DeliveryLoaded());
      } else {
        emit(DeliveryFound(delivery: delivery));
      }
    });
    on<DeliveryLoad>((event, emit) async {
      emit(DeliveryLoading());

      try {
        if (_authRepo.user == null) {
          throw Exception("User is null");
        }

        final List<Delivery> deliveries =
            await _deliveryRepo.getDeliveriesByUser(userId: _authRepo.user!.id);

        emit(DeliveryLoaded(deliveries: deliveries));
      } catch (e) {
        emit(DeliveryError(error: e));
      }
    });
  }
}
