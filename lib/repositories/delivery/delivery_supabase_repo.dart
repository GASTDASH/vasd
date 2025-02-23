import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:vasd/repositories/delivery/models/delivery.dart';

class DeliverySupabaseRepo {
  const DeliverySupabaseRepo({
    required SupabaseClient supabaseClient,
  }) : _supabaseClient = supabaseClient;

  final SupabaseClient _supabaseClient;

  Future<void> createDelivery({required final Delivery delivery}) async {
    await _supabaseClient.from("delivery").insert({
      'delivery_id': delivery.deliveryId,
      "user_id": _supabaseClient.auth.currentSession!.user.id,
      "city_from": delivery.cityFrom,
      "city_to": delivery.cityTo,
      "created_at": DateTime.now().toIso8601String(),
      "cost": delivery.cost,
      "max_weight": delivery.packageSize?.onlyWeight(),
      "package_size": delivery.packageSize?.onlySize(),
      "delivery_variant_id": delivery.deliveryVariant?.id,
      "sender_FIO": delivery.senderFIO,
      "sender_phone": delivery.senderPhone,
      "receiver_FIO": delivery.receiverFIO,
      "receiver_phone": delivery.receiverPhone,
    });

    return;
  }

  Future<Delivery?> findDelivery({required String deliveryId}) async {
    final res = await _supabaseClient
        .from("delivery")
        .select("*, delivery_variant(*), tracking!inner(*, status(*))");

    if (res.isNotEmpty) {
      GetIt.I<Talker>().debug("Посылка найдена\n${res.first}");
      return Delivery.fromJson(json: res.first);
    } else {
      GetIt.I<Talker>().debug("Посылка НЕ найдена");
      return null;
    }
  }

  Future<List<Delivery>> getDeliveriesByUser({required String userId}) async {
    final res = await _supabaseClient
        .from("delivery")
        .select("*, delivery_variant(*), tracking!left(*, status(*))")
        .eq("user_id", userId);

    return res
        .map(
          (row) => Delivery.fromJson(json: row),
        )
        .toList();
  }
}
