import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:vasd/repositories/auth/auth_interface.dart';
import 'package:vasd/ui/ui.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordConfirmController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 32),
                SvgPicture.asset("assets/images/CDEK_logo.svg"),
                const SizedBox(height: 60),
                Text("Создайте свой новый аккаунт!",
                    style: theme.textTheme.headlineMedium),
                const SizedBox(height: 12),
                Text("Введите ваши данные ниже",
                    style: TextStyle(color: theme.hintColor)),
                const SizedBox(height: 24),
                TextFieldCustom(
                  hintText: "Имя пользователя",
                  controller: usernameController,
                  onChanged: (_) {
                    setState(() {});
                  },
                ),
                const SizedBox(height: 16),
                TextFieldCustom(
                  hintText: "Эл. почта",
                  controller: emailController,
                  onChanged: (_) {
                    setState(() {});
                  },
                ),
                const SizedBox(height: 16),
                TextFieldCustom(
                  hintText: "Номер телефона",
                  controller: phoneController,
                  onChanged: (_) {
                    setState(() {});
                  },
                ),
                const SizedBox(height: 16),
                TextFieldCustom(
                  hintText: "Пароль",
                  controller: passwordController,
                  password: true,
                  onChanged: (_) {
                    setState(() {});
                  },
                ),
                const SizedBox(height: 16),
                TextFieldCustom(
                  hintText: "Подтверждение пароля",
                  controller: passwordConfirmController,
                  password: true,
                  onChanged: (_) {
                    setState(() {});
                  },
                ),
                const SizedBox(height: 24),
                ButtonBase(
                  text: "Зарегистрироваться",
                  onTap: (checkTextFieldsNotEmpty())
                      ? () async {
                          try {
                            final userId = await register(
                              name: usernameController.text,
                              email: emailController.text,
                              phone: phoneController.text,
                              password: passwordController.text,
                            );

                            GetIt.I<Talker>().debug("User ID: $userId");

                            await showDialog(
                              context: context,
                              builder: (context) => SuccessDialog(
                                title: "Успешно",
                                text: "Пользователь успешно зарегистрирован",
                                buttonText: "Отлично",
                                onTap: () {
                                  Navigator.pop(context);
                                  Navigator.pushNamed(context, "/login");
                                },
                              ),
                            );
                          } on AuthException catch (e) {
                            await showDialog(
                              context: context,
                              builder: (context) => ErrorDialog(
                                title: "Ошибка",
                                text: e.message,
                              ),
                            );
                          } catch (e) {
                            GetIt.I<Talker>().error(e.toString());
                          }
                        }
                      : null,
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Уже есть аккаунт?"),
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, "/login");
                      },
                      child: Text(
                        "Войти",
                        style: TextStyle(color: theme.primaryColor),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool checkTextFieldsNotEmpty() =>
      usernameController.text.isNotEmpty &&
      emailController.text.isNotEmpty &&
      phoneController.text.isNotEmpty &&
      passwordController.text.isNotEmpty &&
      passwordConfirmController.text.isNotEmpty;

  bool checkPassword() =>
      passwordController.text == passwordConfirmController.text;

  Future<String?> register({
    required String name,
    required String email,
    required String phone,
    required String password,
  }) async {
    if (!checkPassword()) {
      await showDialog(
        context: context,
        builder: (context) => const ErrorDialog(
          title: "Пароли не совпадают",
          text: "Проверьте правильность введённых данных",
        ),
      );
    } else {
      final res = await GetIt.I<AuthInterface>().signUpWithEmailPassword(
        name: name,
        email: email,
        phone: phone,
        password: password,
      );

      return res;
    }
    return null;
  }
}
