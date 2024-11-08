import 'package:vasd/features/calculate_delivery_cost/view/calculate_delivery_cost_screen.dart';
import 'package:vasd/features/forgot_password/forgot_password.dart';
import 'package:vasd/features/home/home.dart';
import 'package:vasd/features/login/login.dart';
import 'package:vasd/features/new_password/view/new_password_screen.dart';
import 'package:vasd/features/notifications/view/notifications_screen.dart';
import 'package:vasd/features/otp_verification/otp_verification.dart';
import 'package:vasd/features/packages/view/packages_screen.dart';
import 'package:vasd/features/profile/view/profile_screen.dart';
import 'package:vasd/features/register/register.dart';
import 'package:vasd/features/router/view/router_screen.dart';
import 'package:vasd/features/send_package/send_package.dart';
import 'package:vasd/features/settings/view/settings_screen.dart';

final routes = {
  "/home": (context) => const RouterScreen(),
  "/home/home": (context) => const HomeScreen(),
  "/home/packages": (context) => const PackagesScreen(),
  "/home/notifications": (context) => const NotificationsScreen(),
  "/home/settings": (context) => const SettingsScreen(),
  //
  "/calculate_delivery_cost": (context) => const CalculateDeliveryCostScreen(),
  "/send_package": (context) => const SendPackageScreen(),
  "/profile": (context) => const ProfileScreen(),
  //
  "/login": (context) => const LoginScreen(),
  "/register": (context) => const RegisterScreen(),
  "/forgot_password": (context) => const ForgotPasswordScreen(),
  "/otp_verification": (context) => const OtpVerificationScreen(),
  "/new_password": (context) => const NewPasswordScreen(),
};
