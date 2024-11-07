import 'package:flutter/material.dart';

class TextFieldCustom extends StatefulWidget {
  const TextFieldCustom({
    super.key,
    required this.hintText,
    this.prefixIcon,
    this.password = false,
    this.controller,
    this.onChanged,
    this.multiline = false,
  }) : assert(!password || !multiline);

  final String? hintText;
  final IconData? prefixIcon;
  final bool password;
  final TextEditingController? controller;
  final void Function(String)? onChanged;
  final bool multiline;

  @override
  State<TextFieldCustom> createState() => _TextFieldCustomState();
}

class _TextFieldCustomState extends State<TextFieldCustom> {
  bool showPassword = false;

  @override
  void initState() {
    super.initState();

    if (widget.password) showPassword = true;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return TextField(
      onChanged: widget.onChanged,
      controller: widget.controller,
      obscureText: showPassword,
      keyboardType: widget.multiline ? TextInputType.multiline : null,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(20),
        border: const OutlineInputBorder(),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: theme.primaryColor),
        ),
        hintText: widget.hintText,
        prefixIcon: widget.prefixIcon != null
            ? Icon(widget.prefixIcon, color: theme.hintColor)
            : null,
        hintStyle:
            const TextStyle(color: Colors.grey, fontWeight: FontWeight.w400),
        suffixIcon: widget.password
            ? IconButton(
                onPressed: () {
                  setState(() {
                    showPassword = !showPassword;
                  });
                },
                icon: !showPassword
                    ? Icon(Icons.visibility_outlined, color: theme.hintColor)
                    : Icon(Icons.visibility_off_outlined,
                        color: theme.hintColor))
            : null,
      ),
    );
  }
}
