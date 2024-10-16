import 'package:flutter/material.dart';

class TextBox extends StatelessWidget {
  const TextBox({
    super.key,
    required this.hintText,
  });

  final String? hintText;

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        hintText: hintText,
        hintStyle: const TextStyle(
          color: Colors.grey,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}
