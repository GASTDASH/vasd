import 'package:flutter/material.dart';
import 'package:vasd/ui/ui.dart';

class SuccessDialog extends StatelessWidget {
  const SuccessDialog({
    super.key,
    required this.title,
    required this.text,
    required this.buttonText,
    this.onTap,
  });

  final String title;
  final String text;
  final String buttonText;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BaseDialog(
      icon: const Icon(Icons.check_rounded, color: Colors.white, size: 40),
      color: theme.primaryColor,
      title: title,
      text: text,
      child: SizedBox(
        height: 50,
        child: ButtonBase(
          text: buttonText,
          onTap: onTap,
        ),
      ),
    );
  }
}
