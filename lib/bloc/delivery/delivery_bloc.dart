import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vasd/repositories/auth/auth_interface.dart';
import 'package:vasd/repositories/delivery/delivery.dart';

part 'delivery_event.dart';
part 'delivery_state.dart';

class DeliveryBloc extends Bloc<DeliveryEvent, DeliveryState> {
  final AuthInterface _authRepo;
  final DeliverySupabaseRepo _deliverySupabaseRepo;
  final DeliveryLocalRepo _deliveryLocalRepo;

  DeliveryBloc({
    required AuthInterface authRepo,
    required DeliverySupabaseRepo deliverySupabaseRepo,
    required DeliveryLocalRepo deliveryLocalRepo,
  })  : _deliverySupabaseRepo = deliverySupabaseRepo,
        _deliveryLocalRepo = deliveryLocalRepo,
        _authRepo = authRepo,
        super(const DeliveryLoaded()) {
    on<DeliveryCreate>((event, emit) async {
      emit(DeliveryCreating(deliveries: state.deliveries));

      await Future.delayed(const Duration(seconds: 1));
      try {
        await _deliverySupabaseRepo.createDelivery(delivery: event.delivery);

        emit(DeliverySuccess(deliveries: state.deliveries));
      } catch (e) {
        emit(DeliveryError(error: e));
      }
    });
    on<DeliveryFind>((event, emit) async {
      emit(DeliveryFinding(deliveries: state.deliveries));

      await Future.delayed(const Duration(seconds: 1));
      final delivery = await _deliverySupabaseRepo.findDelivery(
          deliveryId: event.deliveryId);

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

        final List<Delivery> deliveries = await _deliverySupabaseRepo
            .getDeliveriesByUser(userId: _authRepo.user!.id);

        // deliveries.insertAll(
        //   0,
        //   await _deliveryLocalRepo.getDeliveriesByUser(
        //       userId: _authRepo.user!.id),
        // );
        deliveries.addAll(await _deliveryLocalRepo.getDeliveriesByUser(
            userId: _authRepo.user!.id));

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
            await _deliverySupabaseRepo.getDeliveriesAll();

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

        await _deliverySupabaseRepo.addTracking(
          statusCode: event.statusCode,
          deliveryId: event.deliveryId,
        );

        add(DeliveryLoadAll());

        emit(DeliveryLoaded(deliveries: state.deliveries));
      } catch (e) {
        emit(DeliveryError(error: e, deliveries: state.deliveries));
      }
    });
    on<DeliverySave>((event, emit) async {
      emit(DeliverySaving(deliveries: state.deliveries));

      try {
        if (_authRepo.user == null) {
          throw Exception("User is null");
        }

        await _deliveryLocalRepo.createDelivery(delivery: event.delivery);

        emit(DeliveryLoaded(deliveries: state.deliveries));
      } catch (e) {
        emit(DeliveryError(error: e, deliveries: state.deliveries));
      }
    });
    on<DeliveryRemove>((event, emit) {
      emit(DeliveryRemoving(deliveries: state.deliveries));

      try {
        if (_authRepo.user == null) {
          throw Exception("User is null");
        }

        _deliveryLocalRepo.removeDelivery(event.deliveryId);

        emit(DeliveryLoaded(deliveries: state.deliveries));
      } catch (e) {
        emit(DeliveryError(error: e, deliveries: state.deliveries));
      }
    });
  }
}
