import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:woo_study_case/core/constants/app_routes.dart';
import 'package:woo_study_case/presentation/home/home_view.dart';
import 'package:woo_study_case/presentation/splash/splash_view.dart';

class Routes {
  static onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.SPLASH:
        return Platform.isIOS
            ? CupertinoPageRoute(
                builder: (_) => const SplashView(),
                fullscreenDialog: true,
              )
            : MaterialPageRoute(
                builder: (_) => const SplashView(),
                fullscreenDialog: true,
              );
      case AppRoutes.HOME:
        return Platform.isIOS
            ? CupertinoPageRoute(
                builder: (_) => const HomeView(),
                fullscreenDialog: true,
              )
            : MaterialPageRoute(
                builder: (_) => const HomeView(),
                fullscreenDialog: true,
              );
    }
  }
}
