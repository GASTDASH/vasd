import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';

class BarcodeScreen extends StatefulWidget {
  const BarcodeScreen({
    super.key,
    required this.deliveryId,
  });

  final String deliveryId;

  @override
  State<BarcodeScreen> createState() => _BarcodeScreenState();
}

class _BarcodeScreenState extends State<BarcodeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: BarcodeWidget(
                data: widget.deliveryId, barcode: Barcode.pdf417()),
          ),
        ),
      ),
    );
  }
}
