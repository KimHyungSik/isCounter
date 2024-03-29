import 'package:flutter/material.dart';

final List<Color> counterColors = [
  Colors.red,
  Colors.orange,
  Colors.green,
  Colors.blue,
  Colors.indigo,
  Colors.purple,
  Colors.pink,
];

class ColorPicker extends StatelessWidget {
  ColorPicker({
    super.key,
    this.selected = 0,
    required this.onClick,
  });

  final int selected;
  final void Function(int) onClick;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: counterColors.asMap().entries.map((entry) {
        return Flexible(
          flex: 1,
          child: GestureDetector(
            onTap: () {
              onClick(entry.key);
            },
            child: Container(
              decoration: BoxDecoration(
                border: selected == entry.key ? Border.all() : null,
                color: entry.value,
              ),
              height: 40,
            ),
          ),
        );
      }).toList(),
    );
  }
}
