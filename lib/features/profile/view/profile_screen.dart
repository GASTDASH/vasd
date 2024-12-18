import 'package:flutter/material.dart';
import 'package:vasd/ui/ui.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.chevron_left_rounded, size: 40),
          ),
          title: Text(
            "Профиль",
            style: theme.textTheme.titleLarge
                ?.copyWith(fontWeight: FontWeight.w700),
          ),
          centerTitle: true,
        ),
        bottomNavigationBar: Container(
          padding: const EdgeInsets.all(18),
          child: ButtonBase(
            onTap: () {
              Navigator.pushNamedAndRemoveUntil(
                  context, "/home", (route) => true);
            },
            text: "Сохранить",
          ),
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
                                image: AssetImage("assets/images/guest.png"),
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
                const SizedBox(height: 24),
                const TextFieldCustom(hintText: "Имя пользователя"),
                const SizedBox(height: 12),
                const TextFieldCustom(hintText: "Эл. почта"),
                const SizedBox(height: 12),
                const TextFieldCustom(hintText: "Телефон"),
                const SizedBox(height: 12),
                const TextFieldCustom(hintText: "Город"),
                const SizedBox(height: 12),
                const TextFieldCustom(hintText: "Адрес"),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
