import 'package:flutter/material.dart';

class TextFieldCustom extends StatefulWidget {
  const TextFieldCustom({
    super.key,
    this.hintText,
    this.prefixIcon,
    this.password = false,
    this.controller,
    this.onChanged,
    this.multiline = false,
    this.onTap,
    this.enabled = true,
    this.suffixIcon,
    this.label,
    this.focusNode,
    this.onEditingComplete,
  })  : assert(!password || !multiline),
        assert(!password || suffixIcon == null);

  final bool multiline;
  final bool password;
  final bool enabled;
  final String? label;
  final String? hintText;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final TextEditingController? controller;
  final void Function(String)? onChanged;
  final void Function()? onTap;
  final FocusNode? focusNode;
  final void Function()? onEditingComplete;

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
      enabled: widget.enabled,
      onTap: widget.onTap,
      onChanged: widget.onChanged,
      controller: widget.controller,
      obscureText: showPassword,
      focusNode: widget.focusNode,
      onEditingComplete: widget.onEditingComplete,
      onTapOutside: (event) => FocusManager.instance.primaryFocus?.unfocus(),
      keyboardType: widget.multiline ? TextInputType.multiline : null,
      decoration: InputDecoration(
        label: widget.label != null ? Text(widget.label!) : null,
        contentPadding: const EdgeInsets.all(20),
        border: OutlineInputBorder(
            borderSide: BorderSide(color: theme.hintColor, width: 1)),
        disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: theme.hintColor, width: 1)),
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
            : widget.suffixIcon != null
                ? Icon(
                    widget.suffixIcon,
                    size: 32,
                  )
                : null,
      ),
    );
  }
}
