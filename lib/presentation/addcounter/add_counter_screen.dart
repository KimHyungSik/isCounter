import 'package:flutter/material.dart';
import 'package:is_counter/common/localization.dart';
import 'package:is_counter/presentation/addcounter/add_counter_viewmodel.dart';
import 'package:is_counter/presentation/appbar/app_bar.dart';
import 'package:provider/provider.dart';

import '../common/color_picker.dart';

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
              showColorPickerBottomSheet(context, viewModel);
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

  Future<dynamic> showColorPickerBottomSheet(
      BuildContext context, AddCounterViewModel viewModel) {
    return showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext conetxt, StateSetter setState) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  string(Localize.bottomSheetConfirm),
                ),
                ColorPicker(
                  selected: viewModel.selectedColor,
                  click: (select) {
                    setState(() {
                      viewModel.selectColor(select);
                    });
                  },
                )
              ],
            );
          },
        );
      },
    );
  }
}
