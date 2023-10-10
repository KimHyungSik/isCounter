import 'package:flutter/material.dart';
import 'package:is_counter/common/localization.dart';
import 'package:is_counter/database/model/counter/counter.dart';
import 'package:is_counter/presentation/appbar/app_bar.dart';
import 'package:is_counter/presentation/pages/counter_setting/counter_setting_viewmodel.dart';
import 'package:is_counter/presentation/widgets/color_picker.dart';
import 'package:is_counter/presentation/widgets/counter/counter_itme_description.dart';
import 'package:is_counter/presentation/widgets/counter/counter_save_button.dart';
import 'package:is_counter/presentation/widgets/counter/counter_text_field.dart';
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
                  child: Padding(
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
                      controllerTitle: viewModel.counter.title,
                      onChanged: viewModel.setTitle,
                    ),
                    counterItemDescription(
                      string(Localize.addCounterStartPoint),
                    ),
                    counterTextField(
                      context,
                      controllerTitle: viewModel.counter.startValue.toString(),
                      onChanged: (value) =>
                          viewModel.setStartValue(int.parse(value)),
                    ),
                    counterItemDescription(
                      string(Localize.addCounterIncreaseValue),
                    ),
                    counterTextField(
                      context,
                      controllerTitle:
                          viewModel.counter.incrementValue.toString(),
                      onChanged: (value) =>
                          viewModel.setIncrementValue(int.parse(value)),
                    ),
                    counterItemDescription(
                      string(Localize.addCounterColorText),
                    ),
                    ColorPicker(
                      selected: context.select<CounterSettingViewModel, int>(
                        (viewModel) => viewModel.counter.color,
                      ),
                      onClick: (value) {
                        viewModel.selectColor(value);
                      },
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
                ),
              )),
            ),
          );
        },
      ),
    );
  }
}
