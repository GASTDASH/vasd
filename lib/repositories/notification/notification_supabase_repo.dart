import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:vasd/repositories/notification/notification.dart';

class NotificationSupabaseRepo {
  const NotificationSupabaseRepo({
    required SupabaseClient supabaseClient,
  }) : _supabaseClient = supabaseClient;

  final SupabaseClient _supabaseClient;

  Future<List<Notification>> getNotificationsByUser({required String userId}) async {
    var notificationsRaw = await _supabaseClient.from("notification").select("*").eq("user_id", userId);

    List<Notification> notifications = notificationsRaw
        .map(
          (row) => Notification(
              createdAt: DateTime.parse(row["created_at"]),
              title: row["title"],
              text: row["text"],
              deliveryId: row["delivery_id"],
              statusCode: row["status_code"]),
        )
        .toList();

    return notifications;
  }
}
