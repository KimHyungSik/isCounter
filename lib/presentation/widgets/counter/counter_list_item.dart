import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:is_counter/common/counter_icon.dart';
import 'package:is_counter/common/style/TextStyle.dart';
import 'package:is_counter/database/model/counter/counter.dart';
import 'package:is_counter/database/model/tags/tags.dart';
import 'package:is_counter/presentation/pages/main/main_viewmodel.dart';
import 'package:is_counter/presentation/widgets/color_picker.dart';
import 'package:provider/provider.dart';

class CounterListItem extends StatelessWidget {
  final Counter counter;
  final Function() incrementValue;
  final Function() decrementValue;
  final Function(Counter) navigatorCounterScreen;

  const CounterListItem({
    super.key,
    required this.counter,
    required this.incrementValue,
    required this.decrementValue,
    required this.navigatorCounterScreen,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: GestureDetector(
        onTap: () => navigatorCounterScreen(counter),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          color: counterColors[counter.color],
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            child: Column(
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 26,
                      height: 26,
                      child: IconButton(
                        padding: EdgeInsets.zero,
                        icon: SvgPicture.asset(
                          CounterIcon.minus.url,
                        ),
                        onPressed: () => decrementValue(),
                        iconSize: 26,
                      ),
                    ),
                    const Spacer(),
                    Consumer<MainViewModel>(
                      builder: (context, viewModel, _) => Text(
                        viewModel.getCounter(counter.id).value.toString(),
                        style: boldNumberStyle,
                      ),
                    ),
                    const Spacer(),
                    SizedBox(
                      width: 26,
                      height: 26,
                      child: IconButton(
                        padding: EdgeInsets.zero,
                        icon: SvgPicture.asset(
                          CounterIcon.plus.url,
                        ),
                        onPressed: () => incrementValue(),
                        iconSize: 26,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
