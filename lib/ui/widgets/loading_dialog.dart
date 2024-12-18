import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';

class LoadingDialog extends StatefulWidget {
  const LoadingDialog({super.key});

  @override
  State<LoadingDialog> createState() => _LoadingDialogState();
}

class _LoadingDialogState extends State<LoadingDialog> {
  @override
  Widget build(BuildContext context) {
    return const Dialog(
      child: SizedBox(
        height: 200,
        width: 250,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 100,
                width: 100,
                child:
                    LoadingIndicator(indicatorType: Indicator.ballRotateChase),
              ),
              SizedBox(height: 20),
              Text("Пожалуйста, подождите"),
            ],
          ),
        ),
      ),
    );
  }
}
