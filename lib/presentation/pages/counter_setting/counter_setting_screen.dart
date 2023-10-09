import 'package:flutter/material.dart';
import 'package:is_counter/common/localization.dart';
import 'package:is_counter/presentation/appbar/app_bar.dart';
import 'package:is_counter/presentation/pages/counter_setting/counter_setting_viewmodel.dart';
import 'package:is_counter/presentation/widgets/counter_itme_description.dart';
import 'package:is_counter/presentation/widgets/counter_text_field.dart';
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
                  child: Column(
                children: [
                  counterItemDescription(
                    string(Localize.addCounterTitleDescription),
                  ),
                  counterTextField(context),
                  counterItemDescription(
                    string(Localize.addCounterStartPoint),
                  ),
                  counterTextField(context),
                  counterItemDescription(
                    string(Localize.addCounterIncreaseValue),
                  ),
                  counterTextField(context),
                  counterItemDescription(
                    string(Localize.addCounterColorText),
                  ),
                ],
              )),
            ),
          );
        },
      ),
    );
  }
}
