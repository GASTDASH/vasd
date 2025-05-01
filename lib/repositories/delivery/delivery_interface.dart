import 'package:vasd/repositories/delivery/delivery.dart';

abstract class DeliveryInterface {
  Future<void> createDelivery({required final Delivery delivery});
  Future<Delivery?> findDelivery({required String deliveryId});
  Future<List<Delivery>> getDeliveriesByUser({required String userId});
  Future<List<Delivery>> getDeliveriesAll();
}
