import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vasd/repositories/delivery/models/delivery.dart';
import 'package:vasd/repositories/package_size/models/package_size.dart';

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
      emit(
        CalculateLoaded(
            currentStep: 0,
            delivery: state.delivery.copyWith(packageSize: event.packageSize)),
      );
    });
  }
}
