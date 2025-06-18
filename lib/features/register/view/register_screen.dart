import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vasd/bloc/auth/auth_bloc.dart';
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
  bool emailError = false;

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
        } else if (state is AuthSignedUpState) {
          showDialog(
            context: context,
            builder: (context) => SuccessDialog(
              title: "Регистрация",
              text: "На ваш эл. адрес было отправлено письмо с ссылкой для подтверждения аккаунта",
              buttonText: "Хорошо",
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).pushReplacementNamed("/login");
              },
            ),
          );
        } else if (state.error != null) {
          String errorText = state.error.toString();

          if (errorText.contains("email") && errorText.contains("invalid format")) {
            errorText = "Неверно введён адрес эл. почты";
            setState(() => emailError = true);
          }

          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(errorText),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 2),
          ));
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
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 32),
                  SvgPicture.asset("assets/images/CDfEK_logo.svg"),
                  const SizedBox(height: 60),
                  Text("Создайте свой новый аккаунт!", style: theme.textTheme.headlineMedium),
                  const SizedBox(height: 12),
                  Text("Введите ваши данные ниже", style: TextStyle(color: theme.hintColor)),
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
                    onChanged: (_) => setState(() {
                      if (emailError) emailError = false;
                    }),
                    error: emailError,
                  ),
                  const SizedBox(height: 16),
                  IntlPhoneFieldCustom(
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
                    error: !checkPasswordLength(passwordController.text),
                  ),
                  const SizedBox(height: 16),
                  TextFieldCustom(
                    hintText: "Подтверждение пароля",
                    controller: passwordConfirmController,
                    password: true,
                    onChanged: (_) {
                      setState(() {});
                    },
                    error: !checkPasswordLength(passwordConfirmController.text),
                  ),
                  const SizedBox(height: 24),
                  ButtonBase(
                    text: "Зарегистрироваться",
                    onTap: (checkTextFieldsNotEmpty() && checkPassword())
                        ? () async {
                            authBloc.add(
                              AuthSignUpEvent(
                                email: emailController.text,
                                password: passwordController.text,
                                name: usernameController.text,
                                phone: phoneController.text,
                              ),
                            );
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
      ),
    );
  }

  bool checkTextFieldsNotEmpty() =>
      usernameController.text.isNotEmpty &&
      emailController.text.isNotEmpty &&
      phoneController.text.isNotEmpty &&
      passwordController.text.isNotEmpty &&
      passwordConfirmController.text.isNotEmpty;

  bool checkPassword() => passwordController.text == passwordConfirmController.text;

  bool checkPasswordLength(String password) => password.length >= 6;
}
