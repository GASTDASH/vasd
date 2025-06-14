import 'package:vasd/repositories/delivery/delivery.dart';

abstract class DeliveryInterface {
  Future<void> createDelivery({required final Delivery delivery});
  Future<Delivery?> findDelivery({required String deliveryId});
  Future<List<Delivery>> getDeliveriesByUser({required String userId});
  Future<List<Delivery>> getDeliveriesAll();
  Future<void> addTracking({required int statusCode, required String deliveryId});
  Future<void> addPayment({required final Delivery delivery});
  Future<void> addNotification({required int statusCode, required Delivery delivery});
}
