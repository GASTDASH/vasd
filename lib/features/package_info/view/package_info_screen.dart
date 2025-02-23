import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vasd/bloc/delivery/delivery_bloc.dart';
import 'package:vasd/repositories/delivery/models/delivery.dart';
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
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              spacing: 16,
              children: [
                DeliveryItemWidget(delivery: delivery),
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
