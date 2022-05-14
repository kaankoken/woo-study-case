import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:woo_study_case/domain/home/table_view_model.dart';
import 'package:woo_study_case/presentation/home/widgets/sortable_table.dart';

class AllTabView extends ConsumerStatefulWidget {
  const AllTabView({Key? key}) : super(key: key);

  @override
  AllTabViewState createState() => AllTabViewState();
}

class AllTabViewState extends ConsumerState<AllTabView> with AutomaticKeepAliveClientMixin<AllTabView> {
  @override
  Widget build(BuildContext context) {
    return const SortableTable(filter: TabFilter.ALL);
  }

  @override
  bool get wantKeepAlive => true;
}
