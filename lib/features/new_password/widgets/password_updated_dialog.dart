import 'package:flutter/material.dart';
import 'package:vasd/ui/ui.dart';

class PasswordUpdatedDialog extends StatelessWidget {
  const PasswordUpdatedDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Dialog(
      backgroundColor: Colors.transparent,
      child: Ink(
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
              SizedBox(
                height: 100,
                width: 100,
                child: CircleAvatar(
                  backgroundColor: theme.primaryColor.withOpacity(0.2),
                  child: SizedBox(
                    height: 80,
                    width: 80,
                    child: CircleAvatar(
                      backgroundColor: theme.primaryColor,
                      child: const Icon(Icons.check_rounded,
                          color: Colors.white, size: 40),
                    ),
                  ),
                ),
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
                  onTap: () {
                    Navigator.pushNamedAndRemoveUntil(
                        context, "/home", (route) => true);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
