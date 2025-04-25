import 'package:vasd/features/calculate/view/calculate_screen.dart';
import 'package:vasd/features/calculate_delivery_cost/calculate_delivery_cost.dart';
import 'package:vasd/features/forgot_password/forgot_password.dart';
import 'package:vasd/features/home/home.dart';
import 'package:vasd/features/login/login.dart';
import 'package:vasd/features/new_password/new_password.dart';
import 'package:vasd/features/notifications/notifications.dart';
import 'package:vasd/features/otp_verification/otp_verification.dart';
import 'package:vasd/features/package_info/view/package_info_screen.dart';
import 'package:vasd/features/packages/packages.dart';
import 'package:vasd/features/payment/payment.dart';
import 'package:vasd/features/privacy/privacy.dart';
import 'package:vasd/features/profile/profile.dart';
import 'package:vasd/features/register/register.dart';
import 'package:vasd/features/router/router.dart';
import 'package:vasd/features/rules/view/rules_screen.dart';
import 'package:vasd/features/select_point/select_point.dart';
import 'package:vasd/features/send_package/send_package.dart';
import 'package:vasd/features/set_current_location/set_current_location.dart';
import 'package:vasd/features/settings/settings.dart';
import 'package:vasd/features/splash/splash.dart';

final routes = {
  "/splash": (context) => const SplashScreen(),
  //
  "/home": (context) => const RouterScreen(),
  "/home/home": (context) => const HomeScreen(),
  "/home/packages": (context) => const PackagesScreen(),
  "/home/notifications": (context) => const NotificationsScreen(),
  "/home/settings": (context) => const SettingsScreen(),
  //
  "/calculate_delivery_cost": (context) => const CalculateDeliveryCostScreen(),
  "/calculate": (context) => const CalculateScreen(),
  "/send_package": (context) => const SendPackageScreen(),
  "/profile": (context) => const ProfileScreen(),
  "/set_current_location": (context) => const SetCurrentLocationScreen(),
  "/payment": (context) => const PaymentScreen(),
  "/package_info": (context) => const PackageInfoScreen(),
  //
  "/login": (context) => const LoginScreen(),
  "/register": (context) => const RegisterScreen(),
  "/forgot_password": (context) => const ForgotPasswordScreen(),
  "/otp_verification": (context) => const OtpVerificationScreen(),
  "/new_password": (context) => const NewPasswordScreen(),
  "/select_point": (context) => const SelectPointScreen(),
  "/privacy": (context) => const PrivacyScreen(),
  "/rules": (context) => const RulesScreen(),
};
