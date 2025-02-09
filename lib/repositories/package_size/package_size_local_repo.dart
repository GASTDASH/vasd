import 'package:vasd/repositories/package_size/models/package_size.dart';
import 'package:vasd/repositories/package_size/package_size_interface.dart';

class PackageSizeLocalRepo implements PackageSizeInterface {
  final List<PackageSize> _packageSizeList = [
    PackageSize(
      image: "convert.png",
      title: "Конверт",
      size: "34x27x2 см, до 0.5 кг",
    ),
    PackageSize(
      image: "xs.svg",
      title: "Короб XS",
      size: "17x12x9 см, до 0.5 кг",
    ),
    PackageSize(
      image: "s.svg",
      title: "Короб S",
      size: "23x19x10 см, до 2 кг",
    ),
    PackageSize(
      image: "m.svg",
      title: "Короб M",
      size: "33x25x15 см, до 5 кг",
    ),
    PackageSize(
      image: "l.svg",
      title: "Короб L",
      size: "31x25x38 см, до 12 кг",
    ),
    PackageSize(
      image: "xl.svg",
      title: "Короб XL",
      size: "60x35x30 см, до 18 кг",
    ),
    PackageSize(
      image: "xxl.png",
      title: "Большой короб, ящик",
      size: "60x60x30 см, до 20 кг",
    ),
    PackageSize(
      image: "suitcase.png",
      title: "Чемодан",
      size: "55x35x77 см, до 30 кг",
    ),
    PackageSize(
      image: "pallet.png",
      title: "Паллета",
      size: "120x120x80 см, до 200 кг",
    ),
  ];

  @override
  Future<List<PackageSize>> getItems() async {
    return _packageSizeList;
  }
}
