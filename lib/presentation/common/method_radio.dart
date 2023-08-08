import 'package:flutter/material.dart';

import '../../common/localization.dart';
import '../../database/model/counter/counter_method.dart';

class MethodRaido extends StatelessWidget {
  const MethodRaido(
      {super.key, required this.selected, required this.onCHanged});

  final Method selected;
  final void Function(Method) onCHanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RadioListTile(
          title: Text(string(Localize.addCounterButtonMethod)),
          value: Method.BUTTON,
          groupValue: selected,
          onChanged: (value) {
            if (value != null) {
              onCHanged(value);
            }
          },
        ),
        RadioListTile(
          title: Text(string(Localize.addCounterScreenMethod)),
          value: Method.SCREEN,
          groupValue: selected,
          onChanged: (value) {
            if (value != null) {
              onCHanged(value);
            }
          },
        ),
      ],
    );
  }
}
