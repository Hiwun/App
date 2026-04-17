import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:tennisapp/di/locator.dart';
import 'package:tennisapp/features/auth/auth.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:yandex_maps_mapkit_lite/init.dart' as init;
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

Future<void> main() async {
  tz.initializeTimeZones();
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('ru_RU', null);
  Intl.defaultLocale = 'ru_RU';

  await init.initMapkit(
      apiKey: 'd1a94d50-ebc0-4b7f-b1c1-f3c556c0ca82'
  );

  await setupLocator();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {


    return MaterialApp(
      locale: Locale('ru', 'RU'),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', 'US'),
        Locale('ru', 'RU'),
      ],
      title: 'Ресторатор',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: AppBarTheme(
          centerTitle: true,
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          iconTheme: IconThemeData(
            color: CupertinoColors.activeBlue,
            size: 20
          ),
          titleTextStyle: TextStyle(fontSize: 16, color: Colors.black),
          //surfaceTintColor: Colors.white
        ),

      ),
      home: BlocProvider(
       create: (_) => getIt<AuthBloc>(),
       child: AuthGate(
         child: IntermediateAuthGate(),
       ),
      )
    );
  }
}