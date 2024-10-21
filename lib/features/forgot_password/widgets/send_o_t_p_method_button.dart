import 'package:flutter/material.dart';

class SendOTPMethodButton extends StatefulWidget {
  const SendOTPMethodButton({
    super.key,
    required this.selected,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.onTap,
  });

  final bool selected;
  final String title;
  final String subtitle;
  final IconData icon;
  final Function() onTap;

  @override
  State<SendOTPMethodButton> createState() => _SendOTPMethodButtonState();
}

class _SendOTPMethodButtonState extends State<SendOTPMethodButton> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      splashColor: theme.primaryColor.withOpacity(0.2),
      onTap: widget.onTap,
      child: Ink(
        height: 80,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            width: 1,
            color: widget.selected ? theme.primaryColor : theme.hintColor,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundColor: widget.selected
                    ? theme.primaryColor
                    : theme.hintColor.withOpacity(0.2),
                child: Icon(
                  widget.icon,
                  color: widget.selected ? Colors.white : theme.hintColor,
                ),
              ),
              const SizedBox(width: 8),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.title, style: TextStyle(color: theme.hintColor)),
                  Text(widget.subtitle, style: theme.textTheme.bodyLarge),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
