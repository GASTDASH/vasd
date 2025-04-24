import 'package:vasd/repositories/delivery_variant/models/delivery_variant.dart';

class DeliveryVariantLocalRepo {
  const DeliveryVariantLocalRepo();

  static const List<DeliveryVariant> _deliveryVariantList = [
    DeliveryVariant(
      id: 1,
      name: "Стандарт",
      distanceRate: 1.2,
      packageVolumeRate: 0.005,
      minDays: 3,
      maxDays: 5,
      description: "Проверка",
    ),
    DeliveryVariant(
      id: 2,
      name: "Экспресс",
      distanceRate: 2.5,
      packageVolumeRate: 0.008,
      minDays: 2,
      maxDays: 3,
      description: "Проверка",
    ),
  ];

  Future<List<DeliveryVariant>> getDeliveryVariantList() async {
    await Future.delayed(const Duration(seconds: 1));

    return _deliveryVariantList;
  }
}
