import 'package:flutter/material.dart';

class TextFieldCustom extends StatefulWidget {
  const TextFieldCustom({
    super.key,
    required this.hintText,
    this.prefixIcon,
    this.password = false,
  });
  // : assert();

  final String? hintText;
  final IconData? prefixIcon;
  final bool password;

  @override
  State<TextFieldCustom> createState() => _TextFieldCustomState();
}

class _TextFieldCustomState extends State<TextFieldCustom> {
  bool showPassword = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return TextField(
      obscureText: !showPassword,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        hintText: widget.hintText,
        prefixIcon: Icon(widget.prefixIcon, color: theme.hintColor),
        hintStyle:
            const TextStyle(color: Colors.grey, fontWeight: FontWeight.w400),
        suffixIcon: widget.password
            ? IconButton(
                onPressed: () {
                  setState(() {
                    showPassword = !showPassword;
                  });
                },
                icon: showPassword
                    ? Icon(Icons.visibility_outlined, color: theme.hintColor)
                    : Icon(Icons.visibility_off_outlined,
                        color: theme.hintColor))
            : null,
      ),
    );
  }
}
