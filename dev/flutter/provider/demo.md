# demo

```dart

// 定义数据
import 'package:flutter/material.dart';

class CountNotifier with ChangeNotifier {
  int count = 0;

  void increment() {
    count++;
    notifyListeners();
  }
}

//使用数据

import 'package:flutter/material.dart';
import 'package:demo/count_notifier.dart';
import 'package:provider/provider.dart';

class CountExample extends StatefulWidget {
  const CountExample({super.key});

  @override
  State<CountExample> createState() => _CountExampleState();
}

class _CountExampleState extends State<CountExample> {
  @override
  Widget build(BuildContext context) {
    final counter = Provider.of<CountNotifier>(context);

    return Center(
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        Text(
          counter.count.toString(),
          style: const TextStyle(color: Colors.red, fontSize: 28),
        ),
        ElevatedButton(
          onPressed: () => counter.increment(),
          child: const Text('increment'),
        )
      ]),
    );
  }
}

// 引用

return ChangeNotifierProvider(
      create: (_) => CountNotifier(),
      child: const CountExample()
    );


```