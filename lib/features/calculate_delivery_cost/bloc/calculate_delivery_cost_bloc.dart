import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:vasd/repositories/delivery_variant/delivery_variant_local_repo.dart';
import 'package:vasd/repositories/delivery_variant/models/delivery_variant.dart';
import 'package:vasd/repositories/package_size/models/package_size.dart';

part 'calculate_delivery_cost_event.dart';
part 'calculate_delivery_cost_state.dart';

class CalculateDeliveryCostBloc
    extends Bloc<CalculateDeliveryCostEvent, CalculateDeliveryCostState> {
  CalculateDeliveryCostBloc()
      : super(CalculateDeliveryCostLoadedState(step: 0)) {
    on<CalculateDeliveryCostGetDistanceEvent>((event, emit) async {
      emit(CalculateDeliveryCostLoadingState());

      //TODO: Реализовать рассчёт дистанции
      double distance = 1733;
      List<DeliveryVariant> deliveryVariantList =
          await GetIt.I<DeliveryVariantLocalRepo>().getDeliveryVariantList();

      emit(CalculateDeliveryCostLoadedState(
        step: 1,
        distance: distance,
        packageSize: event.packageSize,
        deliveryVariantList: deliveryVariantList,
      ));
    });
  }
}
