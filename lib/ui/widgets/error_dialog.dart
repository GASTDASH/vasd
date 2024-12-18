import 'package:flutter/material.dart';
import 'package:vasd/ui/ui.dart';

class ErrorDialog extends StatelessWidget {
  const ErrorDialog({
    super.key,
    required this.title,
    required this.text,
  });

  final String title;
  final String text;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BaseDialog(
      icon: const Icon(Icons.close_rounded, color: Colors.white, size: 40),
      color: theme.colorScheme.error,
      title: title,
      text: text,
    );
  }
}
