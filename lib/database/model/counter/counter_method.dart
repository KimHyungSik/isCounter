enum Method {
  button,
  screen;

  String toJson() => name;
  static Method fromJson(String json) => values.byName(json);
}
