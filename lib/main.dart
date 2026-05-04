import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/data_source/hive_service.dart';
import 'core/general/general_cubit.dart';
import 'core/localization/generated/app_localizations.dart';
import 'core/localization/localization_helper.dart';
import 'core/utils/general_constants.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'features/auth/cubit/firebase_auth_cubit.dart';
import 'features/tasks/cubit/task_cubit.dart';
import 'features/splash/presentation/screens/splash/splash.dart';

GlobalKey<NavigatorState>? navigatorKeyy = GlobalKey<NavigatorState>();
//abdoshams2005@gmail.com
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await HiveService.init([GeneralConstants.appBoxName]);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => FirebaseAuthCubit()),
        BlocProvider(create: (_) => TaskCubit()),
        BlocProvider(create: (_) => GeneralCubit()),
      ],
      child: BlocConsumer<GeneralCubit, GeneralState>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            title: 'Task Flow',
            navigatorKey: navigatorKeyy,

            debugShowCheckedModeBanner: false,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            locale: LocalizationHelper.currentLocale,
            localeResolutionCallback: (locale, supportedLocales) {
              for (var supportedLocale in supportedLocales) {
                if (supportedLocale.languageCode == locale?.languageCode &&
                    supportedLocale.countryCode == locale?.countryCode) {
                  return supportedLocale;
                }
              }
              return supportedLocales.first;
            },

            supportedLocales: AppLocalizations.supportedLocales,

            home: const SplashScreen(),
          );
        },
      ),
    );
  }
}
