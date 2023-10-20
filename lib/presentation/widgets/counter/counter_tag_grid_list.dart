import 'package:flutter/material.dart';
import 'package:is_counter/database/model/tags/tags.dart';
import 'package:is_counter/theme/colors.dart';

Widget tagsGridView(
  BuildContext context,
  String? seletedTag,
  void Function(String)? opTap,
) {
  return SizedBox(
    height: 150,
    child: GridView.count(
      crossAxisCount: 6,
      mainAxisSpacing: 6,
      crossAxisSpacing: 6,
      children: List.generate(
        CounterTags.values.length,
        (index) {
          final tag = CounterTags.values[index].name;
          final isSeleted = seletedTag == tag;
          final backgroundColor =
              isSeleted ? darkGray : lightContainerBackgroundColor;
          final iconColor = isSeleted ? Colors.white : gray;
          return GestureDetector(
              onTap: () => opTap?.call(tag),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(8),
                  ),
                  color: backgroundColor,
                ),
                width: 30,
                height: 30,
                child: Icon(
                  CounterTags.values[index].icon,
                  color: iconColor,
                ),
              ));
        },
      ),
    ),
  );
}
