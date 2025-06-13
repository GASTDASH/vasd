import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as supabase;
import 'package:talker_flutter/talker_flutter.dart';
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

          GetIt.I<Talker>().debug((state.error as supabase.AuthException).code);
          if (state.error is supabase.AuthException) {
            if ((state.error as supabase.AuthException).code == "invalid_credentials") {
              errorText = "Неправильный логин или пароль";
            } else if (state.error.toString().contains("host")) {
              errorText = "Невозможно подключиться к серверу. Проверьте подключение к интернету";
            } else if ((state.error as supabase.AuthException).code == "otp_expired") {
              errorText = "Неправильный код или код просрочен";
            } else if ((state.error as supabase.AuthException).code == "otp_disabled") {
              errorText = "Введённый адрес эл. почты неверен или не зарегистрирован";
            } else if ((state.error as supabase.AuthException).code == "over_email_send_rate_limit") {
              var list = state.error.toString().split(' ');
              var index = list.indexWhere(
                (str) => str.contains("seconds"),
              );
              var seconds = list[index - 1];

              errorText = "В целях безопасности, вы сможете запросить код только через $seconds секунд";
            } else {
              errorText = state.error.toString();
            }
          }

          ScaffoldMessenger.of(context).hideCurrentSnackBar();
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
                Text("Давайте войдем в систему!", style: theme.textTheme.headlineMedium),
                const SizedBox(height: 12),
                Text("Введите ваши данные ниже", style: TextStyle(color: theme.hintColor)),
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
                    child: Text("Забыли пароль?", style: TextStyle(color: theme.primaryColor)),
                  ),
                ),
                const SizedBox(height: 24),
                ButtonBase(
                  text: "Войти",
                  onTap: (emailController.text.isNotEmpty && passwordController.text.isNotEmpty)
                      ? () async {
                          authBloc.add(
                            AuthLoginEvent(email: emailController.text, password: passwordController.text),
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
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) => BaseDialog(
                                icon: const Icon(
                                  Icons.info_outline,
                                  color: Colors.white,
                                ),
                                color: theme.primaryColor,
                                title: "Временно недоступно",
                                text: "Данная функция всё ещё находится в разработке. В скором времени мы её реализуем."),
                          );
                        },
                        text: "Google",
                        outlined: true,
                        prefixIcon: SvgPicture.asset(
                          "assets/icons/google.svg",
                          colorFilter: const ColorFilter.mode(Colors.black, BlendMode.srcIn),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: ButtonBase(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) => BaseDialog(
                                icon: const Icon(
                                  Icons.info_outline,
                                  color: Colors.white,
                                ),
                                color: theme.primaryColor,
                                title: "Временно недоступно",
                                text: "Данная функция всё ещё находится в разработке. В скором времени мы её реализуем."),
                          );
                        },
                        text: "ВКонтакте",
                        outlined: true,
                        prefixIcon: SvgPicture.asset(
                          "assets/icons/vk.svg",
                          height: 24,
                          colorFilter: const ColorFilter.mode(Colors.black, BlendMode.srcIn),
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
