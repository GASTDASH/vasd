import 'package:flutter/material.dart';
import 'package:vasd/ui/ui.dart';

class NewPasswordScreen extends StatefulWidget {
  const NewPasswordScreen({super.key});

  @override
  State<NewPasswordScreen> createState() => _NewPasswordScreenState();
}

class _NewPasswordScreenState extends State<NewPasswordScreen> {
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
            onTap: () {
              // Navigator.pushNamed(context, "/new_password");
              showDialog(
                context: context,
                builder: (context) => const PasswordUpdatedDialog(),
              );
            },
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
              const TextFieldCustom(
                prefixIcon: Icons.lock_outline,
                password: true,
                hintText: "Новый пароль",
              ),
              const SizedBox(height: 12),
              const TextFieldCustom(
                prefixIcon: Icons.lock_outline,
                password: true,
                hintText: "Подтверждение пароля",
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PasswordUpdatedDialog extends StatelessWidget {
  const PasswordUpdatedDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Dialog(
      child: Container(
        decoration: BoxDecoration(
          color: theme.scaffoldBackgroundColor,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(
                height: 100,
                width: 100,
                child: Placeholder(),
              ),
              const SizedBox(height: 12),
              Text(
                "Пароль успешно обновлён",
                style: theme.textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              const Text(
                "Ваш пароль был успешно обновлён",
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              SizedBox(
                height: 50,
                child: ButtonBase(
                  text: "Вернуться домой",
                  onTap: () {},
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
