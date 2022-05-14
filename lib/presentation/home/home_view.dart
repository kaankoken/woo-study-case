import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:woo_study_case/core/exports.dart';
import 'package:woo_study_case/core/extension/tab_index_extension.dart';
import 'package:woo_study_case/domain/home/home_view_model.dart';
import 'package:woo_study_case/domain/home/table_view_model.dart';
import 'package:woo_study_case/infra/modules/view_model_module.dart';
import 'package:woo_study_case/presentation/home/widgets/tabs/all_tab_view.dart';
import 'package:woo_study_case/presentation/home/widgets/tabs/future_tab_view.dart';
import 'package:woo_study_case/presentation/home/widgets/tabs/sport_tab_view.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  HomeViewState createState() => HomeViewState();
}

class HomeViewState extends ConsumerState<HomeView> with TickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(
      length: ref.read(homeViewModel).tabCount,
      vsync: this,
    );

    ref.read(homeViewModel).tabController = tabController;
    tabController.addListener(tabListener);

    super.initState();
  }

  void tabListener() {
    if (tabController.indexIsChanging) {
      ref.read(homeViewModel).searchController.clear();
      ref.read(tableViewModel(tabController.previousIndex.name)).searchOnList('');
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: ref.watch(homeViewModel.select((HomeViewModel viewModel) => viewModel.tabCount)),
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return [
              SliverAppBar(
                title: Center(child: Text(appStrings.title)),
                pinned: true,
                floating: true,
                bottom: TabBar(
                  controller: tabController,
                  isScrollable: true,
                  tabs: ref.watch(homeViewModel.select(((HomeViewModel viewModel) => viewModel.tabs))),
                ),
              ),
              SliverAppBar(
                title: ref.watch(searchTitle),
                automaticallyImplyLeading: false,
                pinned: true,
                primary: false,
                actions: [
                  IconButton(
                    onPressed: () => ref.read(homeViewModel).onPressed,
                    icon: Icon(ref.watch(searchIcon)),
                  ),
                ],
              ),
            ];
          },
          body: TabBarView(
            controller: tabController,
            children: const [
              AllTabView(),
              SpotTabView(),
              FutureTabView(),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    tabController.removeListener(tabListener);
    tabController.dispose();

    ref.read(homeViewModel).dispode();
    super.dispose();
  }
}
