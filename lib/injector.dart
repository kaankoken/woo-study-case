import 'package:woo_study_case/infra/modules/view_model_module.dart';

Future<void> setupInjector() async {
  await Future.wait(
    [viewModelModule()],
    eagerError: true,
  );
}
