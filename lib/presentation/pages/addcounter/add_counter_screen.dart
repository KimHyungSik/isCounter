import 'package:flutter/material.dart';
import 'package:is_counter/common/localization.dart';
import 'package:is_counter/database/model/tags/tags.dart';
import 'package:is_counter/presentation/pages/addcounter/add_counter_viewmodel.dart';
import 'package:is_counter/presentation/appbar/app_bar.dart';
import 'package:is_counter/presentation/widgets/counter/counter_checkbox.dart';
import 'package:is_counter/presentation/widgets/counter/counter_itme_description.dart';
import 'package:is_counter/presentation/widgets/counter/counter_save_button.dart';
import 'package:is_counter/presentation/widgets/counter/counter_tag_grid_list.dart';
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
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              SliverFillRemaining(
                hasScrollBody: false,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _paddedColumn(context),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: counterItemDescription(
                        string(Localize.addCounterButtonMethod),
                      ),
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
                      height: 20,
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
                    const SizedBox(
                      height: 52,
                    ),
                  ],
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: saveButton(
                  context,
                  () {
                    context
                        .read<AddCounterViewModel>()
                        .saveCounter()
                        .then((value) {
                      if (value) {
                        Navigator.pop(context);
                      }
                    });
                  },
                  Localize.next,
                ),
              ),
            ),
          ),
        ],
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
            height: 20,
          ),
          counterItemDescription(
            string(Localize.addCounterTitleDescription),
          ),
          counterTextField(
            context,
            focusNode: fieldTitle,
            controllerTitle: viewModel.title,
            onChanged: (value) => viewModel.setTitle(value),
            onSubmitted: (_) => _showColorPickerBottomSheet(context),
          ),
          const SizedBox(
            height: 20,
          ),
          counterItemDescription(
            string(Localize.addCounterColorText),
          ),
          _selectedColor(
            context,
            (select) {
              context.read<AddCounterViewModel>().selectColor(select);
            },
            context.select<AddCounterViewModel, int>(
                (value) => value.selectedColor),
          ),
          const SizedBox(
            height: 20,
          ),
          counterItemDescription(
            string(Localize.counterIcon),
          ),
          Selector<AddCounterViewModel, String?>(
            selector: (context, viewModel) => viewModel.tag,
            builder: (context, selectedTag, _) => tagsGridView(
              context,
              selectedTag,
              (value) => context.read<AddCounterViewModel>().updateTags(value),
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
    int selectedColor,
  ) {
    return ColorPicker(
      selected: selectedColor,
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
          builder: (BuildContext _, StateSetter setState) {
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
                    context.read<AddCounterViewModel>().selectedColor,
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                saveButton(
                  context,
                  () {
                    context
                        .read<AddCounterViewModel>()
                        .saveCounter()
                        .then((value) {
                      if (value) {
                        Navigator.pop(context);
                      }
                    });
                  },
                  Localize.next,
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

  Future _showTagsBottomSheet(
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
                tagsGridView(
                  context,
                  context.read<AddCounterViewModel>().tag,
                  (value) =>
                      context.read<AddCounterViewModel>().updateTags(value),
                ),
                const SizedBox(
                  height: 24,
                ),
                saveButton(
                  context,
                  () {
                    Navigator.pop(context);
                    _showMethodBottomSheet(context);
                  },
                  Localize.next,
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
