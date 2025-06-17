import 'package:flutter/material.dart';

class ErrorBanner extends StatelessWidget {
  const ErrorBanner({
    super.key,
    required this.errorText,
  });

  final String errorText;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      spacing: 12,
      children: [
        const Icon(
          Icons.warning_amber,
          size: 48,
        ),
        Text(
          "Что-то пошло не так!",
          style: theme.textTheme.headlineSmall,
          textAlign: TextAlign.center,
        ),
        Text(
          errorText,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
