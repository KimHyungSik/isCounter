import 'package:flutter/material.dart';
import 'package:is_counter/common/localization.dart';
import 'package:is_counter/presentation/addcounter/add_counter_viewmodel.dart';
import 'package:is_counter/presentation/appbar/app_bar.dart';
import 'package:provider/provider.dart';

class AddCounterScreen extends StatelessWidget {
  AddCounterScreen({super.key});

  final FocusNode fieldTitle = FocusNode(),
      fieldStartPoint = FocusNode(),
      fieldIncreaseValue = FocusNode();

  @override
  Widget build(BuildContext context) {
    AddCounterViewModel viewModel = Provider.of<AddCounterViewModel>(context);
    return Scaffold(
      appBar: AppBarBuilder().build(),
      body: Column(
        children: [
          TextField(
            focusNode: fieldTitle,
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              hintText: string(Localize.addCounterTitle),
            ),
            onSubmitted: (value) {
              FocusScope.of(context).requestFocus(fieldStartPoint);
            },
          ),
          TextField(
            focusNode: fieldStartPoint,
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              hintText: string(Localize.addCounterStartPoint),
            ),
            onSubmitted: (value) {
              FocusScope.of(context).requestFocus(fieldIncreaseValue);
            },
            keyboardType: TextInputType.number,
          ),
          TextField(
            focusNode: fieldIncreaseValue,
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              hintText: string(Localize.addCounterIncreaseValue),
            ),
            keyboardType: TextInputType.number,
            onSubmitted: (value) {
              showModalBottomSheet(
                context: context,
                builder: (BuildContext context) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        string(Localize.bottomSheetConfirm),
                      ),
                      ColorPicker(
                        selected: viewModel.selectedColor,
                        click: (select) {
                          viewModel.selectColor(select);
                        },
                      )
                    ],
                  );
                },
              );
            },
          ),
          ColorPicker(
            selected: viewModel.selectedColor,
            click: (select) {
              viewModel.selectColor(select);
            },
          )
        ],
      ),
    );
  }
}

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
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
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
