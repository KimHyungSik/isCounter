import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

enum CounterIcon {
  add("${iconUrl}icon_24_add.svg"),
  delete("${iconUrl}icon_24_delete.svg");

  const CounterIcon(this.url);
  final String url;
  static const String iconUrl = "assets/icons/";
  static getSvgIcon(String url) => SvgPicture.asset(url);
}
