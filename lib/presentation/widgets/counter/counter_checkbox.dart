import 'package:flutter/material.dart';
import 'package:is_counter/theme/colors.dart';

Widget counterCheckBox(
  BuildContext context,
  String text, {
  bool value = true,
  void Function(bool?)? onChanged,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16),
    child: GestureDetector(
      onTap: () {
        onChanged?.call(!value);
      },
      child: Container(
        width: double.infinity,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Checkbox(
              value: value,
              onChanged: null,
              fillColor: MaterialStateProperty.resolveWith<Color>(
                  (_) => lightPrimaryColor),
            ),
            const SizedBox(
              width: 16,
            ),
            Text(
              text,
              style: const TextStyle(fontSize: 18),
            ),
            const Spacer()
          ],
        ),
      ),
    ),
  );
}
