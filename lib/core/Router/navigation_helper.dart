import 'package:flutter/material.dart';

import '../utils/Locator.dart';

class NavigationService {
  static GlobalKey<NavigatorState> get navigatorKey =>
      locator<GlobalKey<NavigatorState>>();

  static BuildContext get context => navigatorKey.currentContext!;

  static Future<T?> pushNamed<T>(String routeName, {Object? arguments}) {
    return navigatorKey.currentState!.pushNamed<T>(
      routeName,
      arguments: arguments,
    );
  }

  static Future<T?> pushReplacementNamed<T, TO>(
    String routeName, {
    Object? arguments,
  }) {
    return navigatorKey.currentState!.pushReplacementNamed<T, TO>(
      routeName,
      arguments: arguments,
    );
  }

  static Future<T?> pushNamedAndRemoveUntil<T>(
    String routeName, {
    Object? until,
    Object? arguments,
  }) {
    return navigatorKey.currentState!.pushNamedAndRemoveUntil<T>(
      routeName,
      (route) => until != null ? route.settings.name == until : false,
      arguments: arguments,
    );
  }

  static void pop<T>({T? result}) {
    return navigatorKey.currentState!.pop<T>(result);
  }
}
