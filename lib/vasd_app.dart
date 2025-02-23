import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:vasd/bloc/auth/auth_bloc.dart';
import 'package:vasd/bloc/delivery/delivery_bloc.dart';
import 'package:vasd/repositories/auth/auth.dart';
import 'package:vasd/repositories/delivery/delivery_supabase_repo.dart';
import 'package:vasd/routes/routes.dart';
import 'package:vasd/ui/ui.dart';

class VASDApp extends StatelessWidget {
  const VASDApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthBloc(authRepo: GetIt.I<AuthInterface>()),
        ),
        BlocProvider(
          create: (context) => DeliveryBloc(
            authRepo: GetIt.I<AuthInterface>(),
            deliveryRepo: GetIt.I<DeliverySupabaseRepo>(),
          ),
        ),
      ],
      child: MaterialApp(
        title: 'VASD',
        theme: lightTheme,
        routes: routes,
        initialRoute: "/splash",
      ),
    );
  }
}
