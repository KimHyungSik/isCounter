import 'dart:core';

import 'counter_method.dart';

class Counter {
  String id;
  String title;
  int color;
  int value;
  int startValue;
  int incrementValue;
  bool vibration;
  Method counterMethod;

  Counter({
    required this.id,
    required this.title,
    required this.color,
    required this.value,
    required this.startValue,
    required this.incrementValue,
    required this.vibration,
    required this.counterMethod,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'color': color,
      'value': value,
      'startValue': startValue,
      'incrementValue': incrementValue,
      'vibration': vibration,
      'counterMethod': counterMethod.toJson(),
    };
  }

  factory Counter.fromJson(Map<String, dynamic> json) {
    return Counter(
      id: json['id'],
      title: json['title'],
      color: json['color'],
      value: json['value'],
      startValue: json['startValue'],
      incrementValue: json['incrementValue'],
      vibration: json['vibration'] ?? true,
      counterMethod: Method.fromJson(json['counterMethod']),
    );
  }
}
