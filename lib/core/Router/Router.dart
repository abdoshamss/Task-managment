import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../features/auth/presentation/screens/forget_password/forget_password_screen.dart';
import '../../features/auth/screens/login_screen.dart';
import '../../features/auth/screens/splash_screen.dart' as taskflow;
import '../../features/auth/presentation/screens/reset_password/reset_password_screen.dart';
import '../../features/auth/presentation/screens/sign_up/sign_up_screen.dart';
import '../../features/splash/presentation/screens/on_boarding/on_boarding_screen.dart';

class Routes {
  static const String splashScreen = "/splashScreen";
  static const String onboardingScreen = "/onboardingScreen";
  static const String loginScreen = "loginScreen";
  static const String registerScreen = "registerScreen";
  static const String forgetPassScreen = "/forgetPassScreen";
  static const String otpScreen = "/OtpScreen";
  static const String layoutScreen = "/LayoutScreen";
  static const String resetPasswordScreen = "/ResetPasswordScreen";

  static const String homeScreen = "homeScreen";
}

class RouteGenerator {
  static String currentRoute = "";

  static Route<dynamic> getRoute(RouteSettings routeSettings) {
    currentRoute = routeSettings.name.toString();
    switch (routeSettings.name) {
      case Routes.splashScreen:
        return CupertinoPageRoute(
          settings: routeSettings,
          builder: (_) {
            return const taskflow.SplashScreen();
          },
        );
      case Routes.onboardingScreen:
        return CupertinoPageRoute(
          settings: routeSettings,
          builder: (_) {
            return const OnboardingScreen();
          },
        );
      case Routes.loginScreen:
        return CupertinoPageRoute(
          settings: routeSettings,
          builder: (_) {
            return const LoginScreen();
          },
        );
      case Routes.resetPasswordScreen:
        return CupertinoPageRoute(
          settings: routeSettings,
          builder: (_) {
            return ResetPasswordScreen(
              code: (routeSettings.arguments as NewPasswordArgs).code,
              email: (routeSettings.arguments as NewPasswordArgs).email,
            );
          },
        );
      // case Routes.otpScreen:
      //   return CupertinoPageRoute(
      //     settings: routeSettings,
      //     builder: (_) {
      //       return OtpScreen(
      //         onReSend: (routeSettings.arguments as OtpArguments).onReSend,
      //         onSubmit: (routeSettings.arguments as OtpArguments).onSubmit,
      //         sendTo: (routeSettings.arguments as OtpArguments).sendTo,
      //         init: (routeSettings.arguments as OtpArguments).init,
      //       );
      //     },
      //   );
      case Routes.forgetPassScreen:
        return CupertinoPageRoute(
          settings: routeSettings,
          builder: (_) {
            return const ForgetPasswordScreen();
          },
        );
      case Routes.registerScreen:
        return CupertinoPageRoute(
          settings: routeSettings,
          builder: (_) {
            return const SignUpScreen();
          },
        );
      // case Routes.SplashScreen:
      //   return CupertinoPageRoute(
      //       settings: routeSettings,
      //       builder: (_) {
      //         return const SplashScreen();
      //       });

      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> getNestedRoute(RouteSettings routeSettings) {
    currentRoute = routeSettings.name.toString();
    switch (routeSettings.name) {
      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return CupertinoPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(title: const Text("مسار غير موجود")),
        body: const Center(child: Text("مسار غير موجود")),
      ),
    );
  }
}

class OtpArguments {
  final String sendTo;
  final bool? init;
  final dynamic Function(String) onSubmit;
  final void Function() onReSend;

  OtpArguments({
    required this.sendTo,
    required this.onSubmit,
    required this.onReSend,
    this.init,
  });
}

class NewPasswordArgs {
  final String code;
  final String email;
  const NewPasswordArgs({required this.code, required this.email});
}
