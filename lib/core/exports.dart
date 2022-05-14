import 'package:flutter/material.dart';
import 'package:woo_study_case/core/constants/app_strings.dart';
import 'package:woo_study_case/core/route/route_manager.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<ScaffoldMessengerState> scaffoldKey = GlobalKey<ScaffoldMessengerState>();

final RouteManager routeManager = RouteManager.instance;

late AppStrings appStrings;
