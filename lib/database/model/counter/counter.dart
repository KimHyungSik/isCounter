import 'dart:core';

import 'counter_method.dart';

class Counter {
  String id;
  String title;
  int color;
  int value;
  bool vibration;
  Method counterMethod;
  List<String> tags = <String>[];

  Counter({
    required this.id,
    required this.title,
    required this.color,
    required this.value,
    required this.vibration,
    required this.counterMethod,
    required this.tags,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'color': color,
      'value': value,
      'vibration': vibration,
      'counterMethod': counterMethod.toJson(),
      'tags': tags.toList()
    };
  }

  factory Counter.fromJson(Map<String, dynamic> json) {
    return Counter(
      id: json['id'],
      title: json['title'],
      color: json['color'],
      value: json['value'],
      vibration: json['vibration'] ?? true,
      counterMethod: Method.fromJson(json['counterMethod']),
      tags: List<String>.from(json['tags']),
    );
  }
}
