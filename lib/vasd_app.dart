import 'package:flutter/material.dart';
import 'package:vasd/routes/routes.dart';
import 'package:vasd/ui/ui.dart';

class VASDApp extends StatelessWidget {
  const VASDApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'VASD',
      theme: lightTheme,
      routes: routes,
    );
  }
}
