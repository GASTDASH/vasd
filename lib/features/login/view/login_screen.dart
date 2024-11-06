import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vasd/ui/ui.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 100,
                  width: 100,
                  child: Image.asset("assets/images/logo.jpg"),
                ),
                const SizedBox(height: 60),
                Text("Давайте войдем в систему!",
                    style: theme.textTheme.headlineMedium),
                const SizedBox(height: 12),
                Text("Введите ваши данные ниже",
                    style: TextStyle(color: theme.hintColor)),
                const SizedBox(height: 24),
                TextFieldCustom(
                  hintText: "Эл. почта",
                  prefixIcon: Icons.mail_outline,
                  controller: emailController,
                  onChanged: (_) {
                    setState(() {});
                  },
                ),
                const SizedBox(height: 16),
                TextFieldCustom(
                  hintText: "Пароль",
                  prefixIcon: Icons.lock_outline,
                  password: true,
                  controller: passwordController,
                  onChanged: (_) {
                    setState(() {});
                  },
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, "/forgot_password");
                    },
                    child: Text("Забыли пароль?",
                        style: TextStyle(color: theme.primaryColor)),
                  ),
                ),
                const SizedBox(height: 24),
                ButtonBase(
                  text: "Войти",
                  onTap: (emailController.text.isNotEmpty &&
                          passwordController.text.isNotEmpty)
                      ? () {
                          Navigator.pushReplacementNamed(context, "/home");
                        }
                      : null,
                ),
                const SizedBox(height: 24),
                const Row(
                  children: [
                    Expanded(child: Divider()),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Text("Или войти через"),
                    ),
                    Expanded(child: Divider()),
                  ],
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      child: ButtonBase(
                        onTap: () {},
                        text: "Google",
                        outlined: true,
                        prefixIcon: SvgPicture.asset(
                          "assets/icons/google.svg",
                          colorFilter: const ColorFilter.mode(
                              Colors.black, BlendMode.srcIn),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: ButtonBase(
                        onTap: () {},
                        text: "Facebook",
                        outlined: true,
                        prefixIcon: SvgPicture.asset(
                          "assets/icons/facebook.svg",
                          colorFilter: const ColorFilter.mode(
                              Colors.black, BlendMode.srcIn),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Ещё нет аккаунта?"),
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, "/register");
                      },
                      child: Text(
                        "Зарегистрироваться",
                        style: TextStyle(color: theme.primaryColor),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
