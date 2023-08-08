import 'package:flutter/material.dart';

class ColorPicker extends StatelessWidget {
  ColorPicker({
    super.key,
    this.selected = 0,
    required this.click,
  });

  final int selected;
  final void Function(int) click;

  final List<Color> colors = [
    Colors.red,
    Colors.orange,
    Colors.yellow,
    Colors.green,
    Colors.blue,
    Colors.indigo,
    Colors.purple,
    Colors.pink,
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      child: Row(
        children: colors.asMap().entries.map((entry) {
          return Flexible(
            flex: 1,
            child: GestureDetector(
              onTap: () {
                click(entry.key);
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
      ),
    );
  }
}