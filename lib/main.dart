import 'dart:async';
import 'dart:developer';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'core/data_source/hive_service.dart';
import 'core/general/general_cubit.dart';
import 'core/localization/generated/app_localizations.dart';
import 'core/localization/localization_helper.dart';
import 'core/style/app_theme.dart';
import 'core/utils/general_constants.dart';
import 'core/utils/utils.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'features/auth/cubit/firebase_auth_cubit.dart';
import 'features/tasks/cubit/task_cubit.dart';
import 'features/splash/presentation/screens/splash/splash.dart';

GlobalKey<NavigatorState>? navigatorKeyy = GlobalKey<NavigatorState>();
Future<void> main() async {
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    // أولاً: ابدأ HiveService ومرر اسم البوكس المطلوب
    await HiveService.init([GeneralConstants.appBoxName]);

    // بعد كده سجل بقية الخدمات
    // await setupLocator();

    // bloc observer
    Bloc.observer = MyBlocObserver();

    // بعد التأكد إن البوكس مفتوح
    await Utils.initTheme();

    runApp(const MyApp());
  }, (error, stackTrace) => log(error.toString(), stackTrace: stackTrace));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => FirebaseAuthCubit()),
          BlocProvider(create: (_) => TaskCubit()),
          BlocProvider(create: (_) => GeneralCubit()),
        ],
        child: BlocConsumer<GeneralCubit, GeneralState>(
          listener: (context, state) {
            // TODO: implement listener
          },
          // listenWhen: (previous, current)=>cubit. ,
          builder: (context, state) {
            final cubit = GeneralCubit.get(context);
            return MaterialApp(
              title: 'Task Flow',
              themeAnimationDuration: const Duration(milliseconds: 700),
              themeAnimationCurve: Curves.easeInOutCubic,
              debugShowCheckedModeBanner: false,
              localizationsDelegates: [
                ...AppLocalizations.localizationsDelegates,
                LocalizationHelper.delegate,
              ],
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
              navigatorKey: navigatorKeyy,

              supportedLocales: AppLocalizations.supportedLocales,
              builder: (_, child) {
                final botToastBuilder = BotToastInit();
                final smartDialog = FlutterSmartDialog.init();
                child = smartDialog(context, child);
                child = botToastBuilder(context, child);
                SystemChrome.setSystemUIOverlayStyle(
                  AppThemes().theme.name == 'light'
                      ? SystemUiOverlayStyle.dark
                      : SystemUiOverlayStyle.light,
                );
                return child;
              },
              // onGenerateRoute: RouteGenerator.getRoute,
              // themeMode: cubit.isLightMode ? ThemeMode.light : ThemeMode.dark,
              // theme: cubit.isLightMode ? LightTheme.getTheme() : DarkTheme.getTheme(),
              // themeMode: ThemeMode.system,
              // theme: LightTheme.getTheme(),
              // darkTheme: DarkTheme.getTheme(),
              theme: AppThemes().theme.appTheme,
              home: const SplashScreen(),
            );
          },
        ),
      ),
    );
  }
}

class MyBlocObserver extends BlocObserver {
  static final _logger = debugPrint;

  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    if (kDebugMode) _logger('onCreate -- ${bloc.runtimeType}');
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    if (kDebugMode) _logger('onChange -- ${bloc.runtimeType} -- $change');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    _logger('onError -- ${bloc.runtimeType} -- $error');
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onClose(BlocBase bloc) {
    if (kDebugMode) _logger('onClose -- ${bloc.runtimeType}');
    super.onClose(bloc);
  }
}
