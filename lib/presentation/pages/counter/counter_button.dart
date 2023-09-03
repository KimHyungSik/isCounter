import 'package:flutter/material.dart';

Widget counterButton(
  BuildContext context,
  Icon icon,
  Color background,
  VoidCallback onPressed,
) {
  return Container(
    decoration: BoxDecoration(
      color: background,
      borderRadius: BorderRadius.circular(16),
    ),
    width: double.infinity,
    height: double.infinity,
    child: IconButton(
      icon: icon,
      onPressed: onPressed,
      color: Colors.white,
    ),
  );
}
