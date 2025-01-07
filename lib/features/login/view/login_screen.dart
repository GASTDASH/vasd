import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as Supabase;
import 'package:vasd/bloc/auth/auth_bloc.dart';
import 'package:vasd/ui/ui.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final authBloc = context.read<AuthBloc>();

    return BlocListener<AuthBloc, AuthState>(
      bloc: authBloc,
      listener: (context, state) {
        if (state is AuthLoadingState) {
          showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) => const LoadingDialog(),
          );
        } else if (state.error != null) {
          var errorText = "Unexpected Error";

          if (state.error is Supabase.AuthException) {
            if ((state.error as Supabase.AuthException).code ==
                "invalid_credentials") {
              errorText = "Неправильный логин или пароль";
            } else {
              errorText = state.error.toString();
            }
          }

          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(errorText),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 2),
          ));
        } else if (state is AuthAuthorizedState) {
          Navigator.of(context).pushReplacementNamed("/home");
        }
      },
      listenWhen: (previous, current) {
        if (previous is AuthLoadingState) {
          Navigator.pop(context);
        }
        return true;
      },
      child: SafeArea(
          child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 32),
                SvgPicture.asset("assets/images/CDEK_logo.svg"),
                const SizedBox(height: 60),
                Text("Давайте войдем в систему!",
                    style: theme.textTheme.headlineMedium),
                const SizedBox(height: 12),
                Text("Введите ваши данные ниже",
                    style: TextStyle(color: theme.hintColor)),
                const SizedBox(height: 24),
                TextFieldCustom(
                  hintText: "Эл. почта",
                  prefixIcon: Icons.mail_outline,
                  controller: emailController,
                  onChanged: (_) {
                    setState(() {});
                  },
                ),
                const SizedBox(height: 16),
                TextFieldCustom(
                  hintText: "Пароль",
                  prefixIcon: Icons.lock_outline,
                  password: true,
                  controller: passwordController,
                  onChanged: (_) {
                    setState(() {});
                  },
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, "/forgot_password");
                    },
                    child: Text("Забыли пароль?",
                        style: TextStyle(color: theme.primaryColor)),
                  ),
                ),
                const SizedBox(height: 24),
                ButtonBase(
                  text: "Войти",
                  onTap: (emailController.text.isNotEmpty &&
                          passwordController.text.isNotEmpty)
                      ? () async {
                          authBloc.add(
                            AuthLoginEvent(
                                email: emailController.text,
                                password: passwordController.text),
                          );
                        }
                      : null,
                ),
                const SizedBox(height: 24),
                const Row(
                  children: [
                    Expanded(child: Divider()),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Text("Или войти через"),
                    ),
                    Expanded(child: Divider()),
                  ],
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      child: ButtonBase(
                        onTap: () {},
                        text: "Google",
                        outlined: true,
                        prefixIcon: SvgPicture.asset(
                          "assets/icons/google.svg",
                          colorFilter: const ColorFilter.mode(
                              Colors.black, BlendMode.srcIn),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: ButtonBase(
                        onTap: () {},
                        text: "Facebook",
                        outlined: true,
                        prefixIcon: SvgPicture.asset(
                          "assets/icons/facebook.svg",
                          colorFilter: const ColorFilter.mode(
                              Colors.black, BlendMode.srcIn),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Ещё нет аккаунта?"),
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, "/register");
                      },
                      child: Text(
                        "Зарегистрироваться",
                        style: TextStyle(color: theme.primaryColor),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      )),
    );
  }
}
