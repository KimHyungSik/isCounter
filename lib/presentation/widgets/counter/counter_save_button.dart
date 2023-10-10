import 'package:flutter/material.dart';
import 'package:is_counter/common/localization.dart';

Widget saveButton(
  BuildContext context,
  Function() onClick,
  Localize localize,
) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
    child: TextButton(
      onPressed: () => onClick(),
      style: TextButton.styleFrom(
        padding: EdgeInsets.zero,
      ),
      child: Container(
        height: 50,
        width: double.infinity,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(8)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              string(localize),
              style: const TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    ),
  );
}
