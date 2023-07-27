import 'package:intl/intl.dart';

String string(Localize localize) => Intl.message(localize.key);

enum Localize {
  addCounterTitle("add_counter_title"),
  addCounterColorText("add_counter_color_text"),
  addCounterStartPoint("add_counter_start_point"),
  addCounterIncreaseValue("add_counter_increase_value"),
  addCounterMethod("add_counter_method"),
  addCounterButtonMethod("add_counter_button_method"),
  addCounterScreenMethod("add_counter_screen_method");

  final String key;
  const Localize(this.key);
}
