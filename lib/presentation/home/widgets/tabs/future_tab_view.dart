import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:woo_study_case/domain/home/table_view_model.dart';
import 'package:woo_study_case/presentation/home/widgets/sortable_table.dart';

class FutureTabView extends ConsumerStatefulWidget {
  const FutureTabView({Key? key}) : super(key: key);

  @override
  FutureTabViewState createState() => FutureTabViewState();
}

class FutureTabViewState extends ConsumerState<FutureTabView> with AutomaticKeepAliveClientMixin<FutureTabView> {
  @override
  Widget build(BuildContext context) {
    return const SortableTable(filter: TabFilter.FUTURES);
  }

  @override
  bool get wantKeepAlive => true;
}
