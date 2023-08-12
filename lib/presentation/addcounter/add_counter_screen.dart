import 'package:flutter/material.dart';
import 'package:is_counter/common/localization.dart';
import 'package:is_counter/presentation/addcounter/add_counter_viewmodel.dart';
import 'package:is_counter/presentation/appbar/app_bar.dart';
import 'package:is_counter/presentation/common/method_radio.dart';
import 'package:provider/provider.dart';

import '../../database/model/counter/counter_method.dart';
import '../common/color_picker.dart';

class AddCounterScreen extends StatelessWidget {
  AddCounterScreen({super.key, required this.addCounterArgs});

  final AddCounterArgs addCounterArgs;

  final FocusNode fieldTitle = FocusNode(),
      fieldStartPoint = FocusNode(),
      fieldIncreaseValue = FocusNode();

  @override
  Widget build(BuildContext context) {
    context
        .read<AddCounterViewModel>()
        .addTitleTail(addCounterArgs.titleCounter.toString());
    return Scaffold(
      appBar: AppBarBuilder().build(),
      body: Column(
        children: [
          titleTextField(context),
          startValueTextField(context),
          incrementValueField(context),
          selectedColor(),
          selectedMethod(),
          const Spacer(
            flex: 1,
          ),
          TextButton(
            onPressed: () {
              context.read<AddCounterViewModel>().saveCounter().then(
                (value) {
                  if (value) {
                    Navigator.pop(context);
                  }
                },
              );
            },
            child: Text("저장하기"),
          )
        ],
      ),
    );
  }

  Selector<AddCounterViewModel, Method> selectedMethod() {
    return Selector<AddCounterViewModel, Method>(
      selector: (context, viewModel) => viewModel.method,
      builder: (context, method, child) {
        return MethodRaido(
          selected: method,
          onCHanged: (change) {
            context.read<AddCounterViewModel>().setMethodValue(change);
          },
        );
      },
    );
  }

  TextField incrementValueField(BuildContext context) {
    final viewModel = context.read<AddCounterViewModel>();
    return TextField(
      controller:
          TextEditingController(text: viewModel.incrementValue.toString()),
      focusNode: fieldIncreaseValue,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        hintText: string(Localize.addCounterIncreaseValue),
      ),
      onSubmitted: (value) {
        showColorPickerBottomSheet(context);
      },
      onChanged: (value) {
        viewModel.setIncrementValue(int.parse(value));
      },
      keyboardType: TextInputType.number,
    );
  }

  Selector<AddCounterViewModel, int> selectedColor() {
    return Selector<AddCounterViewModel, int>(
      selector: (context, viewModel) => viewModel.selectedColor,
      builder: (context, selectedColor, child) {
        return ColorPicker(
          selected: selectedColor,
          click: (select) {
            context.read<AddCounterViewModel>().selectColor(select);
          },
        );
      },
    );
  }

  TextField startValueTextField(BuildContext context) {
    final viewModel = context.read<AddCounterViewModel>();
    return TextField(
      controller: TextEditingController(text: viewModel.startValue.toString()),
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
    );
  }

  TextField titleTextField(BuildContext context) {
    final viewModel = context.read<AddCounterViewModel>();
    return TextField(
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
    );
  }

  Future<dynamic> showColorPickerBottomSheet(
    BuildContext context,
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
                selectedColor(),
                bottomSheetConfrimButton(
                  context = context,
                  () {
                    Navigator.pop(context);
                    showMethodBottomSheet(context);
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
    BuildContext context,
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
                selectedMethod(),
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

class AddCounterArgs {
  final int? titleCounter;

  AddCounterArgs(this.titleCounter);
}
