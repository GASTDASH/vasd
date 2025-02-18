class PackageSize {
  PackageSize({
    this.image,
    required this.title,
    required this.size,
  });

  final String? image;
  final String title;
  final String size; // "55x35x77 см, до 30 кг"

  String onlySize() {
    return size.split(' ').first;
  }

  String onlyWeight() {
    return size.split(' ').elementAt(3);
  }
}
