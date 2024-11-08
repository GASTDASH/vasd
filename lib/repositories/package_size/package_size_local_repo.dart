import 'package:vasd/repositories/package_size/models/package_size.dart';
import 'package:vasd/repositories/package_size/package_size_interface.dart';

class PackageSizeLocalRepo implements PackageSizeInterface {
  final List<PackageSize> _packageSizeList = [
    PackageSize(
      title: "Конверт",
      size: "34x27x2 см, до 0.5 кг",
    ),
    PackageSize(
      title: "Короб XS",
      size: "34x27x2 см, до 0.5 кг",
    ),
    PackageSize(
      title: "Короб S",
      size: "34x27x2 см, до 0.5 кг",
    ),
    PackageSize(
      title: "Короб M",
      size: "34x27x2 см, до 0.5 кг",
    ),
    PackageSize(
      title: "Короб L",
      size: "34x27x2 см, до 0.5 кг",
    ),
    PackageSize(
      title: "Короб XL",
      size: "34x27x2 см, до 0.5 кг",
    ),
    PackageSize(
      title: "Большой короб, ящик",
      size: "34x27x2 см, до 0.5 кг",
    ),
    PackageSize(
      title: "Чемодан",
      size: "34x27x2 см, до 0.5 кг",
    ),
    PackageSize(
      title: "Паллета",
      size: "34x27x2 см, до 0.5 кг",
    ),
  ];

  @override
  Future<List<PackageSize>> getItems() async {
    return _packageSizeList;
  }
}
