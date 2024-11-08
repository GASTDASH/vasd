import 'package:vasd/repositories/package_size/models/package_size.dart';

abstract class PackageSizeInterface {
  Future<List<PackageSize>> getItems();
}
