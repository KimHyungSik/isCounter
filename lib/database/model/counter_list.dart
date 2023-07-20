import 'counter.dart';

class CounterList {
  List<Counter> list;

  CounterList({List<Counter>? list}) : list = list ?? [];

  Map<String, dynamic> toJson() {
    return {
      'list': list.map((counter) => counter.toJson()).toList(),
    };
  }

  static CounterList fromJson(Map<String, dynamic> json) {
    List<Counter> counterList = [];
    if (json['list'] != null) {
      counterList = (json['list'] as List<dynamic>)
          .map((counterJson) => Counter.fromJson(counterJson))
          .toList();
    }
    return CounterList(list: counterList);
  }
}
