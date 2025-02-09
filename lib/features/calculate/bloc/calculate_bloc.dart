import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:vasd/repositories/delivery/models/delivery.dart';
import 'package:vasd/repositories/delivery_variant/delivery_variant_local_repo.dart';
import 'package:vasd/repositories/delivery_variant/models/delivery_variant.dart';
import 'package:vasd/repositories/package_size/models/package_size.dart';
import 'package:vasd/repositories/payment_method/models/payment_method.dart';

part 'calculate_event.dart';
part 'calculate_state.dart';

class CalculateBloc extends Bloc<CalculateEvent, CalculateState> {
  CalculateBloc()
      : super(const CalculateLoaded(currentStep: 0, delivery: Delivery())) {
    on<CalculateSetCity>((event, emit) async {
      emit(CalculateLoaded(
        currentStep: 0,
        delivery: state.delivery.copyWith(
          cityFrom: event.cityFrom,
          cityTo: event.cityTo,
        ),
      ));
    });
    on<CalculateSetPackageSize>((event, emit) async {
      emit(CalculateLoaded(
        currentStep: 0,
        delivery: state.delivery.copyWith(packageSize: event.packageSize),
      ));
    });
    on<CalculateContinue>((event, emit) async {
      Delivery delivery = state.delivery;
      List<DeliveryVariant> deliveryVariantList = state.deliveryVariantList;

      if (state.currentStep == 0) {
        emit(CalculateCalculating(
          currentStep: state.currentStep,
          delivery: delivery,
        ));

        // TODO: Реализовать рассчёт расстояния
        delivery = delivery.copyWith(distance: 1733);

        delivery = delivery.removeDeliveryVariant();

        deliveryVariantList =
            await GetIt.I<DeliveryVariantLocalRepo>().getDeliveryVariantList();
      }

      emit(CalculateLoaded(
        currentStep: state.currentStep + 1,
        delivery: delivery,
        deliveryVariantList: deliveryVariantList,
        paymentMethod: state.paymentMethod,
      ));
    });
    on<CalculateStepTapped>((event, emit) {
      emit(CalculateLoaded(
        currentStep: event.tappedStep,
        delivery: state.delivery,
        deliveryVariantList: state.deliveryVariantList,
        paymentMethod: state.paymentMethod,
      ));
    });
    on<CalculateSetDeliveryVariant>((event, emit) {
      emit(CalculateLoaded(
        currentStep: state.currentStep + 1,
        delivery:
            state.delivery.copyWith(deliveryVariant: event.deliveryVariant),
        deliveryVariantList: state.deliveryVariantList,
        paymentMethod: state.paymentMethod,
      ));
    });
    on<CalculateSetPaymentMethod>((event, emit) {
      emit(CalculateLoaded(
        currentStep: state.currentStep,
        delivery: state.delivery,
        paymentMethod: event.paymentMethod,
      ));
    });
  }
}
