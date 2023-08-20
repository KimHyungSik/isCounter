import '../../../database/model/counter/counter_list.dart';

sealed class MainState {
  final CounterList counterList;
  MainState(this.counterList);
}

class LoadingState extends MainState {
  LoadingState() : super(CounterList());
}

class LoadedState extends MainState {
  LoadedState(super.counterList);
}
