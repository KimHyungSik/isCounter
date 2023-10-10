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
                      controllerTitle:
                          context.select<CounterSettingViewModel, String>(
                        (value) => value.counter.title,
                      ),
                    ),
                    counterItemDescription(
                      string(Localize.addCounterStartPoint),
                    ),
                    counterTextField(
                      context,
                      controllerTitle:
                          context.select<CounterSettingViewModel, String>(
                        (value) => value.counter.startValue.toString(),
                      ),
                    ),
                    counterItemDescription(
                      string(Localize.addCounterIncreaseValue),
                    ),
                    counterTextField(
                      context,
                      controllerTitle:
                          context.select<CounterSettingViewModel, String>(
                        (value) => value.counter.incrementValue.toString(),
                      ),
                    ),
                    counterItemDescription(
                      string(Localize.addCounterColorText),
                    ),
                    ColorPicker(
                      selected: context.select<CounterSettingViewModel, int>(
                          (value) => value.counter.color),
                      onClick: (value) {},
                    ),
                    const Spacer(),
                    saveButton(context, () {
                      context.read<CounterSettingViewModel>().saveCounter(
                        () {
                          Navigator.pop(context);
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
