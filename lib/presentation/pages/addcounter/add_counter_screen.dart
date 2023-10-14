import 'package:flutter/material.dart';
import 'package:is_counter/common/localization.dart';
import 'package:is_counter/database/model/tags/tags.dart';
import 'package:is_counter/presentation/pages/addcounter/add_counter_viewmodel.dart';
import 'package:is_counter/presentation/appbar/app_bar.dart';
import 'package:is_counter/presentation/widgets/counter/counter_checkbox.dart';
import 'package:is_counter/presentation/widgets/counter/counter_itme_description.dart';
import 'package:is_counter/presentation/widgets/counter/counter_save_button.dart';
import 'package:is_counter/presentation/widgets/counter/counter_text_field.dart';
import 'package:is_counter/presentation/widgets/method_radio.dart';
import 'package:is_counter/theme/colors.dart';
import 'package:provider/provider.dart';

import '../../../database/model/counter/counter_method.dart';
import '../../widgets/color_picker.dart';

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
      body: LayoutBuilder(
        builder: (context, constraint) {
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
                    const SizedBox(
                      height: 16,
                    ),
                    counterCheckBox(
                      context,
                      string(Localize.counterVibrationSettings),
                      value: context.select<AddCounterViewModel, bool>(
                        (viewModel) => viewModel.vibration,
                      ),
                      onChanged:
                          context.read<AddCounterViewModel>().setVibration,
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
        },
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
          const SizedBox(
            height: 16,
          ),
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
            string(Localize.addCounterColorText),
          ),
          _selectedColor(
            context,
            (select) {
              context.read<AddCounterViewModel>().selectColor(select);
            },
          ),
          const SizedBox(
            height: 16,
          ),
          SizedBox(
            height: 150,
            child: GridView.count(
              crossAxisCount: 6,
              mainAxisSpacing: 6,
              crossAxisSpacing: 6,
              children: List.generate(
                CounterTags.values.length,
                (index) => GestureDetector(
                  onTap: () {
                    context.read<AddCounterViewModel>().updateTags(
                          CounterTags.values[index].name,
                        );
                  },
                  child: Selector<AddCounterViewModel, bool>(
                      selector: (context, viewModel) => viewModel.tags.contains(
                            CounterTags.values[index].name,
                          ),
                      builder: (context, isSelected, __) {
                        final backgroundColor = isSelected
                            ? Theme.of(context).dividerColor
                            : lightContainerBackgroundColor;
                        return Container(
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(8),
                            ),
                            color: backgroundColor,
                          ),
                          width: 30,
                          height: 30,
                          child: Icon(CounterTags.values[index].icon),
                        );
                      }),
                ),
              ),
            ),
          )
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
      onClick: (select) => onClick(select),
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
                saveButton(context, () {
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
                saveButton(
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
