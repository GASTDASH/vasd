import 'package:vasd/repositories/delivery_variant/models/delivery_variant.dart';

class DeliveryVariantLocalRepo {
  const DeliveryVariantLocalRepo();

  static const List<DeliveryVariant> _deliveryVariantList = [
    DeliveryVariant(
      name: "Стандарт",
      distanceRate: 0.23,
      minDays: 3,
      maxDays: 5,
      description: "Проверка",
    ),
    DeliveryVariant(
      name: "Экспресс",
      distanceRate: 0.39,
      minDays: 3,
      maxDays: 5,
      description: "Проверка",
    ),
  ];

  Future<List<DeliveryVariant>> getDeliveryVariantList() async {
    await Future.delayed(const Duration(seconds: 1));

    return _deliveryVariantList;
  }
}
