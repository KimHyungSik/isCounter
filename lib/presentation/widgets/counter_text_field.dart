import 'package:flutter/material.dart';

TextField counterTextField(
  BuildContext context, {
  TextInputType keyboardType = TextInputType.text,
  String? controllerTitle,
  FocusNode? focusNode,
  void Function(String)? onChanged,
  void Function(String)? onSubmitted,
}) {
  return TextField(
    controller: TextEditingController(text: controllerTitle),
    focusNode: focusNode,
    decoration: const InputDecoration(
      border: OutlineInputBorder(),
    ),
    onSubmitted: onSubmitted,
    onChanged: onChanged,
  );
}
