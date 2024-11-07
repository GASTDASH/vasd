import 'package:flutter/material.dart';
import 'package:vasd/ui/ui.dart';

class PasswordUpdatedDialog extends StatelessWidget {
  const PasswordUpdatedDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BaseDialog(
      icon: const Icon(Icons.check_rounded, color: Colors.white, size: 40),
      color: theme.primaryColor,
      title: "Пароль успешно обновлён",
      text: "Ваш пароль был успешно обновлён",
      child: SizedBox(
        height: 50,
        child: ButtonBase(
          text: "Вернуться домой",
          onTap: () {
            Navigator.pushNamedAndRemoveUntil(
                context, "/home", (route) => true);
          },
        ),
      ),
    );
  }
}
