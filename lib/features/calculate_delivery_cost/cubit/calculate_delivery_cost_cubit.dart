import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:vasd/repositories/delivery_variant/delivery_variant_local_repo.dart';
import 'package:vasd/repositories/delivery_variant/models/delivery_variant.dart';
import 'package:vasd/repositories/package_size/models/package_size.dart';

part 'calculate_delivery_cost_state.dart';

class CalculateDeliveryCostCubit extends Cubit<CalculateDeliveryCostState> {
  CalculateDeliveryCostCubit() : super(CalculateDeliveryCostLoaded(step: 0));

  void changeStep({required int nextStep, required int previousStep}) async {
    emit(CalculateDeliveryCostLoading());

    //TODO: Реализовать рассчёт дистанции
    double distance = 1733;
    List<DeliveryVariant> deliveryVariantList =
        await GetIt.I<DeliveryVariantLocalRepo>().getDeliveryVariantList();

    emit(CalculateDeliveryCostLoaded(
      step: nextStep,
      distance: distance,
      deliveryVariantList: deliveryVariantList,
    ));
  }
}
