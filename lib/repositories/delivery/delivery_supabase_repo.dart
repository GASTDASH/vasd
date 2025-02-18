import 'dart:math';

import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:vasd/repositories/delivery/models/delivery.dart';

class DeliverySupabaseRepo {
  const DeliverySupabaseRepo({
    required SupabaseClient supabaseClient,
  }) : _supabaseClient = supabaseClient;

  final SupabaseClient _supabaseClient;

  Future<void> createDelivery({
    required final Delivery delivery,
  }) async {
    final deliveryId = _generateId();
    GetIt.I<Talker>().debug(deliveryId);

    await _supabaseClient.from("delivery").insert({
      'delivery_id': deliveryId,
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

  String _generateId() {
    const chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    final Random rnd = Random();

    String id = "";

    // String.fromCharCodes(Iterable.generate(4, (index) => ,));
    id = String.fromCharCodes(
      Iterable.generate(
        4,
        (i) => chars.codeUnitAt(rnd.nextInt(chars.length)),
      ),
    );

    id = id.replaceRange(2, 2, (rnd.nextInt(9999999) + 1111111).toString());

    return id;
  }
}
