import 'package:flutter/material.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({
    super.key,
    required this.title,
    this.text,
  });

  final String title;
  final String? text;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 100,
              width: 100,
              child: CircularProgressIndicator(strokeWidth: 10),
            ),
            const SizedBox(height: 40),
            Text(
              title,
              style: const TextStyle(fontSize: 32),
            ),
            const SizedBox(height: 4),
            text != null ? Text(text!) : const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
