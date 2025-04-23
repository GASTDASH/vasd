import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:vasd/repositories/point/point.dart';

class PointSupabaseRepo {
  const PointSupabaseRepo({
    required SupabaseClient supabaseClient,
  }) : _supabaseClient = supabaseClient;

  final SupabaseClient _supabaseClient;

  Future<List<Point>> getPointList() async {
    final res = await _supabaseClient.from("point").select("*");

    final pointList = res
        .map(
          (row) => Point.fromJson(json: row),
        )
        .toList();

    return pointList;
  }
}
