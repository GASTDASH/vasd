import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:talker_bloc_logger/talker_bloc_logger.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:vasd/repositories/auth/auth.dart';
import 'package:vasd/vasd_app.dart';

// Supabase Database Password = 5re6evIdBibM3HJq

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
      url: "https://qprxzwerdumhcourygam.supabase.co",
      anonKey:
          "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InFwcnh6d2VyZHVtaGNvdXJ5Z2FtIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzA4Nzc4OTksImV4cCI6MjA0NjQ1Mzg5OX0.2hmdN4gUgyX9JOKuOiL6Cf0LNdOHAn2OfKRhmtrJC10");

  final talker = Talker();

  GetIt.I.registerSingleton(talker);
  GetIt.I.registerSingleton(Supabase.instance.client);
  GetIt.I.registerSingleton<AuthInterface>(
      AuthSupabaseRepo(Supabase.instance.client));

  Bloc.observer = TalkerBlocObserver(
      talker: talker,
      settings: const TalkerBlocLoggerSettings(
          printStateFullData: true, printEventFullData: true));

  runApp(const VASDApp());
}
