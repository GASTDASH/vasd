import 'package:vasd/features/forgot_password/view/forgot_password_screen.dart';
import 'package:vasd/features/home/home.dart';
import 'package:vasd/features/login/view/login_screen.dart';
import 'package:vasd/features/register/view/register_screen.dart';
import 'package:vasd/features/send_package/view/send_package_screen.dart';

final routes = {
  "/home": (context) => const HomeScreen(),
  "/send_package": (context) => const SendPackageScreen(),
  "/login": (context) => const LoginScreen(),
  "/register": (context) => const RegisterScreen(),
  "/forgot_password": (context) => const ForgotPasswordScreen(),
};
