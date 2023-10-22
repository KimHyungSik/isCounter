import 'package:flutter/material.dart';
import 'package:is_counter/common/localization.dart';
import 'package:is_counter/database/model/counter/counter.dart';
import 'package:is_counter/database/model/counter/counter_method.dart';
import 'package:is_counter/presentation/appbar/app_bar.dart';
import 'package:is_counter/presentation/pages/counter_setting/counter_setting_viewmodel.dart';
import 'package:is_counter/presentation/widgets/color_picker.dart';
import 'package:is_counter/presentation/widgets/counter/counter_checkbox.dart';
import 'package:is_counter/presentation/widgets/counter/counter_itme_description.dart';
import 'package:is_counter/presentation/widgets/counter/counter_save_button.dart';
import 'package:is_counter/presentation/widgets/counter/counter_tag_grid_list.dart';
import 'package:is_counter/presentation/widgets/counter/counter_text_field.dart';
import 'package:is_counter/presentation/widgets/method_radio.dart';
import 'package:provider/provider.dart';

class CounterSettingScreen extends StatelessWidget {
  const CounterSettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<CounterSettingViewModel>();
    return Scaffold(
      appBar: AppBarBuilder()
          .setTitle(context.read<CounterSettingViewModel>().title)
          .build(),
      body: LayoutBuilder(
        builder: (context, constraint) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraint.maxHeight),
              child: IntrinsicHeight(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 16,
                  ),
                  Padding(
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
                          controllerTitle: viewModel.counter.title,
                          onChanged: viewModel.setTitle,
                        ),
                        counterItemDescription(
                          string(Localize.addCounterColorText),
                        ),
                        ColorPicker(
                          selected:
                              context.select<CounterSettingViewModel, int>(
                            (viewModel) => viewModel.counter.color,
                          ),
                          onClick: (value) {
                            viewModel.selectColor(value);
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        counterItemDescription(
                          string(Localize.counterIcon),
                        ),
                        Selector<CounterSettingViewModel, String?>(
                          selector: (context, viewModel) => viewModel.tag,
                          builder: (context, selectedTag, _) => tagsGridView(
                            context,
                            selectedTag,
                            (value) => context
                                .read<CounterSettingViewModel>()
                                .updateTags(value),
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  _selectedMethod(
                    context,
                    (method) {
                      context
                          .read<CounterSettingViewModel>()
                          .setMethodValue(method);
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  counterCheckBox(
                    context,
                    string(Localize.counterVibrationSettings),
                    value: context.select<CounterSettingViewModel, bool>(
                      (viewModel) => viewModel.vibration,
                    ),
                    onChanged:
                        context.read<CounterSettingViewModel>().setVibration,
                  ),
                  const Spacer(),
                  saveButton(context, () {
                    context.read<CounterSettingViewModel>().saveCounter(
                      () {
                        Navigator.pop(context, viewModel.counter);
                      },
                    );
                  }, Localize.save),
                  const SizedBox(
                    height: 24,
                  )
                ],
              )),
            ),
          );
        },
      ),
    );
  }

  Widget _selectedMethod(
    BuildContext context,
    Function(Method) onClick,
  ) {
    return MethodRaido(
        selected: context.select<CounterSettingViewModel, Method>(
          (value) => value.counter.counterMethod,
        ),
        onChanged: (method) => onClick(method));
  }
}
