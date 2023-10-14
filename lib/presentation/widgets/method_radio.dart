import 'package:flutter/material.dart';

import '../../common/localization.dart';
import '../../database/model/counter/counter_method.dart';
import '../../theme/colors.dart';

class MethodRaido extends StatelessWidget {
  const MethodRaido(
      {super.key, required this.selected, required this.onChanged});

  final Method selected;
  final void Function(Method) onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        children: [
          methodRadioListTile(
            string(Localize.addCounterButtonMethod),
            Method.button,
            context,
          ),
          methodRadioListTile(
            string(Localize.addCounterScreenMethod),
            Method.screen,
            context,
          ),
        ],
      ),
    );
  }

  Widget methodRadioListTile(String title, Method value, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
      child: Container(
        decoration: BoxDecoration(
          color: lightContainerBackgroundColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: selected == value
                ? Theme.of(context).dividerColor
                : lightContainerBackgroundColor,
            width: 2,
          ),
        ),
        child: RadioListTile(
          title: Text(title),
          value: value,
          groupValue: selected,
          onChanged: (value) {
            if (value != null) {
              onChanged(value);
            }
          },
        ),
      ),
    );
  }
}
