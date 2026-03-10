import 'dart:developer';
import 'package:flutter/material.dart';

class LoggingRouteObserver extends RouteObserver<PageRoute<dynamic>> {
  void _logRouteEvent(String eventType, PageRoute<dynamic> route) {
    final routeName = route.settings.name ?? 'Unknown';
    log("[$eventType], current route ==> $routeName", name: "Route Name");
  }

  @override
  void didPush(Route route, Route? previousRoute) {
    super.didPush(route, previousRoute);
    if (route is PageRoute) {
      _logRouteEvent("PUSH", route);
    }
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    super.didPop(route, previousRoute);
    if (previousRoute is PageRoute) {
      _logRouteEvent("POP", previousRoute);
    }
  }

  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    if (newRoute is PageRoute) {
      _logRouteEvent("REPLACE", newRoute);
    }
  }
}
