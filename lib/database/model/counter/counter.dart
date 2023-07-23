import 'dart:core';

import 'counter_method.dart';

class Counter {
  String id;
  String title;
  String color;
  int startValue;
  int incrementValue;
  Method counterMethod;

  Counter({
    required this.id,
    required this.title,
    required this.color,
    required this.startValue,
    required this.incrementValue,
    required this.counterMethod,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'color': color,
      'startValue': startValue,
      'incrementValue': incrementValue,
      'counterMethod': counterMethod.toJson(),
    };
  }

  // fromJson 메서드: JSON 형식의 Map을 Counter 객체로 변환
  factory Counter.fromJson(Map<String, dynamic> json) {
    return Counter(
      id: json['id'],
      title: json['title'],
      color: json['color'],
      startValue: json['startValue'],
      incrementValue: json['incrementValue'],
      counterMethod: Method.fromJson(json['counterMethod']),
    );
  }
}
