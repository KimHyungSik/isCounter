import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:is_counter/common/counter_icon.dart';
import 'package:is_counter/common/localization.dart';
import 'package:is_counter/database/model/counter/counter.dart';
import 'package:is_counter/presentation/appbar/app_bar.dart';
import 'package:is_counter/presentation/pages/counter/counter_viewmodel.dart';
import 'package:is_counter/presentation/pages/main/state/main_mode.dart';
import 'package:is_counter/presentation/pages/main/state/main_state.dart';
import 'package:is_counter/presentation/widgets/counter/counter_list_item.dart';
import 'package:is_counter/presentation/widgets/counter/counter_list_remove.dart';
import 'package:is_counter/route/navigators/add_counter_navigator.dart';
import 'package:is_counter/route/navigators/counter_navigator.dart';
import 'package:is_counter/theme/colors.dart';
import 'package:provider/provider.dart';
import 'package:is_counter/route/route.dart' as route;
import 'package:tuple/tuple.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../addcounter/add_counter_viewmodel.dart';
import 'main_viewmodel.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<MainViewModel>().initBannerAd();
    return Scaffold(
      appBar: AppBarBuilder()
          .setLeading(
            SvgPicture.asset(CounterIcon.delete.url),
            () {
              context.read<MainViewModel>().changeMode();
            },
          )
          .setEndIcon(
            SvgPicture.asset(CounterIcon.add.url),
            () {
              final args = AddCounterViewModelArgs(
                (context.read<MainViewModel>().counterList.list.length + 1)
                    .toString(),
              );
              AddCounterNav.pushNamed(context, args,
                  (_) => context.read<MainViewModel>().getCounterList());
            },
          )
          .setTitle(
            string(
              Localize.appTitle,
            ),
          )
          .build(),
      body: Stack(
        children: [
          _mainScrollView(),
          _removeButton(context) ?? Container(),
          Selector<MainViewModel, BannerAd?>(
            selector: (context, viewModel) => viewModel.banner,
            builder: (context, ad, _) {
              if (ad == null) {
                return Container();
              } else {
                return Align(
                  alignment: Alignment.bottomCenter,
                  child: SizedBox(
                    width: ad.size.width.toDouble(),
                    height: ad.size.height.toDouble(),
                    child: AdWidget(ad: ad),
                  ),
                );
              }
            },
          )
        ],
      ),
    );
  }

  Selector<MainViewModel, Tuple2<MainState, MainMode>> _mainScrollView() {
    return Selector<MainViewModel, Tuple2<MainState, MainMode>>(
      selector: (context, viewModel) => Tuple2(viewModel.state, viewModel.mode),
      builder: (context, data, child) {
        final viewModel = context.read<MainViewModel>();
        return CustomScrollView(
          slivers: [
            const SliverToBoxAdapter(
              child: SizedBox(height: 24),
            ),
            SliverList.builder(
              itemCount: viewModel.counterList.list.length,
              itemBuilder: (context, index) {
                final counter = viewModel.counterList.list[index];
                return counterListView(counter, context, data.item2);
              },
            ),
            const SliverToBoxAdapter(
              child: SizedBox(height: 24),
            ),
          ],
        );
      },
    );
  }

  Widget? _removeButton(BuildContext context) {
    final hasSeletedItem = context.select<MainViewModel, bool>(
      (viewModel) => viewModel.selectedRemoveItem.isNotEmpty,
    );
    final isRemoveMode = context.select<MainViewModel, bool>(
      (viewModel) => viewModel.mode == MainMode.REMOVE,
    );
    return isRemoveMode
        ? Align(
            alignment: AlignmentDirectional.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(
                top: 8,
                bottom: 30,
                left: 24,
                right: 24,
              ),
              child: TextButton(
                onPressed: () => hasSeletedItem
                    ? context.read<MainViewModel>().removeSelectedCounter()
                    : null,
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                ),
                child: Container(
                  height: 50,
                  width: double.infinity,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: hasSeletedItem
                          ? Theme.of(context).primaryColor
                          : lightGray,
                      borderRadius: BorderRadius.circular(8)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        string(Localize.counterRemove),
                        style: const TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        : null;
  }

  Widget counterListView(Counter counter, BuildContext context, MainMode mode) {
    if (mode == MainMode.COUNTER) {
      return CounterListItem(
        counter: counter,
        incrementValue: () =>
            context.read<MainViewModel>().incrementValue(counter),
        decrementValue: () =>
            context.read<MainViewModel>().decrementValue(counter),
        navigatorCounterScreen: (Counter counter) {
          CounterNav.pushNamed(
            context,
            CounterViewModelArgs(counter),
            (_) => context.read<MainViewModel>().getCounterList(),
          );
        },
      );
    } else {
      return CounterListRemoveItem(
        counter: counter,
        removeFun: (counter) =>
            context.read<MainViewModel>().selectRemoveItem(counter.id),
      );
    }
  }
}
