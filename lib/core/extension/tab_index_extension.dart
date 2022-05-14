import 'package:woo_study_case/domain/home/table_view_model.dart';

extension TabIndexExtension on int {
  TabFilter get name {
    switch (this) {
      case 0:
        return TabFilter.ALL;
      case 1:
        return TabFilter.SPOT;
      case 2:
        return TabFilter.FUTURES;
      default:
        return TabFilter.ALL;
    }
  }
}
