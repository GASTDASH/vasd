import 'package:vasd/features/home/home.dart';
import 'package:vasd/features/login/view/login_screen.dart';
import 'package:vasd/features/send_package/view/send_package_screen.dart';

final routes = {
  "/home": (context) => const HomeScreen(),
  "/send_package": (context) => const SendPackageScreen(),
  "/login": (context) => const LoginScreen(),
};
