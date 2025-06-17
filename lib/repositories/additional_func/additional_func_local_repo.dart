import 'package:vasd/repositories/additional_func/additional_func.dart';

class AdditionalFuncLocalRepo {
  final List<AdditionalFunc> additionalFuncList = [
    AdditionalFunc(
      id: 0,
      name: "Хрупкий груз",
      text: "Если у Вас хрупкий груз, выберите данную функцию, и мы упакуем его максимально безопасно в специальную коробку",
      price: 0,
    ),
    AdditionalFunc(
      id: 1,
      name: "Страхование доставки",
      text: "Если с посылкой что-то случится, мы возместим ущерб",
      price: 0,
    ),
  ];
}
