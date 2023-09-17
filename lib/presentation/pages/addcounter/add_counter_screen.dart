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
      appBar: AppBarBuilder()
          .setTitle(
            string(Localize.addCounterTitle),
          )
          .build(),
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
                  _saveButton(
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
                    Localize.save,
                  ),
                  const SizedBox(
                    height: 24,
                  )
                ],
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget _saveButton(
    BuildContext context,
    Function() onClick,
    Localize localize,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
      child: TextButton(
        onPressed: () => onClick(),
        style: TextButton.styleFrom(
          padding: EdgeInsets.zero,
        ),
        child: Container(
          height: 50,
          width: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(8)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                string(localize),
                style: const TextStyle(color: Colors.white),
              ),
            ],
          ),
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
          _itemDescription(
            string(Localize.addCounterTitle),
          ),
          titleTextField(context),
          _itemDescription(
            string(Localize.addCounterStartPoint),
          ),
          startValueTextField(context),
          _itemDescription(
            string(Localize.addCounterIncreaseValue),
          ),
          incrementValueField(context),
          _itemDescription(
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

  Widget _itemDescription(String text) {
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
                _saveButton(context, () {
                  Navigator.pop(context);
                  showMethodBottomSheet(context);
                }, Localize.next),
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
                _saveButton(
                  context,
                  () {
                    Navigator.pop(context);
                  },
                  Localize.save,
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
