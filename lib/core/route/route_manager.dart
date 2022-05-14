import 'package:flutter/material.dart';
import 'package:woo_study_case/core/exports.dart';

class RouteManager {
  String _currentRoute = '/';

  static RouteManager? _instance;
  static RouteManager get instance => _instance ??= RouteManager();

  String get currentRoute => _currentRoute;
  void setCurrentRoute(String routeName) {
    var formattedName = '/${routeName[0].toLowerCase()}${routeName.substring(1)}';
    _currentRoute = formattedName;
  }

  void pushReplacementNamed(String route) {
    navigatorKey.currentState?.pushReplacementNamed(route);
  }

  void pushNamed(String routeName) {
    navigatorKey.currentState?.pushNamed(routeName);
  }

  void pop() {
    navigatorKey.currentState?.pop();
  }

  void popUntil({String? routeName}) {
    /// if RouteSettings is not defined in route_manager
    /// and routeName is not null to use popuntil
    /// RouteSettings should be defined
    if (routeName != null) {
      navigatorKey.currentState?.popUntil(ModalRoute.withName(routeName));
    } else {
      navigatorKey.currentState?.popUntil((route) => route.isFirst);
    }
  }

  void pushNamedWithArguments(String routeName, Object arguments) {
    navigatorKey.currentState?.pushNamed(routeName, arguments: arguments);
  }

  void pushNamedReplacementWithArguments(String routeName, Object arguments) {
    navigatorKey.currentState?.pushReplacementNamed(routeName, arguments: arguments);
  }
}
