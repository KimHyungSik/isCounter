import 'package:flutter/material.dart';

class AppBarBuilder {
  String? _title;
  Icon? _endIcon;
  VoidCallback? _endIconAction;
  Icon? _endNav;
  VoidCallback? _endNavAction;

  // Setters for various configurations
  AppBarBuilder setTitle(String title) {
    _title = title;
    return this;
  }

  AppBarBuilder setEndIcon(Icon icon, VoidCallback action) {
    _endIcon = icon;
    _endIconAction = action;
    return this;
  }

  AppBarBuilder setEndNav(Icon icon, VoidCallback action) {
    _endNav = icon;
    _endNavAction = action;
    return this;
  }

  // Build the custom AppBar
  AppBar build() {
    return AppBar(
      title: _title != null ? Text(_title!) : null,
      actions: [
        if (_endIcon != null)
          IconButton(
            icon: _endIcon!,
            onPressed: _endIconAction,
          ),
        if (_endNav != null)
          IconButton(
            icon: _endNav!,
            onPressed: _endNavAction,
          ),
      ],
    );
  }
}
