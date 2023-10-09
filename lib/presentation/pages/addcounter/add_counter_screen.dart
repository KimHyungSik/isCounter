import 'package:flutter/material.dart';
import 'package:is_counter/common/localization.dart';
import 'package:is_counter/presentation/pages/addcounter/add_counter_viewmodel.dart';
import 'package:is_counter/presentation/appbar/app_bar.dart';
import 'package:is_counter/presentation/widgets/counter_text_field.dart';
import 'package:is_counter/presentation/widgets/method_radio.dart';
import 'package:provider/provider.dart';

import '../../../database/model/counter/counter_method.dart';
import '../../widgets/color_picker.dart';
import '../../widgets/counter_itme_description.dart';

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
                  _paddedColumn(context),
                  const SizedBox(
                    height: 16,
                  ),
                  _selectedMethod(
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

  Padding _paddedColumn(BuildContext context) {
    final viewModel = context.read<AddCounterViewModel>();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          counterItemDescription(
            string(Localize.addCounterTitleDescription),
          ),
          counterTextField(
            context,
            focusNode: fieldTitle,
            controllerTitle: viewModel.title,
            onChanged: (value) => viewModel.setTitle(value),
            onSubmitted: (_) =>
                FocusScope.of(context).requestFocus(fieldStartPoint),
          ),
          counterItemDescription(
            string(Localize.addCounterStartPoint),
          ),
          counterTextField(
            context,
            focusNode: fieldStartPoint,
            controllerTitle: viewModel.startValue.toString(),
            onChanged: (value) => viewModel.setStartValue(int.parse(value)),
            onSubmitted: (_) =>
                FocusScope.of(context).requestFocus(fieldIncreaseValue),
            keyboardType: TextInputType.number,
          ),
          counterItemDescription(
            string(Localize.addCounterIncreaseValue),
          ),
          counterTextField(
            context,
            focusNode: fieldIncreaseValue,
            controllerTitle: viewModel.incrementValue.toString(),
            onChanged: (value) => viewModel.setIncrementValue(int.parse(value)),
            onSubmitted: (_) => _showColorPickerBottomSheet(context),
            keyboardType: TextInputType.number,
          ),
          counterItemDescription(
            string(Localize.addCounterColorText),
          ),
          _selectedColor(
            context,
            (select) {
              context.read<AddCounterViewModel>().selectColor(select);
            },
          ),
        ],
      ),
    );
  }

  Widget _selectedMethod(
    BuildContext context,
    Function(Method) onClick,
  ) {
    return MethodRaido(
        selected: context.select<AddCounterViewModel, Method>(
          (value) => value.method,
        ),
        onChanged: (method) => onClick(method));
  }

  Widget _selectedColor(
    BuildContext context,
    Function(int) onClick,
  ) {
    return ColorPicker(
      selected: context
          .select<AddCounterViewModel, int>((value) => value.selectedColor),
      click: (select) => onClick(select),
    );
  }

  Future<dynamic> _showColorPickerBottomSheet(
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
                  child: _selectedColor(
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
                  _showMethodBottomSheet(context);
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

  Future<dynamic> _showMethodBottomSheet(
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
                _selectedMethod(
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
