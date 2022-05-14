import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:woo_study_case/infra/modules/view_model_module.dart';

class SplashView extends ConsumerWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _ = ref.watch(splashViewModel);

    return const Scaffold(
      body: Center(child: CircularProgressIndicator(color: Colors.red)),
    );
  }
}
