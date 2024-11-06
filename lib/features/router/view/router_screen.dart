import 'package:flutter/material.dart';
import 'package:vasd/routes/routes.dart';

class RouterScreen extends StatefulWidget {
  const RouterScreen({super.key});

  @override
  State<RouterScreen> createState() => _RouterScreenState();
}

class _RouterScreenState extends State<RouterScreen> {
  List<String> pages = [
    "/home/home",
    "/home/packages",
    "/home/notifications",
    "/home/settings",
  ];

  int selectedPage = 0;
  final pageController = PageController();

  @override
  void initState() {
    super.initState();
  }

  void _openPage(int index) {
    setState(() {
      selectedPage = index;
      pageController.animateToPage(index,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOutCubic);
    });
  }

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
                _openPage(0);
              },
              icon: Icon(
                Icons.home_outlined,
                color: selectedPage == 0 ? theme.primaryColor : null,
              ),
            ),
            IconButton(
              onPressed: () {
                _openPage(1);
              },
              icon: Icon(
                Icons.mail_outline,
                color: selectedPage == 1 ? theme.primaryColor : null,
              ),
            ),
            const CircleAvatar(
              backgroundColor: Colors.transparent,
              radius: 32,
            ),
            IconButton(
              onPressed: () {
                _openPage(2);
              },
              icon: Icon(
                Icons.notifications_outlined,
                color: selectedPage == 2 ? theme.primaryColor : null,
              ),
            ),
            IconButton(
              onPressed: () {
                _openPage(3);
              },
              icon: Icon(
                Icons.settings_outlined,
                color: selectedPage == 3 ? theme.primaryColor : null,
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
      /* body: routes[selectedPage]!(context), */
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: pageController,
        children: [
          routes['/home/home']!(context),
          routes['/home/packages']!(context),
          routes['/home/notifications']!(context),
          routes['/home/settings']!(context),
        ],
      ),
    );
  }
}
