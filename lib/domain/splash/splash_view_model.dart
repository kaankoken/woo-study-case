import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:woo_study_case/core/constants/app_routes.dart';
import 'package:woo_study_case/core/route/route_manager.dart';
import 'package:woo_study_case/infra/modules/view_model_module.dart';

class SplashViewModel {
  SplashViewModel(Ref ref) {
    // To initialize homeViewModel
    final _ = ref.read(homeViewModel);

    // Fake loading
    Future.delayed(const Duration(seconds: 2), () => navigateToHome);
  }

  void get navigateToHome => RouteManager.instance.pushReplacementNamed(AppRoutes.HOME);
}
