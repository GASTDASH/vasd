import 'package:hive/hive.dart';
import 'package:vasd/repositories/delivery/delivery.dart';

class DeliveryLocalRepo implements DeliveryInterface {
  /// Сохранить Delivery в Box
  @override
  Future<void> createDelivery({required Delivery delivery}) async {
    final Box<Delivery> deliveryBox = Hive.box<Delivery>("delivery");

    deliveryBox.put(delivery.deliveryId, delivery);
  }

  @override
  Future<List<Delivery>> getDeliveriesByUser({required String userId}) async {
    final Box<Delivery> deliveryBox = Hive.box<Delivery>("delivery");
    List<Delivery> deliveryList = [];

    deliveryBox.toMap().forEach(
      (key, value) {
        deliveryList.add(value.copyWith(isSaved: true));
      },
    );

    deliveryList.sort((a, b) => a.createdAt!.compareTo(b.createdAt!));

    return deliveryList;
  }

  @override
  Future<Delivery?> findDelivery({required String deliveryId}) {
    throw UnimplementedError();
  }

  @override
  Future<List<Delivery>> getDeliveriesAll() {
    throw UnimplementedError();
  }

  void removeDelivery(String deliveryId) async {
    final Box<Delivery> deliveryBox = Hive.box<Delivery>("delivery");

    deliveryBox.delete(deliveryId);
  }

  @override
  Future<void> addTracking({required int statusCode, required String deliveryId}) {
    throw UnimplementedError();
  }

  @override
  Future<void> addPayment({required Delivery delivery}) {
    throw UnimplementedError();
  }

  @override
  Future<void> addNotification({required int statusCode, required Delivery delivery}) {
    throw UnimplementedError();
  }
}
