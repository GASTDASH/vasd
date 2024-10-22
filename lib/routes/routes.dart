import 'package:vasd/features/forgot_password/forgot_password.dart';
import 'package:vasd/features/home/home.dart';
import 'package:vasd/features/login/login.dart';
import 'package:vasd/features/new_password/view/new_password_screen.dart';
import 'package:vasd/features/otp_verification/otp_verification.dart';
import 'package:vasd/features/profile/view/profile_screen.dart';
import 'package:vasd/features/register/register.dart';
import 'package:vasd/features/router/view/router_screen.dart';
import 'package:vasd/features/send_package/send_package.dart';

final routes = {
  "/": (context) => const RouterScreen(),
  "/home": (context) => const HomeScreen(),
  "/send_package": (context) => const SendPackageScreen(),
  "/login": (context) => const LoginScreen(),
  "/register": (context) => const RegisterScreen(),
  "/forgot_password": (context) => const ForgotPasswordScreen(),
  "/otp_verification": (context) => const OtpVerificationScreen(),
  "/new_password": (context) => const NewPasswordScreen(),
  "/profile": (context) => const ProfileScreen(),
};
