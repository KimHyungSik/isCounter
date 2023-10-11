import 'package:flutter/material.dart';

Padding counterCheckBox(
  BuildContext context,
  String text, {
  bool? value,
  void Function(bool?)? onChanged,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16),
    child: Row(
      children: [
        Checkbox(
          value: value,
          onChanged: onChanged,
        ),
        const SizedBox(
          width: 16,
        ),
        Text(
          text,
          style: const TextStyle(fontSize: 18),
        )
      ],
    ),
  );
}
