import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:woo_study_case/core/exports.dart';
import 'package:woo_study_case/core/extension/tab_index_extension.dart';
import 'package:woo_study_case/infra/modules/view_model_module.dart';

StateProvider<IconData> searchIcon = StateProvider((_) => Icons.search);
StateProvider<Widget> searchTitle = StateProvider((ref) => Text(appStrings.search));
StateProvider<String> searchText = StateProvider((ref) => '');

class HomeViewModel {
  TextEditingController searchController = TextEditingController();
  FocusNode searchFocusNode = FocusNode();
  late TabController tabController;

  List<Widget> tabs = [
    Tab(text: appStrings.allTab),
    Tab(text: appStrings.spotTab),
    Tab(text: appStrings.futureTab),
  ];

  final Ref _ref;

  HomeViewModel(this._ref);

  int get tabCount => tabs.length;

  void get onPressed {
    if (_ref.read(searchIcon) == Icons.search) {
      _ref.read(searchIcon.state).update((_) => Icons.cancel);
      _ref.read(searchTitle.state).update(
            (_) => ListTile(
              leading: const Icon(
                Icons.search,
                color: Colors.white,
                size: 28,
              ),
              title: TextField(
                focusNode: searchFocusNode,
                controller: searchController,
                onChanged: (_value) {
                  _ref.read(tableViewModel(tabController.index.name)).searchOnList(_value.toLowerCase());
                },
                decoration: InputDecoration(
                  hintText: appStrings.typeIn,
                  hintStyle: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontStyle: FontStyle.italic,
                  ),
                  border: InputBorder.none,
                ),
                style: const TextStyle(color: Colors.white),
              ),
            ),
          );
      searchFocusNode.requestFocus();
    } else {
      _ref.read(searchIcon.state).update((_) => Icons.search);
      _ref.read(searchTitle.state).update((_) => Text(appStrings.search));
      _ref.read(tableViewModel(tabController.index.name)).searchOnList('');
      searchController.clear();
      searchFocusNode.unfocus();
    }
  }

  void dispode() {
    searchController.dispose();
    searchFocusNode.dispose();
  }
}
