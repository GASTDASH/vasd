import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vasd/bloc/delivery/delivery_bloc.dart';
import 'package:vasd/features/calculate/bloc/calculate_bloc.dart';
import 'package:vasd/ui/ui.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  @override
  Widget build(BuildContext context) {
    final state = ModalRoute.of(context)!.settings.arguments;
    assert(state != null && state is CalculateState, 'You must provide Calculate State');
    state as CalculateState;
    var delivery = state.delivery;
    var paymentMethod = state.paymentMethod!;

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
                text: "Ваш заказ успешно создан. Вы можете отследить его в вашем профиле.",
                buttonText: "Хорошо",
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.pushNamedAndRemoveUntil(context, "/home", (route) => false);
                },
              ),
            );
          } else if (current is DeliveryError) {
            showDialog(
              context: context,
              builder: (context) => ErrorDialog(
                title: "Ошибка",
                text: "${current.error}",
              ),
            );
          }
        }
        return true;
      },
      child: SafeArea(
        child: Scaffold(
          body: Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    paymentMethod.name == "cash"
                        ? "При получении посылки получатель будет должен заплатить наличными"
                        : "Здесь будет оплата через банк",
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                  ButtonBase(
                    text: paymentMethod.name == "cash" ? "Создать" : "Оплатить",
                    onTap: () {
                      deliveryBloc.add(
                        DeliveryCreate(
                          delivery: delivery,
                          isPaid: paymentMethod.name == "card",
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
