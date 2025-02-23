import 'package:another_stepper/another_stepper.dart';
import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vasd/bloc/delivery/delivery_bloc.dart';
import 'package:vasd/features/package_info/view/barcode_screen.dart';
import 'package:vasd/repositories/delivery/models/delivery.dart';
import 'package:vasd/repositories/tracking/tracking.dart';
import 'package:vasd/ui/widgets/delivery_item_widget.dart';

class PackageInfoScreen extends StatefulWidget {
  const PackageInfoScreen({super.key});

  @override
  State<PackageInfoScreen> createState() => _PackageInfoScreenState();
}

class _PackageInfoScreenState extends State<PackageInfoScreen> {
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
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                spacing: 16,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DeliveryItemWidget(delivery: delivery),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              BarcodeScreen(deliveryId: delivery.deliveryId!)));
                    },
                    child: Container(
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
                  ),
                  Text(
                    "Отслеживание посылки",
                    style: theme.textTheme.titleLarge
                        ?.copyWith(fontWeight: FontWeight.w700),
                  ),
                  AnotherStepper(
                    scrollPhysics: const NeverScrollableScrollPhysics(),
                    stepperDirection: Axis.vertical,
                    activeBarColor: theme.primaryColor,
                    activeIndex: delivery.trackingList?.length ?? 0,
                    iconHeight: 32,
                    iconWidth: 32,
                    verticalGap: 20,
                    stepperList: [
                      for (Tracking tracking in delivery.trackingList ?? [])
                        StepperData(
                          iconWidget: CircleAvatar(
                            backgroundColor:
                                theme.primaryColor.withValues(alpha: 0.3),
                            child: Padding(
                              padding: const EdgeInsets.all(6),
                              child: CircleAvatar(
                                backgroundColor: theme.primaryColor,
                              ),
                            ),
                          ),
                          title: StepperText(tracking.updateTime.toString(),
                              textStyle: theme.textTheme.bodyMedium
                                  ?.copyWith(color: theme.hintColor)),
                          subtitle: StepperText(tracking.status.name,
                              textStyle: theme.textTheme.bodyMedium),
                        ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
