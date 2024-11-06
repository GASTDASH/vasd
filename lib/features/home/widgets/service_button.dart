import 'package:flutter/material.dart';

class ServiceButton extends StatelessWidget {
  const ServiceButton({
    super.key,
    this.onTap,
    required this.text,
    required this.icon,
  });

  final void Function()? onTap;
  final String text;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Expanded(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18),
        child: Ink(
          decoration: BoxDecoration(
            color: theme.primaryColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(18),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 48,
                color: theme.primaryColor,
              ),
              const SizedBox(height: 12),
              Text(
                text,
                style: theme.textTheme.titleLarge
                    ?.copyWith(fontWeight: FontWeight.w800),
              )
            ],
          ),
        ),
      ),
    );
  }
}
