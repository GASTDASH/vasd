import 'package:hive/hive.dart';

part 'package_size.g.dart';

@HiveType(typeId: 3)
class PackageSize {
  PackageSize({
    this.image,
    required this.title,
    required this.size,
  });

  /// URL изображения
  @HiveField(0)
  final String? image;

  /// Название
  @HiveField(1)
  final String title;

  /// Размеры посылки в формате ?x?x?
  @HiveField(2)
  final String size; // "55x35x77 см, до 30 кг"

  String onlySize() {
    return size.split(' ').first;
  }

  String onlyWeight() {
    return size.split(' ').elementAt(3);
  }
}
