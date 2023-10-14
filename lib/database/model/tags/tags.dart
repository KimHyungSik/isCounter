import 'package:flutter/material.dart';

enum CounterTags {
  esports(Icons.sports_esports),
  gmaes(Icons.games),
  extension(Icons.extension),
  hospital(Icons.local_hospital),
  medication(Icons.medication),
  vaccines(Icons.vaccines),
  download(Icons.download),
  upload(Icons.file_upload),
  cart(Icons.shopping_cart),
  sell(Icons.sell),
  fitness(Icons.fitness_center),
  run(Icons.directions_run),
  walk(Icons.directions_walk),
  bike(Icons.directions_bike),
  hiking(Icons.hiking),
  pool(Icons.pool),
  surfing(Icons.surfing),
  bed(Icons.bed),
  chair(Icons.chair),
  coffee(Icons.coffee),
  shower(Icons.shower),
  mop(Icons.moped),
  settings(Icons.settings),
  bolt(Icons.bolt),
  water(Icons.water_drop),
  quiz(Icons.quiz),
  cookie(Icons.cookie),
  camera(Icons.photo_camera);

  const CounterTags(this.icon);
  final IconData icon;

  String toJson() => name;
  static CounterTags fromJson(String json) => values.byName(json);
}
