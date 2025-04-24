import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as supabase;
import 'package:vasd/bloc/auth/auth_bloc.dart';
import 'package:vasd/routes/routes.dart';
import 'package:vasd/ui/ui.dart';

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
  // late StreamSubscription authSubscription;

  @override
  void initState() {
    super.initState();

    // authSubscription = GetIt.I<SupabaseClient>().auth.onAuthStateChange.listen(
    //   (event) {
    //     if (event.session == null) {
    //       if (mounted) {
    //         ScaffoldMessenger.of(context).showSnackBar(
    //             const SnackBar(content: Text("You have logged out")));

    //         Navigator.pushNamedAndRemoveUntil(
    //             context, "/login", (route) => false);
    //       }
    //     }
    //   },
    // );
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
    final canPop = ModalRoute.of(context)?.canPop ?? false;

    return BlocBuilder<AuthBloc, AuthState>(
      bloc: context.read<AuthBloc>(),
      builder: (context, state) {
        return StreamBuilder<supabase.AuthState>(
            stream: GetIt.I<supabase.SupabaseClient>().auth.onAuthStateChange,
            builder: (context, snapshot) {
              if ((!snapshot.hasData || snapshot.data!.session == null) &&
                  state is AuthAuthorizedState) {
                return const Scaffold(
                  body: Center(
                    child: Text("Вы вышли из аккаунта"),
                  ),
                );
              } else {
                return PopScope(
                  onPopInvokedWithResult: (didPop, result) {
                    if (!canPop) {
                      showDialog(
                        context: context,
                        builder: (context) => BaseDialog(
                          icon: const Icon(
                            Icons.door_back_door_outlined,
                            size: 48,
                            color: Colors.white,
                          ),
                          color: theme.primaryColor,
                          title: "Выход",
                          text:
                              "Вы уверены что хотите выйти из приложения? Вы не выйдите из своего аккаунта.",
                          child: Row(
                            spacing: 12,
                            children: [
                              Expanded(
                                child: ButtonBase(
                                  text: "Да",
                                  onTap: () {
                                    SystemNavigator.pop();
                                  },
                                ),
                              ),
                              Expanded(
                                child: ButtonBase(
                                  text: "Нет",
                                  outlined: true,
                                  onTap: () {
                                    Navigator.of(context).pop();
                                  },
                                  color: theme.primaryColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                  },
                  canPop: canPop,
                  child: SafeArea(
                    child: Scaffold(
                      bottomNavigationBar: Container(
                        height: 70,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(color: Colors.black12, blurRadius: 20)
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            IconButton(
                              onPressed: () => _openPage(0),
                              icon: SvgPicture.asset(
                                "assets/icons/home.svg",
                                colorFilter: ColorFilter.mode(
                                  selectedPage == 0
                                      ? theme.primaryColor
                                      : Colors.black,
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
                                  selectedPage == 1
                                      ? theme.primaryColor
                                      : Colors.black,
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
                                  selectedPage == 2
                                      ? theme.primaryColor
                                      : Colors.black,
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
                                  selectedPage == 3
                                      ? theme.primaryColor
                                      : Colors.black,
                                  BlendMode.srcIn,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      floatingActionButtonLocation:
                          FloatingActionButtonLocation.centerDocked,
                      floatingActionButton: Container(
                        margin: const EdgeInsets.only(top: 32),
                        height: 64,
                        width: 64,
                        child: FloatingActionButton(
                          backgroundColor: theme.primaryColor,
                          elevation: 0,
                          onPressed: () {
                            Navigator.pushNamed(context, "/calculate");
                          },
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
                  ),
                );
              }
            });
      },
    );
  }
}
