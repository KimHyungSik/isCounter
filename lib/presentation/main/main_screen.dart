import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../../database/model/counter/counter.dart';
import '../../database/model/counter/counter_method.dart';
import 'main_viewmodel.dart';

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    MainViewModel viewModel = Provider.of<MainViewModel>(context);
    final counter = Counter(
        id: "1",
        title: "title",
        color: "color",
        startValue: 0,
        incrementValue: 1,
        counterMethod: Method.BUTTON);
    viewModel.setCounterList([counter]);

    return Center(
      child: Text(viewModel.list.isEmpty ? "isEmpty" : viewModel.list[0].title),
    );
  }
}
