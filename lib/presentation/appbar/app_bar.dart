import 'dart:ffi';

import 'package:flutter/material.dart';

class AppBarBuilder {
  String? _title;
  IconButton? _endNavButton;
  IconButton? _endIconButton;
  IconButton? _leadingIconButton;
  Color? _color;
  double _elevation = 4.0;

  // Setters for various configurations
  AppBarBuilder setTitle(String title) {
    _title = title;
    return this;
  }

  AppBarBuilder setEndIcon(Widget icon, Function() action) {
    _endIconButton = IconButton(onPressed: action, icon: icon);
    return this;
  }

  AppBarBuilder setEndNav(Widget icon, Function() action) {
    _endNavButton = IconButton(onPressed: action, icon: icon);
    return this;
  }

  AppBarBuilder setColor(Color color) {
    _color = color;
    return this;
  }

  AppBarBuilder removeElevation() {
    _elevation = 0.0;
    return this;
  }

  AppBarBuilder setLeading(Widget icon, Function() action) {
    _leadingIconButton = IconButton(onPressed: action, icon: icon);
    return this;
  }

  // Build the custom AppBar
  AppBar build() {
    return AppBar(
      leading: _leadingIconButton,
      centerTitle: true,
      title: _title != null
          ? Text(
              _title!,
              textAlign: TextAlign.center,
            )
          : null,
      actions: [
        if (_endIconButton != null) _endIconButton!,
        if (_endNavButton != null) _endNavButton!,
      ],
      backgroundColor: _color,
      elevation: _elevation,
    );
  }
}
