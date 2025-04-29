import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vasd/repositories/auth/auth_interface.dart';
import 'package:vasd/repositories/delivery/delivery_supabase_repo.dart';
import 'package:vasd/repositories/delivery/models/delivery.dart';
import 'package:vasd/repositories/tracking/tracking.dart';

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
      emit(DeliveryCreating(deliveries: state.deliveries));

      await Future.delayed(const Duration(seconds: 1));
      try {
        await _deliveryRepo.createDelivery(delivery: event.delivery);

        emit(DeliverySuccess(deliveries: state.deliveries));
      } catch (e) {
        emit(DeliveryError(error: e));
      }
    });
    on<DeliveryFind>((event, emit) async {
      emit(DeliveryFinding(deliveries: state.deliveries));

      await Future.delayed(const Duration(seconds: 1));
      final delivery =
          await _deliveryRepo.findDelivery(deliveryId: event.deliveryId);

      if (delivery == null) {
        emit(DeliveryLoaded(deliveries: state.deliveries));
      } else {
        emit(DeliveryFound(delivery: delivery, deliveries: state.deliveries));
      }
    });
    on<DeliveryLoad>((event, emit) async {
      emit(DeliveryLoading(deliveries: state.deliveries));

      try {
        if (_authRepo.user == null) {
          throw Exception("User is null");
        }

        final List<Delivery> deliveries =
            await _deliveryRepo.getDeliveriesByUser(userId: _authRepo.user!.id);

        emit(DeliveryLoaded(deliveries: deliveries));
      } catch (e) {
        emit(DeliveryError(
          error: e,
          deliveries: state.deliveries,
        ));
      }
    });
    on<DeliveryLoadAll>((event, emit) async {
      emit(DeliveryLoading(deliveries: state.deliveries));

      try {
        if (_authRepo.user == null) {
          throw Exception("User is null");
        }
        if (!(_authRepo.user!.editor)) {
          throw Exception("User is not Editor");
        }

        final List<Delivery> deliveries =
            await _deliveryRepo.getDeliveriesAll();

        emit(DeliveryLoaded(deliveries: deliveries));
      } catch (e) {
        emit(DeliveryError(error: e, deliveries: state.deliveries));
      }
    });
    on<DeliveryAddTracking>((event, emit) async {
      emit(DeliveryLoading(deliveries: state.deliveries));

      try {
        if (_authRepo.user == null) {
          throw Exception("User is null");
        }
        if (!(_authRepo.user!.editor)) {
          throw Exception("User is not Editor");
        }

        emit(DeliveryLoaded(deliveries: state.deliveries));
      } catch (e) {
        emit(DeliveryError(error: e, deliveries: state.deliveries));
      }
    });
  }
}
