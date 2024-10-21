import 'package:flutter/material.dart';
import 'package:vasd/ui/ui.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(18),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 100,
                  width: 100,
                  child: Placeholder(
                      child:
                          Center(child: Text("Logo"))), // TODO: Добавить лого
                ),
                const SizedBox(height: 60),
                Text("Давайте войдем в систему!",
                    style: theme.textTheme.headlineMedium),
                const SizedBox(height: 12),
                Text("Введите ваши данные ниже",
                    style: TextStyle(color: theme.hintColor)),
                const SizedBox(height: 24),
                const TextFieldCustom(hintText: "Имя пользователя"),
                const SizedBox(height: 16),
                const TextFieldCustom(hintText: "Эл. почта"),
                const SizedBox(height: 16),
                const TextFieldCustom(hintText: "Номер телефона"),
                const SizedBox(height: 16),
                const TextFieldCustom(hintText: "Город"),
                const SizedBox(height: 16),
                const TextFieldCustom(hintText: "Адрес"),
                const SizedBox(height: 24),
                ButtonBase(
                  text: "Войти",
                  onTap: () {
                    Navigator.pushReplacementNamed(context, "/home");
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Уже есть аккаунт?"),
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, "/login");
                      },
                      child: Text(
                        "Войти",
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
