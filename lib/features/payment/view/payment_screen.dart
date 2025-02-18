import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vasd/bloc/delivery/delivery_bloc.dart';
import 'package:vasd/repositories/delivery/models/delivery.dart';
import 'package:vasd/ui/ui.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  @override
  Widget build(BuildContext context) {
    final delivery = ModalRoute.of(context)!.settings.arguments;
    assert(delivery != null && delivery is Delivery,
        'You must provide Delivery arg');
    delivery as Delivery;

    final deliveryBloc = context.read<DeliveryBloc>();

    return BlocListener<DeliveryBloc, DeliveryState>(
      bloc: deliveryBloc,
      listener: (context, state) {
        if (state is DeliveryCreating) {
          showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) => const LoadingDialog(),
          );
        }
      },
      listenWhen: (previous, current) {
        if (previous is DeliveryCreating) {
          Navigator.of(context).pop();

          if (current is DeliverySuccess) {
            showDialog(
              context: context,
              builder: (context) => SuccessDialog(
                title: "Успешно!",
                text:
                    "Ваш заказ успешно создан. Вы можете отследить его в вашем профиле.",
                buttonText: "Хорошо",
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.pushNamedAndRemoveUntil(
                      context, "/home/home", (route) => false);
                },
              ),
            );
          }
        }
        return true;
      },
      child: SafeArea(
        child: Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ButtonBase(
                  text: "Оплатить",
                  onTap: () {
                    deliveryBloc.add(
                      DeliveryCreate(
                        delivery: delivery,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
