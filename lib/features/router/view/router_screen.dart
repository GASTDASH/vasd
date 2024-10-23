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
            IconButton(
              onPressed: () {
                selectedPage = "/home";
                setState(() {});
              },
              icon: Icon(
                Icons.home_outlined,
                color: selectedPage == "/home" ? theme.primaryColor : null,
              ),
            ),
            IconButton(
              onPressed: () {
                selectedPage = "/packages";
                setState(() {});
              },
              icon: Icon(
                Icons.mail_outline,
                color: selectedPage == "/packages" ? theme.primaryColor : null,
              ),
            ),
            const CircleAvatar(
              backgroundColor: Colors.transparent,
              radius: 32,
            ),
            IconButton(
              onPressed: () {
                selectedPage = "/notifications";
                setState(() {});
              },
              icon: Icon(
                Icons.notifications_outlined,
                color: selectedPage == "/notifications"
                    ? theme.primaryColor
                    : null,
              ),
            ),
            IconButton(
              onPressed: () {
                selectedPage = "/settings";
                setState(() {});
              },
              icon: Icon(
                Icons.settings_outlined,
                color: selectedPage == "/settings" ? theme.primaryColor : null,
              ),
            ),
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
