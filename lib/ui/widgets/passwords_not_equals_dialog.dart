import 'package:flutter/material.dart';
import 'package:vasd/ui/ui.dart';

class PasswordsNotEqualsDialog extends StatelessWidget {
  const PasswordsNotEqualsDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BaseDialog(
      icon: const Icon(Icons.close_rounded, color: Colors.white, size: 40),
      color: theme.colorScheme.error,
      title: "Пароли не совпадают",
      text: "Проверьте правильность введённых данных",
    );
  }
}
