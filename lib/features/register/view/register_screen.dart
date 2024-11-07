import 'package:flutter/material.dart';
import 'package:vasd/ui/widgets/passwords_not_equals_dialog.dart';
import 'package:vasd/ui/ui.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final cityController = TextEditingController();
  final addressController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordConfirmController = TextEditingController();

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
                SizedBox(
                    height: 100,
                    width: 100,
                    child: Image.asset("assets/images/logo.jpg")),
                const SizedBox(height: 60),
                Text("Создайте свой новый аккаунт!",
                    style: theme.textTheme.headlineMedium),
                const SizedBox(height: 12),
                Text("Введите ваши данные ниже",
                    style: TextStyle(color: theme.hintColor)),
                const SizedBox(height: 24),
                TextFieldCustom(
                  hintText: "Имя пользователя",
                  controller: usernameController,
                  onChanged: (_) {
                    setState(() {});
                  },
                ),
                const SizedBox(height: 16),
                TextFieldCustom(
                  hintText: "Эл. почта",
                  controller: emailController,
                  onChanged: (_) {
                    setState(() {});
                  },
                ),
                const SizedBox(height: 16),
                TextFieldCustom(
                  hintText: "Номер телефона",
                  controller: phoneController,
                  onChanged: (_) {
                    setState(() {});
                  },
                ),
                const SizedBox(height: 16),
                TextFieldCustom(
                  hintText: "Город",
                  controller: cityController,
                  onChanged: (_) {
                    setState(() {});
                  },
                ),
                const SizedBox(height: 16),
                TextFieldCustom(
                  hintText: "Адрес",
                  controller: addressController,
                  onChanged: (_) {
                    setState(() {});
                  },
                ),
                const SizedBox(height: 16),
                TextFieldCustom(
                  hintText: "Пароль",
                  controller: passwordController,
                  password: true,
                  onChanged: (_) {
                    setState(() {});
                  },
                ),
                const SizedBox(height: 16),
                TextFieldCustom(
                  hintText: "Подтверждение пароля",
                  controller: passwordConfirmController,
                  password: true,
                  onChanged: (_) {
                    setState(() {});
                  },
                ),
                const SizedBox(height: 24),
                ButtonBase(
                  text: "Зарегистрироваться",
                  onTap: (checkTextFieldsNotEmpty())
                      ? () async {
                          if (checkPassword()) {
                            Navigator.pushReplacementNamed(context, "/login");
                          } else {
                            await showDialog(
                              context: context,
                              builder: (context) =>
                                  const PasswordsNotEqualsDialog(),
                            );
                          }
                        }
                      : null,
                ),
                const SizedBox(height: 24),
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

  bool checkTextFieldsNotEmpty() =>
      usernameController.text.isNotEmpty &&
      emailController.text.isNotEmpty &&
      phoneController.text.isNotEmpty &&
      cityController.text.isNotEmpty &&
      addressController.text.isNotEmpty &&
      passwordController.text.isNotEmpty &&
      passwordConfirmController.text.isNotEmpty;

  bool checkPassword() =>
      passwordController.text == passwordConfirmController.text;
}
