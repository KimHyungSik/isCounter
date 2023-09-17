import 'package:flutter/material.dart';

import '../../common/localization.dart';
import '../../database/model/counter/counter_method.dart';

class MethodRaido extends StatelessWidget {
  const MethodRaido(
      {super.key, required this.selected, required this.onChanged});

  final Method selected;
  final void Function(Method) onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        methodRadioListTile(
          string(Localize.addCounterButtonMethod),
          Method.BUTTON,
        ),
        methodRadioListTile(
          string(Localize.addCounterScreenMethod),
          Method.SCREEN,
        ),
      ],
    );
  }

  RadioListTile<Method> methodRadioListTile(
    String title,
    Method value,
  ) {
    return RadioListTile(
      title: Text(title),
      value: value,
      groupValue: selected,
      onChanged: (value) {
        if (value != null) {
          onChanged(value);
        }
      },
    );
  }
}
