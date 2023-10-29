import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:is_counter/common/ads/ad_helper.dart';
import 'package:is_counter/database/controller/counter_controller.dart';
import 'package:is_counter/database/model/counter/counter.dart';
import 'package:is_counter/database/model/counter/counter_list.dart';
import 'package:is_counter/presentation/common/set_extension.dart';
import 'package:is_counter/presentation/pages/main/state/main_mode.dart';
import 'package:is_counter/presentation/pages/main/state/main_state.dart';

class MainViewModel extends ChangeNotifier {
  CounterList get counterList => state.counterList;
  final CounterController _counterController = CounterController();
  MainState state = LoadingState();
  MainMode _mode = MainMode.COUNTER;
  MainMode get mode => _mode;
  Set<String> _selectedRemoveItem = {};
  Set<String> get selectedRemoveItem => _selectedRemoveItem;
  BannerAd? banner;

  MainViewModel() {
    getCounterList();
  }

  Counter getCounter(String id) =>
      counterList.list.firstWhere((element) => element.id == id);

  Future getCounterList() async {
    final counterList = await _counterController.getCounterList();
    state = LoadedState(counterList);
    _mode = MainMode.COUNTER;
    notifyListeners();
  }

  void incrementValue(Counter counter) {
    final value = counter.value + 1;
    counter.value = value;
    _counterController.modifyCounter(counterList, counter);
    notifyListeners();
  }

  void decrementValue(Counter counter) {
    final value = counter.value - 1;
    counter.value = value;
    _counterController.modifyCounter(counterList, counter);
    notifyListeners();
  }

  Future removeSelectedCounter() async {
    final newCounterList = await _counterController.removeCounterIds(
      counterList,
      _selectedRemoveItem,
    );
    state = LoadedState(newCounterList);
    _selectedRemoveItem = {};
    _mode = MainMode.COUNTER;
    notifyListeners();
  }

  void changeMode() {
    _mode = _mode == MainMode.COUNTER ? MainMode.REMOVE : MainMode.COUNTER;
    _selectedRemoveItem = {};
    notifyListeners();
  }

  void changeTitle(Counter counter) {
    _counterController.modifyCounter(counterList, counter);
    notifyListeners();
  }

  void resetSelectedRemoveItem() {
    _selectedRemoveItem = {};
    notifyListeners();
  }

  void selectRemoveItem(String id) {
    _selectedRemoveItem.toggleItemInSet(id);
    notifyListeners();
  }

  bool isSelected(String id) => _selectedRemoveItem.contains(id);

  void initBannerAd() {
    BannerAd(
      size: AdSize.banner,
      adUnitId: AdHelper.bannerAdUnitId,
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          banner = ad as BannerAd;
          notifyListeners();
        },
        onAdFailedToLoad: (ad, err) {
          print('Failed to load a banner ad: ${err.message}');
          ad.dispose();
        },
      ),
      request: AdRequest(),
    ).load();
  }
}
