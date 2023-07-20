enum Method {
  BUTTON,
  SCREEN;

  String toJson() => name;
  static Method fromJson(String json) => values.byName(json);
}
