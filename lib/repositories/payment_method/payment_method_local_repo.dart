import 'package:vasd/repositories/payment_method/models/payment_method.dart';

class PaymentMethodLocalRepo {
  const PaymentMethodLocalRepo();

  static const List<PaymentMethod> _paymentMethodList = [
    PaymentMethod(
      paymentMethodId: 1,
      name: "card",
      text: "Банковской картой",
      image: "assets/icons/card.svg",
    ),
    PaymentMethod(
      paymentMethodId: 2,
      name: "cash",
      text: "Наличными",
      description: "В пункте при отправке",
      image: "assets/icons/cash.svg",
    ),
  ];

  List<PaymentMethod> getPaymentMethods() => _paymentMethodList;
}
