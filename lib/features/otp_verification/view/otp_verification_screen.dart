import 'package:flutter/material.dart';
import 'package:vasd/ui/ui.dart';

class OtpVerificationScreen extends StatefulWidget {
  const OtpVerificationScreen({super.key});

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
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
              Navigator.pushNamed(context, "/new_password");
            },
            text: "Проверить",
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Введите код", style: theme.textTheme.headlineMedium),
              const SizedBox(height: 12),
              Text("Код подтверждения был отправлен на [...]",
                  style: TextStyle(color: theme.hintColor)),
              const SizedBox(height: 24),
              const SizedBox(
                height: 100,
                child: Placeholder(),
              ),
              const SizedBox(height: 12),
              Align(
                alignment: Alignment.centerRight,
                child: RichText(
                  text: TextSpan(
                    text: "Прислать ещё раз ",
                    style: theme.textTheme.bodyMedium,
                    children: [
                      TextSpan(
                        text: "00:52",
                        style: theme.textTheme.bodyMedium
                            ?.copyWith(color: theme.primaryColor),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
