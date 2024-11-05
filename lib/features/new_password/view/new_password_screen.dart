import 'package:flutter/material.dart';
import 'package:vasd/features/new_password/new_password.dart';
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
                    // Navigator.pushNamed(context, "/new_password");
                    await showDialog(
                      context: context,
                      builder: (context) => const PasswordUpdatedDialog(),
                    );
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
}
