import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:woo_study_case/core/exports.dart';
import 'package:woo_study_case/domain/home/table_view_model.dart';
import 'package:woo_study_case/domain/models/coin.dart';
import 'package:woo_study_case/infra/modules/view_model_module.dart';
import 'package:woo_study_case/presentation/home/widgets/scrollable_widget.dart';

class SortableTable extends ConsumerStatefulWidget {
  final TabFilter filter;
  const SortableTable({Key? key, required this.filter}) : super(key: key);

  @override
  SortablePageState createState() => SortablePageState();
}

class SortablePageState extends ConsumerState<SortableTable> {
  late TableViewModel _viewModel;
  @override
  void initState() {
    super.initState();
    _viewModel = ref.read(tableViewModel(widget.filter));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScrollableWidget(child: buildDataTable()),
    );
  }

  Widget buildDataTable() {
    final columns = [appStrings.symbol, appStrings.lastPrice, appStrings.volume];

    return ref.watch(isListLoaded(widget.filter))
        ? ref.watch(filteredList(widget.filter)).isEmpty
            ? Center(child: Text(appStrings.noData))
            : DataTable(
                sortAscending: ref.watch(isAscending),
                sortColumnIndex: ref.watch(sortColumnIndex),
                columns: getColumns(columns),
                rows: getRows(ref.watch(filteredList(widget.filter))),
                headingRowColor: MaterialStateProperty.resolveWith(
                  (states) => states.contains(MaterialState.pressed) ? Colors.red : null,
                ),
              )
        : const Align(
            alignment: Alignment.center,
            child: CircularProgressIndicator(color: Colors.red),
          );
  }

  List<DataColumn> getColumns(List<String> columns) => columns
      .map(
        (String column) => DataColumn(
          label: Text(column),
          onSort: _viewModel.onSort,
        ),
      )
      .toList();

  List<DataRow> getRows(List<Coin> users) => users.map(
        (Coin user) {
          final cells = [user.symbol, user.lastPriceDisplay, user.volumeDisplay];

          return DataRow(cells: getCells(cells));
        },
      ).toList();

  List<DataCell> getCells(List<dynamic> cells) => cells.map((data) => DataCell(Text('$data'))).toList();
}
