import 'package:intl/intl.dart';

String string(Localize localize) => Intl.message(localize.key);

enum Localize {
  appTitle("app_title"),
  counter("counter"),
  addCounterTitle("add_counter_title"),
  addCounterTitleDescription("add_counter_title_description"),
  addCounterColorText("add_counter_color_text"),
  addCounterStartPoint("add_counter_start_point"),
  addCounterIncreaseValue("add_counter_increase_value"),
  addCounterMethod("add_counter_method"),
  addCounterButtonMethod("add_counter_button_method"),
  addCounterScreenMethod("add_counter_screen_method"),
  bottomSheetConfirm("bottom_sheet_confirm"),
  counterVibrationSettings("counter_vibration_settings"),
  save("save"),
  next("next");

  final String key;
  const Localize(this.key);
}
