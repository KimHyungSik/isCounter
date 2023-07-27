import 'package:flutter/material.dart';
import 'package:is_counter/common/localization.dart';
import 'package:is_counter/presentation/appbar/app_bar.dart';

class AddCounterScreen extends StatelessWidget {
  AddCounterScreen({super.key});

  final FocusNode fieldTitle = FocusNode(),
      fieldStartPoint = FocusNode(),
      fieldIncreaseValue = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarBuilder().build(),
      body: Column(
        children: [
          TextField(
            focusNode: fieldTitle,
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              hintText: string(Localize.addCounterTitle),
            ),
            onSubmitted: (value) {
              FocusScope.of(context).requestFocus(fieldStartPoint);
            },
          ),
          TextField(
            focusNode: fieldStartPoint,
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              hintText: string(Localize.addCounterStartPoint),
            ),
            onSubmitted: (value) {
              FocusScope.of(context).requestFocus(fieldIncreaseValue);
            },
            keyboardType: TextInputType.number,
          ),
          TextField(
            focusNode: fieldIncreaseValue,
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              hintText: string(Localize.addCounterIncreaseValue),
            ),
            keyboardType: TextInputType.number,
          ),
        ],
      ),
    );
  }
}
