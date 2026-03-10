import 'package:flutter/material.dart';
import '../utils/locator.dart';

class NavigationService {
  /// The main navigator key used throughout the app.
  static GlobalKey<NavigatorState> get navigatorKey =>
      locator<GlobalKey<NavigatorState>>();

  /// Shortcut to the current [BuildContext] from [navigatorKey].
  static BuildContext get context => navigatorKey.currentContext!;

  /// Returns the effective [NavigatorState] based on the optional custom key.
  static NavigatorState? _getNavigator(GlobalKey<NavigatorState>? navKey) =>
      (navKey ?? navigatorKey).currentState;

  /// Pushes a named route onto the navigation stack.
  static Future<T?> push<T extends Object?>(
    Widget route, {
    Object? arguments,
    GlobalKey<NavigatorState>? navKey,
  }) async {
    return await _getNavigator(
      navKey,
    )?.push<T>(MaterialPageRoute(builder: (_) => route));
  }

  /// Pushes a named route onto the navigation stack.
  static Future<T?> pushNamed<T extends Object?>(
    String routeName, {
    Object? arguments,
    GlobalKey<NavigatorState>? navKey,
  }) async {
    return await _getNavigator(
      navKey,
    )?.pushNamed<T>(routeName, arguments: arguments);
  }

  /// Pops the current route if possible.
  static Future<bool> maybePop<T extends Object?>([T? result]) async {
    return await Navigator.maybePop(context, result);
  }

  /// Pops the current route with an optional result.
  static void pop<T extends Object?>({
    T? result,
    GlobalKey<NavigatorState>? navKey,
  }) {
    _getNavigator(navKey)?.pop<T>(result);
  }

  /// Pops the current route with an optional result.
  static bool canPop<T extends Object?>({
    T? result,
    GlobalKey<NavigatorState>? navKey,
  }) {
    return _getNavigator(navKey)?.canPop() ?? false;
  }

  /// Pushes a replacement route.
  static Future<T?> pushReplacementNamed<T extends Object?, TO extends Object?>(
    String routeName, {
    Object? arguments,
    GlobalKey<NavigatorState>? navKey,
  }) async {
    return await _getNavigator(
      navKey,
    )?.pushReplacementNamed<T, TO>(routeName, arguments: arguments);
  }

  /// Pushes a named route and removes routes until the condition is met.
  static Future<T?> pushNamedAndRemoveUntil<T extends Object?>(
    String routeName, {
    String? until,
    Object? arguments,
    GlobalKey<NavigatorState>? navKey,
  }) async {
    return await _getNavigator(navKey)?.pushNamedAndRemoveUntil<T>(
      routeName,
      (route) => until != null ? route.settings.name == until : false,
      arguments: arguments,
    );
  }

  /// Pops routes until a specific route is reached.
  static void popUntil(String routeName, {GlobalKey<NavigatorState>? navKey}) {
    _getNavigator(
      navKey,
    )?.popUntil((route) => route.settings.name == routeName);
  }
}
