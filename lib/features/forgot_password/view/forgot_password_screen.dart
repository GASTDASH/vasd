import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vasd/bloc/auth/auth_bloc.dart';
import 'package:vasd/features/forgot_password/forgot_password.dart';
import 'package:vasd/ui/ui.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  int selectedMethodIndex = 0;
  final emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final authBloc = context.read<AuthBloc>();

    return BlocListener<AuthBloc, AuthState>(
      bloc: authBloc,
      listener: (context, state) {
        // if (state is AuthLoadingState) {
        //   showDialog(
        //     barrierDismissible: false,
        //     context: context,
        //     builder: (context) => const LoadingDialog(),
        //   );
        // } else
        if (state is AuthOtpVerificationState) {
          Navigator.pushNamed(
            context,
            "/otp_verification",
            arguments: emailController.text,
          );
        }
        // else if (state is AuthUnauthorizedState && state.error != null) {
        //   GetIt.I<Talker>().error(state.error.toString());
        // }
      },
      listenWhen: (previous, current) {
        if (previous is AuthLoadingState) {
          Navigator.of(context).pop();
        }
        return true;
      },
      child: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.chevron_left_rounded, size: 40),
            ),
          ),
          bottomNavigationBar: Container(
            padding: const EdgeInsets.all(18),
            child: ButtonBase(
              onTap: emailController.text.isEmpty
                  ? null
                  : () => authBloc
                      .add(AuthSignInWithOtp(email: emailController.text)),
              text: "Продолжить",
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Забыли пароль", style: theme.textTheme.headlineMedium),
                const SizedBox(height: 12),
                Text("Выберите, каким способом вы хотите восстановить пароль",
                    style: TextStyle(color: theme.hintColor)),
                const SizedBox(height: 24),
                SendOTPMethodButton(
                  selected: selectedMethodIndex == 0,
                  onTap: () {
                    setState(() {
                      selectedMethodIndex = 0;
                    });
                  },
                  title: "Код через СМС",
                  subtitle: "Введите номер телефона",
                  icon: Icons.message_outlined,
                ),
                const SizedBox(height: 12),
                SendOTPMethodButton(
                  selected: selectedMethodIndex == 1,
                  onTap: () {
                    setState(() {
                      selectedMethodIndex = 1;
                    });
                  },
                  title: "Код через эл. почту",
                  subtitle: "Введите адрес эл. почты",
                  icon: Icons.mail_outline,
                ),
                const SizedBox(height: 24),
                TextFieldCustom(
                  hintText: "Эл. почта",
                  controller: emailController,
                  onChanged: (_) => setState(() {}),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
