import 'package:flutter/material.dart';
import 'package:is_counter/common/localization.dart';
import 'package:is_counter/presentation/pages/addcounter/add_counter_viewmodel.dart';
import 'package:is_counter/presentation/appbar/app_bar.dart';
import 'package:is_counter/presentation/common/method_radio.dart';
import 'package:provider/provider.dart';

import '../../../database/model/counter/counter_method.dart';
import '../../common/color_picker.dart';

class AddCounterScreen extends StatelessWidget {
  final FocusNode fieldTitle = FocusNode(),
      fieldStartPoint = FocusNode(),
      fieldIncreaseValue = FocusNode();

  AddCounterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBarBuilder().build(),
      body: LayoutBuilder(builder: (context, constraint) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraint.maxHeight),
            child: IntrinsicHeight(
              child: Column(
                children: [
                  paddedColumn(context),
                  const SizedBox(
                    height: 16,
                  ),
                  selectedMethod(
                    context,
                    (method) {
                      context
                          .read<AddCounterViewModel>()
                          .setMethodValue(method);
                    },
                  ),
                  const Spacer(),
                  saveButton(
                    context,
                    () {
                      context.read<AddCounterViewModel>().saveCounter().then(
                        (value) {
                          if (value) {
                            Navigator.pop(context);
                          }
                        },
                      );
                    },
                  )
                ],
              ),
            ),
          ),
        );
      }),
    );
  }

  TextButton saveButton(
    BuildContext context,
    Function() onClick,
  ) {
    return TextButton(
      onPressed: () => onClick(),
      style: TextButton.styleFrom(
        padding: EdgeInsets.zero,
      ),
      child: Container(
        height: 50,
        width: double.infinity,
        color: Colors.white,
        alignment: Alignment.center,
        child: Column(
          children: [
            Text(
              string(Localize.save),
            ),
            const SizedBox(
              height: 8,
            ),
          ],
        ),
      ),
    );
  }

  Padding paddedColumn(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ItemDescription(
            string(Localize.addCounterTitle),
          ),
          titleTextField(context),
          ItemDescription(
            string(Localize.addCounterStartPoint),
          ),
          startValueTextField(context),
          ItemDescription(
            string(Localize.addCounterIncreaseValue),
          ),
          incrementValueField(context),
          ItemDescription(
            string(Localize.addCounterColorText),
          ),
          selectedColor(
            context,
            (select) {
              context.read<AddCounterViewModel>().selectColor(select);
            },
          ),
        ],
      ),
    );
  }

  Widget ItemDescription(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Text(text),
    );
  }

  Widget selectedMethod(
    BuildContext context,
    Function(Method) onClick,
  ) {
    return MethodRaido(
        selected: context.select<AddCounterViewModel, Method>(
          (value) => value.method,
        ),
        onChanged: (method) => onClick(method));
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

  Widget selectedColor(
    BuildContext context,
    Function(int) onClick,
  ) {
    return ColorPicker(
      selected: context
          .select<AddCounterViewModel, int>((value) => value.selectedColor),
      click: (select) => onClick(select),
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
      builder: (BuildContext bottomSheetContext) {
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
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                  ),
                  child: selectedColor(
                    context,
                    (select) {
                      context.read<AddCounterViewModel>().selectColor(select);
                      setState(() => {});
                    },
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                saveButton(
                  context,
                  () {
                    Navigator.pop(context);
                    showMethodBottomSheet(context);
                  },
                ),
                const SizedBox(
                  height: 16,
                )
              ],
            );
          },
        );
      },
    );
  }

  Future<dynamic> showMethodBottomSheet(
    BuildContext context,
  ) {
    return showModalBottomSheet(
      context: context,
      builder: (BuildContext bottomSHeetContext) {
        return StatefulBuilder(
          builder: (BuildContext conetxt, StateSetter setState) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 16,
                ),
                selectedMethod(
                  context,
                  (method) {
                    context.read<AddCounterViewModel>().setMethodValue(method);
                    setState(() => {});
                  },
                ),
                const SizedBox(
                  height: 24,
                ),
                saveButton(
                  context,
                  () {
                    Navigator.pop(context);
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
              ],
            );
          },
        );
      },
    );
  }
}
