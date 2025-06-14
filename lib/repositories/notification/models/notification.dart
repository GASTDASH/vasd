class Notification {
  Notification({
    required this.createdAt,
    required this.title,
    required this.text,
    required this.deliveryId,
    required this.statusCode,
  });

  final DateTime createdAt;
  final String title;
  final String text;
  final String deliveryId;
  final int statusCode;
}
