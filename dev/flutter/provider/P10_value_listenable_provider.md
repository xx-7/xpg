```dart

// 数据
import 'package:flutter/material.dart';

class Model extends ValueNotifier<int> {
  Model(super.value) {
    scheduleDecrement();
  }
  void scheduleDecrement() {
    Future.delayed(const Duration(seconds: 1), () {
      if (--value > 0) scheduleDecrement();
    });
  }
}

// 入口
return ValueListenableProvider<int>.value(
    value: Model(10),
    child: const Example(),
  );

// 使用
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Example extends StatelessWidget {
  const Example({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Consumer<int>(
            builder: (_, model, child) {
              return Text(model.toString(),
                  style: const TextStyle(color: Colors.red, fontSize: 30));
            },
          ),
        ],
      ),
    );
  }
}



```