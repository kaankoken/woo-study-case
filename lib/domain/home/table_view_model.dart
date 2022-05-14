// ignore_for_file: constant_identifier_names

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:woo_study_case/core/constants/app_assets.dart';
import 'package:woo_study_case/core/extension/coin_data_extension.dart';
import 'package:woo_study_case/domain/models/coin.dart';

StateProvider<bool> isAscending = StateProvider((_) => true);
StateProviderFamily<bool, TabFilter> isListLoaded = StateProvider.family((_, filter) => false);
StateProvider<int?> sortColumnIndex = StateProvider((_) => null);
StateProviderFamily<int, int> tabCount = StateProvider.family((index, count) => count);
StateProviderFamily<List<Coin>, TabFilter> filteredList = StateProviderFamily((_, filter) => <Coin>[]);

enum TabFilter { ALL, SPOT, FUTURES }

class TableViewModel {
  late List<Coin> list;
  final TabFilter _filter;
  final Ref _ref;

  TableViewModel(this._ref, this._filter) {
    init();
  }

  void onSort(int _columnIndex, bool _isAscending) {
    final count = ++_ref.read(tabCount(_columnIndex).state).state;
    if (count % 3 == 0) {
      defaultSort();
    } else {
      resetColumnStatus(_columnIndex);
      switch (_columnIndex) {
        case 0:
          list.sort(
            (coin1, coin2) => compareString(
              _isAscending,
              '${coin1.base}${coin1.quote}${coin1.type}',
              '${coin2.base}${coin2.quote}${coin2.type}',
            ),
          );
          break;
        case 1:
          list.sort((coin1, coin2) => compareDouble(_isAscending, coin1.lastPrice, coin2.lastPrice));
          break;
        case 2:
          list.sort((coin1, coin2) => compareDouble(_isAscending, coin1.volume, coin2.volume));
          break;
        default:
          list.sort(
            (coin1, coin2) => compareString(
              _isAscending,
              '${coin1.base}${coin1.quote}${coin1.type}',
              '${coin2.base}${coin2.quote}${coin2.type}',
            ),
          );
          break;
      }
      _ref.read(isAscending.notifier).update((_) => _isAscending);
      _ref.read(sortColumnIndex.notifier).update((_) => _columnIndex);
    }
  }

  void init() async {
    final _list = await AppAssets.DATA_PATH.readJsonData(_filter);
    list = _list.toCoinList();
    _filter.name == TabFilter.ALL.name
        ? list.sort(
            (coin1, coin2) => compareString(
              true,
              '${coin1.priority}${coin1.symbol}',
              '${coin2.priority}${coin2.symbol}',
            ),
          )
        : list.sort(
            (coin1, coin2) => compareString(
              false,
              '${coin2.priority}${coin2.volume}',
              '${coin1.priority}${coin1.volume}',
            ),
          );

    _ref.read(filteredList(_filter).notifier).update((_) => list);
    _ref.read(isListLoaded(_filter).notifier).update((_) => true);
  }

  void defaultSort() {
    _filter.name == TabFilter.ALL.name
        ? list.sort(
            (coin1, coin2) => compareString(
              true,
              '${coin1.priority}${coin1.symbol}',
              '${coin2.priority}${coin2.symbol}',
            ),
          )
        : list.sort(
            (coin1, coin2) => compareString(
              false,
              '${coin2.priority}${coin2.volume}',
              '${coin1.priority}${coin1.volume}',
            ),
          );

    _ref.read(sortColumnIndex.notifier).update((_) => null);
    _ref.read(isAscending.notifier).update((_) => _filter.name == TabFilter.ALL.name);
  }

  void resetColumnStatus(int currentColumn) {
    final previousColumn = _ref.read(sortColumnIndex) ?? 0;
    if (currentColumn != previousColumn) {
      _ref.read(tabCount(previousColumn).notifier).update((state) => 0);
    }
  }

  int compareString(bool ascending, String value1, String value2) =>
      ascending ? value1.compareTo(value2) : value2.compareTo(value1);

  int compareDouble(bool ascending, double value1, double value2) =>
      ascending ? value1.compareTo(value2) : value2.compareTo(value1);

  int comparePriority(bool ascending, int value1, int value2) =>
      ascending ? value1.compareTo(value2) : value2.compareTo(value1);

  void searchOnList(String text) {
    if (text.isEmpty) {
      _ref.read(filteredList(_filter).notifier).update((_) => list);
    } else {
      _ref
          .read(filteredList(_filter).notifier)
          .update((_) => list.where((element) => element.base.toLowerCase().contains(text)).toList());
    }
  }
}
