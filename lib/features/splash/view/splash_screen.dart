import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as supabase;
import 'package:vasd/bloc/auth/auth_bloc.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    checkSavedLogin();
    super.initState();
  }

  void checkSavedLogin() async {
    final authBloc = context.read<AuthBloc>();
    final supabase.Session? session =
        GetIt.I<supabase.SupabaseClient>().auth.currentSession;

    await Future.delayed(const Duration(seconds: 5));

    // if (false) { // Остановка для удобной вёрстки
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
