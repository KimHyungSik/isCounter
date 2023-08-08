import 'package:flutter/material.dart';
import 'package:is_counter/common/localization.dart';
import 'package:is_counter/database/model/counter/counter_method.dart';
import 'package:is_counter/presentation/addcounter/add_counter_viewmodel.dart';
import 'package:is_counter/presentation/appbar/app_bar.dart';
import 'package:is_counter/presentation/common/method_radio.dart';
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
            controller: TextEditingController(text: viewModel.title),
            focusNode: fieldTitle,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
            ),
            onSubmitted: (value) {
              FocusScope.of(context).requestFocus(fieldStartPoint);
            },
            onChanged: (value) {
              viewModel.setTitle(value);
            },
          ),
          TextField(
            controller:
                TextEditingController(text: viewModel.startValue.toString()),
            focusNode: fieldStartPoint,
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              hintText: string(Localize.addCounterStartPoint),
            ),
            onSubmitted: (value) {
              FocusScope.of(context).requestFocus(fieldIncreaseValue);
            },
            onChanged: (value) {
              viewModel.setStartValue(int.parse(value));
            },
            keyboardType: TextInputType.number,
          ),
          TextField(
            controller: TextEditingController(
                text: viewModel.incrementValue.toString()),
            focusNode: fieldIncreaseValue,
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              hintText: string(Localize.addCounterIncreaseValue),
            ),
            onSubmitted: (value) {
              showColorPickerBottomSheet(context, viewModel);
            },
            onChanged: (value) {
              viewModel.setIncrementValue(int.parse(value));
            },
            keyboardType: TextInputType.number,
          ),
          ColorPicker(
            selected: viewModel.selectedColor,
            click: (select) {
              viewModel.selectColor(select);
            },
          ),
          MethodRaido(
            selected: viewModel.method,
            onCHanged: (change) {
              viewModel.setMethodValue(change);
            },
          ),
          const Spacer(
            flex: 1,
          ),
          TextButton(
            onPressed: () {},
            child: Text("저장하기"),
          )
        ],
      ),
    );
  }

  Future<dynamic> showColorPickerBottomSheet(
    BuildContext context,
    AddCounterViewModel viewModel,
  ) {
    return showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext conetxt, StateSetter setState) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 24,
                ),
                ColorPicker(
                  selected: viewModel.selectedColor,
                  click: (select) {
                    setState(() {
                      viewModel.selectColor(select);
                    });
                  },
                ),
                bottomSheetConfrimButton(
                  context = context,
                  () {
                    Navigator.pop(context);
                    showMethodBottomSheet(context, viewModel);
                  },
                ),
                const SizedBox(
                  height: 32,
                )
              ],
            );
          },
        );
      },
    );
  }

  TextButton bottomSheetConfrimButton(
    BuildContext context,
    void Function() onPressed,
  ) {
    return TextButton(
      onPressed: onPressed,
      child: Container(
        width: double.infinity,
        color: Theme.of(context).colorScheme.primary,
        child: Text(
          string(Localize.bottomSheetConfirm),
        ),
      ),
    );
  }

  Future<dynamic> showMethodBottomSheet(
      BuildContext context, AddCounterViewModel viewModel) {
    return showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext conetxt, StateSetter setState) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                MethodRaido(
                  selected: viewModel.method,
                  onCHanged: (change) {
                    viewModel.setMethodValue(change);
                  },
                ),
                bottomSheetConfrimButton(
                  context = context,
                  () {
                    Navigator.pop(context);
                  },
                ),
                const SizedBox(
                  height: 32,
                ),
              ],
            );
          },
        );
      },
    );
  }
}
