import 'package:dushka_burger/core/services/logger_service.dart';
import 'package:flutter/material.dart';

class MyRouteObserver extends NavigatorObserver {
  static Route<dynamic>? currentRoute;

  void _sendScreenView(PageRoute<dynamic> route) {
    final screenName = route.settings.name;
    LoggerService.logInfo('Current route: $screenName');
  }

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    if (route is PageRoute) {
      currentRoute = route;
      _sendScreenView(route);
    }
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    if (newRoute is PageRoute) {
      currentRoute = newRoute;
      _sendScreenView(newRoute);
    }
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    if (previousRoute is PageRoute && route is PageRoute) {
      currentRoute = previousRoute;
      _sendScreenView(previousRoute);
    }
  }
}
