import 'package:flutter/material.dart';
import 'package:is_counter/common/style/TextStyle.dart';
import 'package:is_counter/database/model/counter/counter.dart';
import 'package:is_counter/database/model/tags/tags.dart';
import 'package:is_counter/presentation/widgets/color_picker.dart';
import 'package:is_counter/presentation/pages/main/main_viewmodel.dart';
import 'package:is_counter/theme/colors.dart';
import 'package:provider/provider.dart';

class CounterListRemoveItem extends StatelessWidget {
  final Counter counter;
  final Function(Counter) removeFun;

  const CounterListRemoveItem({
    super.key,
    required this.counter,
    required this.removeFun,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: GestureDetector(
        onTap: () => removeFun(counter),
        child: Selector<MainViewModel, bool>(
          selector: (context, viewModel) => viewModel.isSelected(counter.id),
          builder: (context, isSelected, _) {
            return Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
                side: isSelected
                    ? const BorderSide(
                        color: lightPrimaryColor,
                        width: 3.0,
                      )
                    : const BorderSide(width: 0),
              ),
              color: counterColors[counter.color],
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        if (counter.tag != null)
                          Icon(
                            CounterTags.nameToIcon(counter.tag!),
                            size: 20.0,
                          ),
                        const SizedBox(
                          width: 2,
                        ),
                        Text(
                          counter.title,
                          style: const TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    Row(
                      children: [
                        const SizedBox(
                          width: 26,
                          height: 26,
                        ),
                        const Spacer(),
                        Consumer<MainViewModel>(
                          builder: (context, viewModel, _) => Text(
                            viewModel.getCounter(counter.id).value.toString(),
                            style: boldNumberStyle,
                          ),
                        ),
                        const Spacer(),
                        const SizedBox(
                          width: 26,
                          height: 26,
                        )
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
