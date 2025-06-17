import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as supabase;
import 'package:talker_flutter/talker_flutter.dart';
import 'package:vasd/bloc/auth/auth_bloc.dart';
import 'package:vasd/ui/ui.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  int attempts = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => checkSavedLogin());
  }

  void checkSavedLogin() async {
    final authBloc = context.read<AuthBloc>();
    final supabase.Session? session = GetIt.I<supabase.SupabaseClient>().auth.currentSession;

    if (mounted) {
      if (session != null) {
        authBloc.add(AuthLoginSavedEvent());
      } else {
        Navigator.of(context).pushReplacementNamed("/login");
      }
    } else {
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthAuthorizedState) {
          Navigator.of(context).pushReplacementNamed("/home");
        } else if (state is AuthUnauthorizedState && state.error != null) {
          var errorText = state.error.toString();

          // TODO: Сделать автоматический повтор 3 раза
          if (attempts < 3) {
            attempts++;
            GetIt.I<Talker>().debug("Ошибка входа (${state.error})\nПовторная попытка $attempts/3");
            checkSavedLogin();
            return;
          }
          showDialog(
            context: context,
            builder: (context) => BaseDialog(
              icon: const Icon(
                Icons.error,
                color: Colors.white,
              ),
              color: Colors.red,
              title: errorText.contains("host") ? "Ошибка соединения" : "Произошла ошибка",
              text: errorText.contains("host")
                  ? "Невозможно подключиться к серверу. Проверьте соединение с интернетом или попробуйте позже"
                  : errorText,
              child: ButtonBase(
                text: "Повторить попытку",
                onTap: () {
                  Navigator.of(context).pop();
                  checkSavedLogin();
                },
              ),
            ),
          );
        }
      },
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(
                "assets/images/CDEK_logo.svg",
                height: 70,
              ),
              const SizedBox(height: 30),
              const SizedBox(
                height: 100,
                width: 100,
                child: LoadingIndicator(indicatorType: Indicator.ballPulse),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
