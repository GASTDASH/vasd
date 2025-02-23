import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:vasd/repositories/tracking/tracking.dart';

@Deprecated("To remove")
class TrackingSupabaseRepo {
  const TrackingSupabaseRepo({
    required SupabaseClient supabaseClient,
  }) : _supabaseClient = supabaseClient;

  final SupabaseClient _supabaseClient;

  Future<List<Tracking>> getTrackingList({
    required String deliveryId,
  }) async {
    final res = await _supabaseClient.from("tracking").select("*, status(*)");

    final trackingList = res
        .map(
          (row) => Tracking.fromJson(json: row),
        )
        .toList();
    trackingList.sort((a, b) => a.updateTime.compareTo(b.updateTime));

    return trackingList;
  }
}
