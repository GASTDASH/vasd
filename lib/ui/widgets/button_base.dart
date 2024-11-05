import 'package:flutter/material.dart';

class ButtonBase extends StatelessWidget {
  const ButtonBase({
    super.key,
    required this.text,
    this.onTap,
    this.outlined = false,
    this.prefixIcon,
  });

  final String text;
  final Function()? onTap;
  final bool outlined;
  final IconData? prefixIcon; //TODO: Заменить на SVG

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: onTap,
      child: Ink(
        height: 60,
        decoration: BoxDecoration(
          color: outlined
              ? null
              : onTap == null
                  ? theme.hintColor.withOpacity(0.1)
                  : theme.primaryColor,
          borderRadius: BorderRadius.circular(16),
          border: outlined ? Border.all(color: theme.hintColor) : null,
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              prefixIcon != null
                  ? Icon(
                      prefixIcon,
                      color: outlined ? null : Colors.white,
                    )
                  : const SizedBox.shrink(),
              prefixIcon != null
                  ? const SizedBox(
                      width: 8,
                    )
                  : const SizedBox.shrink(),
              Text(
                text,
                style: theme.textTheme.bodyLarge?.copyWith(
                    color: outlined
                        ? Colors.black
                        : onTap == null
                            ? theme.hintColor
                            : Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
