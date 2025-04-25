import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:static_map/static_map.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:talker_bloc_logger/talker_bloc_logger.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:vasd/repositories/address_completer/address_completer.dart';
import 'package:vasd/repositories/auth/auth.dart';
import 'package:vasd/repositories/delivery/delivery_supabase_repo.dart';
import 'package:vasd/repositories/delivery_variant/delivery_variant_local_repo.dart';
import 'package:vasd/repositories/payment_method/payment_method_local_repo.dart';
import 'package:vasd/repositories/point/point.dart';
import 'package:vasd/vasd_app.dart';

// Supabase Database Password = 5re6evIdBibM3HJq

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
      url: "https://qprxzwerdumhcourygam.supabase.co",
      anonKey:
          "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InFwcnh6d2VyZHVtaGNvdXJ5Z2FtIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzA4Nzc4OTksImV4cCI6MjA0NjQ1Mzg5OX0.2hmdN4gUgyX9JOKuOiL6Cf0LNdOHAn2OfKRhmtrJC10");

  await Hive.initFlutter();

  StaticMap.initialize(apiKey: 'pk_6992c2a5e5dd459ebf4b4851105c3a8c');

  final dio = Dio();
  final talker = Talker();

  GetIt.I.registerSingleton(dio);
  GetIt.I.registerSingleton(talker);
  GetIt.I.registerSingleton(Supabase.instance.client);
  GetIt.I.registerSingleton<AuthInterface>(
      AuthSupabaseRepo(Supabase.instance.client));
  GetIt.I.registerSingleton<AddressCompleterInterface>(
      AddressCompleterDadataRepo());
  GetIt.I.registerSingleton(const DeliveryVariantLocalRepo());
  GetIt.I.registerSingleton(const PaymentMethodLocalRepo());
  GetIt.I.registerSingleton(
      DeliverySupabaseRepo(supabaseClient: Supabase.instance.client));
  GetIt.I.registerSingleton(
      PointSupabaseRepo(supabaseClient: Supabase.instance.client));

  Bloc.observer = TalkerBlocObserver(
      talker: talker,
      settings: const TalkerBlocLoggerSettings(
          printStateFullData: true, printEventFullData: true));

  runApp(const VASDApp());
}
