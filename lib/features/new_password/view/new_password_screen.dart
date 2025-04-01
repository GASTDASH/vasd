import 'package:flutter/material.dart';
import 'package:vasd/ui/ui.dart';

class NewPasswordScreen extends StatefulWidget {
  const NewPasswordScreen({super.key});

  @override
  State<NewPasswordScreen> createState() => _NewPasswordScreenState();
}

class _NewPasswordScreenState extends State<NewPasswordScreen> {
  final passwordController = TextEditingController();
  final passwordConfirmController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.chevron_left_rounded, size: 40),
          ),
        ),
        bottomNavigationBar: Container(
          padding: const EdgeInsets.all(18),
          child: ButtonBase(
            onTap: (passwordController.text.isNotEmpty &&
                    passwordConfirmController.text.isNotEmpty)
                ? () async {
                    if (checkPassword()) {
                      // TODO: AuthInterface.resetPassword()

                      await showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (context) => SuccessDialog(
                          title: "Пароль успешно обновлён",
                          text: "Ваш пароль был успешно обновлён",
                          buttonText: "Вернуться домой",
                          onTap: () {
                            Navigator.pushNamedAndRemoveUntil(
                                context, "/home", (route) => false);
                          },
                        ),
                      );
                    } else {
                      await showDialog(
                        context: context,
                        builder: (_) => const ErrorDialog(
                          title: "Пароли не совпадают",
                          text: "Проверьте правильность введённых данных",
                        ),
                      );
                    }
                  }
                : null,
            text: "Сохранить",
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Введите новый пароль",
                  style: theme.textTheme.headlineMedium),
              const SizedBox(height: 12),
              Text("Пожалуйста, введите новый пароль",
                  style: TextStyle(color: theme.hintColor)),
              const SizedBox(height: 24),
              TextFieldCustom(
                prefixIcon: Icons.lock_outline,
                password: true,
                hintText: "Новый пароль",
                controller: passwordController,
                onChanged: (_) {
                  setState(() {});
                },
              ),
              const SizedBox(height: 12),
              TextFieldCustom(
                prefixIcon: Icons.lock_outline,
                password: true,
                hintText: "Подтверждение пароля",
                controller: passwordConfirmController,
                onChanged: (_) {
                  setState(() {});
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool checkPassword() =>
      passwordController.text == passwordConfirmController.text;
}
