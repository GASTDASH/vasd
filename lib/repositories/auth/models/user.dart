class User {
  User({
    required this.id,
    this.email,
    this.name,
    this.phone,
    this.photoUrl,
  });

  final String id;
  final String? email;
  final String? name;
  final String? phone;
  final String? photoUrl;
}
