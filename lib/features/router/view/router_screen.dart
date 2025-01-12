import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
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

    return SafeArea(
      child: Scaffold(
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
                onPressed: () => _openPage(0),
                icon: SvgPicture.asset(
                  "assets/icons/home.svg",
                  colorFilter: ColorFilter.mode(
                    selectedPage == 0 ? theme.primaryColor : Colors.black,
                    BlendMode.srcIn,
                  ),
                ),
              ),
              IconButton(
                onPressed: () {
                  _openPage(1);
                },
                icon: SvgPicture.asset(
                  "assets/icons/cube.svg",
                  colorFilter: ColorFilter.mode(
                    selectedPage == 1 ? theme.primaryColor : Colors.black,
                    BlendMode.srcIn,
                  ),
                  height: 32,
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
                icon: SvgPicture.asset(
                  "assets/icons/bell.svg",
                  colorFilter: ColorFilter.mode(
                    selectedPage == 2 ? theme.primaryColor : Colors.black,
                    BlendMode.srcIn,
                  ),
                  height: 28,
                ),
              ),
              IconButton(
                onPressed: () {
                  _openPage(3);
                },
                icon: SvgPicture.asset(
                  "assets/icons/settings.svg",
                  colorFilter: ColorFilter.mode(
                    selectedPage == 3 ? theme.primaryColor : Colors.black,
                    BlendMode.srcIn,
                  ),
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
      ),
    );
  }
}
