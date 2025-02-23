class Status {
  const Status({
    required this.statusCode,
    required this.name,
  });

  final int statusCode;
  final String name;

  factory Status.fromJson({
    required Map<String, dynamic> json,
  }) {
    return Status(
      statusCode: json["status_code"],
      name: json["name"],
    );
  }
}
