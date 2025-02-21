import 'package:another_stepper/another_stepper.dart';
import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vasd/bloc/delivery/delivery_bloc.dart';
import 'package:vasd/repositories/delivery/models/delivery.dart';

class PackageInfoScreen extends StatefulWidget {
  const PackageInfoScreen({super.key});

  @override
  State<PackageInfoScreen> createState() => _PackageInfoScreenState();
}

class _PackageInfoScreenState extends State<PackageInfoScreen> {
  @override
  void initState() {
    super.initState();

    // TODO:
    // deliveryBloc.add(DeliveryTrack);
  }

  @override
  Widget build(BuildContext context) {
    final delivery = ModalRoute.of(context)!.settings.arguments;
    assert(delivery != null && delivery is Delivery,
        'You must provide Delivery arg');
    delivery as Delivery;

    final theme = Theme.of(context);

    return BlocListener<DeliveryBloc, DeliveryState>(
      listener: (context, state) {
        // TODO
      },
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              "Детали заказа",
              style: theme.textTheme.titleLarge
                  ?.copyWith(fontWeight: FontWeight.w700),
            ),
            centerTitle: true,
          ),
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              spacing: 16,
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: theme.hintColor, width: 1),
                  ),
                  child: Column(
                    spacing: 16,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Номер заказа:",
                            style: theme.textTheme.bodyLarge,
                          ),
                          Text(
                            delivery.deliveryId!,
                            style: theme.textTheme.titleMedium,
                          ),
                        ],
                      ),
                      // TODO
                      AnotherStepper(
                        scrollPhysics: const NeverScrollableScrollPhysics(),
                        stepperDirection: Axis.horizontal,
                        stepperList: [
                          StepperData(),
                          StepperData(),
                          StepperData(),
                          StepperData(),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            delivery.cityFrom,
                            style: theme.textTheme.titleSmall,
                          ),
                          CircleAvatar(
                            backgroundColor:
                                theme.hintColor.withValues(alpha: 0.2),
                            child: const Icon(Icons.arrow_right_alt_rounded),
                          ),
                          Text(
                            delivery.cityTo,
                            style: theme.textTheme.titleSmall,
                          ),
                        ],
                      ),
                      Divider(
                        color: theme.hintColor,
                        height: 1,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Статус:",
                            style: theme.textTheme.bodyLarge,
                          ),
                          Text(
                            "{status}", // TODO: Tracking INNER JOIN что-то там такая фигня я хз
                            style: theme.textTheme.titleMedium,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: theme.hintColor, width: 1),
                  ),
                  child: Center(
                    child: BarcodeWidget(
                      height: 70,
                      data: delivery.deliveryId!,
                      barcode: Barcode.pdf417(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
