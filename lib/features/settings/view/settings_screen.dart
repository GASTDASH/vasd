import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vasd/features/settings/settings.dart';
import 'package:vasd/ui/ui.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Профиль",
            style: theme.textTheme.titleLarge
                ?.copyWith(fontWeight: FontWeight.w700),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              children: [
                Center(
                  child: SizedBox(
                    height: 100,
                    width: 100,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(12),
                      onTap: () {
                        // TODO: Edit photo
                      },
                      child: Stack(
                        children: [
                          Container(
                            margin: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              image: const DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                    "https://i.imgur.com/867trdy.jpeg"),
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: Container(
                              height: 30,
                              width: 30,
                              decoration: BoxDecoration(
                                color: theme.primaryColor,
                                borderRadius: BorderRadius.circular(50),
                                border: Border.all(color: Colors.white),
                              ),
                              child: const Icon(
                                Icons.edit_outlined,
                                color: Colors.white,
                                size: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                const Text("Username username",
                    style:
                        TextStyle(fontSize: 21, fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Text("username@gmail.com",
                    style: TextStyle(fontSize: 14, color: theme.hintColor)),
                const SizedBox(height: 24),
                SettingsButton(
                  icon: SvgPicture.asset(
                    "assets/icons/edit.svg",
                    colorFilter:
                        const ColorFilter.mode(Colors.black, BlendMode.srcIn),
                  ),
                  text: "Редактировать профиль",
                  onTap: () {
                    Navigator.pushNamed(context, "/profile");
                  },
                ),
                const Divider(thickness: 0.2, height: 0),
                SettingsButton(
                  icon: SvgPicture.asset(
                    "assets/icons/map_marker.svg",
                    colorFilter:
                        const ColorFilter.mode(Colors.black, BlendMode.srcIn),
                  ),
                  text: "Мой адрес",
                  onTap: () {},
                ),
                const Divider(thickness: 0.2, height: 0),
                SettingsButton(
                  icon: SvgPicture.asset(
                    "assets/icons/box.svg",
                    colorFilter:
                        const ColorFilter.mode(Colors.black, BlendMode.srcIn),
                  ),
                  text: "Мои заказы",
                  onTap: () {},
                ),
                const Divider(thickness: 0.2, height: 0),
                SettingsButton(
                  icon: SvgPicture.asset(
                    "assets/icons/lock.svg",
                    colorFilter:
                        const ColorFilter.mode(Colors.black, BlendMode.srcIn),
                  ),
                  text: "Сменить пароль",
                  onTap: () {},
                ),
                const Divider(thickness: 0.2, height: 0),
                SettingsButton(
                  icon: SvgPicture.asset("assets/icons/banner.svg",
                      colorFilter: const ColorFilter.mode(
                          Colors.black, BlendMode.srcIn)),
                  text: "Политика конфиденциальности",
                  onTap: () {},
                ),
                const Divider(thickness: 0.2, height: 0),
                SettingsButton(
                  icon: SvgPicture.asset("assets/icons/terms.svg",
                      colorFilter: const ColorFilter.mode(
                          Colors.black, BlendMode.srcIn)),
                  text: "Условия использования",
                  onTap: () {},
                ),
                const SizedBox(height: 24),
                ButtonBase(
                  text: "Выйти",
                  prefixIcon: const Icon(
                    Icons.logout_rounded,
                    color: Colors.white,
                  ),
                  onTap: () {
                    Navigator.pushNamedAndRemoveUntil(
                        context, "/login", (route) => false);
                  },
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
