import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:vasd/repositories/delivery/delivery.dart';

class DeliverySupabaseRepo implements DeliveryInterface {
  const DeliverySupabaseRepo({
    required SupabaseClient supabaseClient,
  }) : _supabaseClient = supabaseClient;

  final SupabaseClient _supabaseClient;

  @override
  Future<void> createDelivery({required final Delivery delivery}) async {
    await _supabaseClient.from("delivery").insert({
      'delivery_id': delivery.deliveryId,
      "user_id": _supabaseClient.auth.currentSession!.user.id,
      "city_from": delivery.cityFrom,
      "city_to": delivery.cityTo,
      "point_from_id": delivery.pointFrom?.id,
      "point_to_id": delivery.pointTo?.id,
      "created_at": DateTime.now().toIso8601String(),
      "cost": delivery.cost,
      "distance": delivery.distance,
      "max_weight": delivery.packageSize?.onlyWeight(),
      "package_size": delivery.packageSize?.onlySize(),
      "delivery_variant_id": delivery.deliveryVariant?.id,
      "sender_FIO": delivery.senderFIO,
      "sender_phone": delivery.senderPhone,
      "receiver_FIO": delivery.receiverFIO,
      "receiver_phone": delivery.receiverPhone,
    });

    await _supabaseClient.from("tracking").insert({
      "delivery_id": delivery.deliveryId,
      "status_code": 1,
      "update_time": DateTime.now().toIso8601String(),
    });

    return;
  }

  @override
  Future<Delivery?> findDelivery({required String deliveryId}) async {
    final res = await _supabaseClient
        .from("delivery")
        .select(
          "*,"
          "delivery_variant(*),"
          "tracking!inner(*, status(*)),"
          "point_from:point!delivery_point_from_id_fkey(*),"
          "point_to:point!delivery_point_to_id_fkey(*)",
        )
        .eq("delivery_id", deliveryId);

    if (res.isNotEmpty) {
      GetIt.I<Talker>().debug("Посылка найдена\n${res.first}");
      return Delivery.fromJson(json: res.first);
    } else {
      GetIt.I<Talker>().debug("Посылка НЕ найдена");
      return null;
    }
  }

  @override
  Future<List<Delivery>> getDeliveriesByUser({required String userId}) async {
    final res = await _supabaseClient
        .from("delivery")
        .select(
          "*,"
          "delivery_variant(*),"
          "tracking!inner(*, status(*)),"
          "point_from:point!delivery_point_from_id_fkey(*),"
          "point_to:point!delivery_point_to_id_fkey(*)",
        )
        .eq("user_id", userId);

    return res
        .map(
          (row) => Delivery.fromJson(json: row),
        )
        .toList();
  }

  @override
  Future<List<Delivery>> getDeliveriesAll() async {
    final res = await _supabaseClient.from("delivery").select(
          "*,"
          "delivery_variant(*),"
          "tracking!inner(*, status(*)),"
          "point_from:point!delivery_point_from_id_fkey(*),"
          "point_to:point!delivery_point_to_id_fkey(*)",
        );

    return res.map((row) => Delivery.fromJson(json: row)).toList();
  }

  @override
  Future<void> addTracking({
    required int statusCode,
    required String deliveryId,
    List<double>? point,
  }) async {
    await _supabaseClient.from("tracking").insert({
      "delivery_id": deliveryId,
      "status_code": statusCode,
      "lat": point?[0],
      "lng": point?[1],
      "update_time": DateTime.now().toIso8601String(),
    });
  }

  @override
  Future<void> addPayment({required Delivery delivery}) async {
    await _supabaseClient.from("payment").insert({
      "delivery_id": delivery.deliveryId,
      "amount": delivery.cost,
      "payment_date": DateTime.now().toIso8601String(),
      "payment_method_id": 1,
    });
  }

  @override
  Future<void> addNotification({
    required int statusCode,
    required Delivery delivery,
  }) async {
    String? title;
    String? text;

    if (statusCode == 2) {
      title = "Посылка готова к отправке";
      text = "Ваша посылка скоро будет отправлена из ${delivery.cityFrom} в ${delivery.cityTo}";
    } else if (statusCode == 3) {
      title = "Посылка была отправлена";
      text = "Ваша посылка была отправлена из ${delivery.cityFrom} и скоро будет доставлена в ${delivery.cityTo}";
    } else if (statusCode == 4) {
      title = "Посылка была доставлена";
      text = "Ваша посылка была успешно доставлена в ${delivery.cityTo}";
    }

    if (title != null && text != null) {
      await _supabaseClient.from("notification").insert({
        "created_at": DateTime.now().toIso8601String(),
        "user_id": delivery.userId,
        "title": title,
        "text": text,
        "delivery_id": delivery.deliveryId,
        "status_code": statusCode,
      });
    }
  }
}
