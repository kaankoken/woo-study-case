import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:woo_study_case/domain/home/home_view_model.dart';
import 'package:woo_study_case/domain/home/table_view_model.dart';
import 'package:woo_study_case/domain/splash/splash_view_model.dart';

Future<void> viewModelModule() async {
  homeViewModel = Provider((ref) => HomeViewModel(ref));
  splashViewModel = Provider.autoDispose((ref) => SplashViewModel(ref));
  tableViewModel = Provider.family((ref, filter) => TableViewModel(ref, filter));
}

late Provider<HomeViewModel> homeViewModel;
late AutoDisposeProvider<SplashViewModel> splashViewModel;
late ProviderFamily<TableViewModel, TabFilter> tableViewModel;
