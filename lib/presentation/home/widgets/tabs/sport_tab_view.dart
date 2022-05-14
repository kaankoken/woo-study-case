import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:woo_study_case/domain/home/table_view_model.dart';
import 'package:woo_study_case/presentation/home/widgets/sortable_table.dart';

class SpotTabView extends ConsumerStatefulWidget {
  const SpotTabView({Key? key}) : super(key: key);

  @override
  SpotTabViewState createState() => SpotTabViewState();
}

class SpotTabViewState extends ConsumerState<SpotTabView> with AutomaticKeepAliveClientMixin<SpotTabView> {
  @override
  Widget build(BuildContext context) {
    return const SortableTable(filter: TabFilter.SPOT);
  }

  @override
  bool get wantKeepAlive => true;
}
