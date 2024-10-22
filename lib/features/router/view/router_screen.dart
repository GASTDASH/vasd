import 'package:flutter/material.dart';
import 'package:vasd/routes/routes.dart';

class RouterScreen extends StatefulWidget {
  const RouterScreen({super.key});

  @override
  State<RouterScreen> createState() => _RouterScreenState();
}

class _RouterScreenState extends State<RouterScreen> {
  String selectedPage = "/home";

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      bottomNavigationBar: Container(
        height: 70,
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 20)],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.home_outlined)),
            IconButton(onPressed: () {}, icon: const Icon(Icons.mail_outline)),
            const CircleAvatar(
              backgroundColor: Colors.transparent,
              radius: 32,
            ),
            IconButton(
                onPressed: () {},
                icon: const Icon(Icons.notifications_outlined)),
            IconButton(
                onPressed: () {}, icon: const Icon(Icons.settings_outlined)),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        margin: const EdgeInsets.only(top: 32),
        height: 64,
        width: 64,
        child: FloatingActionButton(
          backgroundColor: theme.primaryColor,
          elevation: 0,
          onPressed: () {},
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
            side: const BorderSide(
                color: Colors.white,
                width: 12,
                strokeAlign: BorderSide.strokeAlignOutside),
          ),
          child: const Icon(Icons.add, color: Colors.white),
        ),
      ),
      body: routes[selectedPage]!(context),
    );
  }
}
