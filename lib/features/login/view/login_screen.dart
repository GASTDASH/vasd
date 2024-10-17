import 'package:flutter/material.dart';
import 'package:vasd/ui/ui.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 100,
                width: 100,
                child: Placeholder(
                    child: Center(child: Text("Logo"))), // TODO: Добавить лого
              ),
              const SizedBox(height: 60),
              Text("Давайте войдем в систему!",
                  style: theme.textTheme.headlineMedium),
              const SizedBox(height: 12),
              Text("Введите ваши данные ниже",
                  style: TextStyle(color: theme.hintColor)),
              const SizedBox(height: 24),
              const TextFieldCustom(
                  hintText: "Эл. почта", prefixIcon: Icons.mail_outline),
              const SizedBox(height: 16),
              const TextFieldCustom(
                  hintText: "Пароль",
                  prefixIcon: Icons.lock_outline,
                  password: true),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {},
                  child: Text("Забыли пароль?",
                      style: TextStyle(color: theme.primaryColor)),
                ),
              ),
              const SizedBox(height: 24),
              ButtonBase(
                text: "Войти",
                onTap: () {
                  Navigator.pushReplacementNamed(context, "/home");
                },
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
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: ButtonBase(
                      text: "Google",
                      outlined: true,
                      prefixIcon:
                          Icons.g_mobiledata, // TODO: Заменить иконки на SVG
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: ButtonBase(
                      text: "Facebook",
                      outlined: true,
                      prefixIcon:
                          Icons.facebook, // TODO: Заменить иконки на SVG
                    ),
                  ),
                ],
              ),
              const Expanded(child: SizedBox.expand()),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Ещё нет аккаунта?"),
                  TextButton(
                    onPressed: () {},
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
    );
  }
}
