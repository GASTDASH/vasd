import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:static_map/static_map.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:talker_bloc_logger/talker_bloc_logger.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:vasd/repositories/address_completer/address_completer.dart';
import 'package:vasd/repositories/auth/auth.dart';
import 'package:vasd/repositories/delivery/delivery.dart';
import 'package:vasd/repositories/delivery_variant/delivery_variant_local_repo.dart';
import 'package:vasd/repositories/delivery_variant/models/delivery_variant.dart';
import 'package:vasd/repositories/notification/notification.dart';
import 'package:vasd/repositories/package_size/models/package_size.dart';
import 'package:vasd/repositories/payment_method/payment_method_local_repo.dart';
import 'package:vasd/repositories/point/point.dart';
import 'package:vasd/repositories/status/models/models.dart';
import 'package:vasd/repositories/tracking/tracking.dart';
import 'package:vasd/vasd_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await loadDotEnv();
  await initSupabase();
  await initHive();
  initStaticMap();

  final dio = Dio();
  final talker = Talker();
  Bloc.observer =
      TalkerBlocObserver(talker: talker, settings: const TalkerBlocLoggerSettings(printStateFullData: true, printEventFullData: true));

  GetIt.I.registerSingleton(dio);
  GetIt.I.registerSingleton(talker);
  GetIt.I.registerSingleton(Supabase.instance.client);
  GetIt.I.registerSingleton<AuthInterface>(AuthSupabaseRepo(Supabase.instance.client));
  GetIt.I.registerSingleton<AddressCompleterInterface>(AddressCompleterDadataRepo());
  GetIt.I.registerSingleton(const DeliveryVariantLocalRepo());
  GetIt.I.registerSingleton(const PaymentMethodLocalRepo());
  GetIt.I.registerSingleton<DeliverySupabaseRepo>(DeliverySupabaseRepo(supabaseClient: Supabase.instance.client));
  GetIt.I.registerSingleton<DeliveryLocalRepo>(DeliveryLocalRepo());
  GetIt.I.registerSingleton(PointSupabaseRepo(supabaseClient: Supabase.instance.client));
  GetIt.I.registerSingleton(NotificationSupabaseRepo(supabaseClient: Supabase.instance.client));

  runApp(const VASDApp());
}

void initStaticMap() {
  StaticMap.initialize(apiKey: dotenv.env['STATIC_MAP_API_KEY'].toString());
}

Future<void> initSupabase() async {
  await Supabase.initialize(url: dotenv.env['SUPABASE_URL'].toString(), anonKey: dotenv.env['SUPABASE_ANON_KEY'].toString());
}

Future<void> initHive() async {
  await Hive.initFlutter();
  Hive.registerAdapter(DeliveryAdapter());
  Hive.registerAdapter(DeliveryVariantAdapter());
  Hive.registerAdapter(PackageSizeAdapter());
  Hive.registerAdapter(PointAdapter());
  Hive.registerAdapter(StatusAdapter());
  Hive.registerAdapter(TrackingAdapter());
  await Hive.openBox<Delivery>('delivery');
}

Future<void> loadDotEnv() async {
  try {
    await dotenv.load(fileName: ".env"); // Load environment variables
  } catch (e) {
    throw Exception('Error loading .env file: $e'); // Print error if any
  }
}
