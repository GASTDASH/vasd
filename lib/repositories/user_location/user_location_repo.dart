import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:vasd/repositories/point/point.dart';

class UserLocationRepo extends ChangeNotifier {
  static const String _locationKey = 'user_location';

  Point? get location {
    final box = Hive.box('settings');
    return box.get(_locationKey);
  }

  Future<void> updateLocation(Point point) async {
    final box = Hive.box('settings');
    await box.put(_locationKey, point);

    notifyListeners();
  }
}
