```dart

// 数据
import 'package:flutter/material.dart';

class Model with ChangeNotifier {
  String name = "Jack";

  int age = 18;
  String phone = "18888888888";

  void changeAge() {
    age++;
    notifyListeners();
  }

  void changeName({required String name}) {
    this.name = name;
    notifyListeners();
  }
}

// 入口
return ChangeNotifierProvider(
    create: (_) => Model(),
    child: const Example(),
  );

// 使用

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:demo/model.dart';

class Example extends StatelessWidget {
  const Example({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Selector<Model, int>(
          selector: (_, m) => m.age,
          builder: (_, vaL, child) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(vaL.toString(),
                    style: const TextStyle(color: Colors.red, fontSize: 30)),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5)))),
                  onPressed: () {
                    Provider.of<Model>(context, listen: false).changeAge();
                  },
                  child: const Text("change"),
                )
              ],
            );
          }),
    );
  }
}

```