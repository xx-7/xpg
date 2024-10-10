```dart

// 数据
import 'package:flutter/material.dart';

class Model with ChangeNotifier {
  String name = "Jack";

  void change() {
    name = "changed";
    //不通知是不会更新视图
    notifyListeners();
  }
}

// 入口
return ChangeNotifierProvider<Model>(
  create: (_) => Model(),
  child:  const Example(),
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Consumer<Model>(
            builder: (_, model, child) {
              return Text(model.name,
                  style: const TextStyle(color: Colors.red, fontSize: 30));
            },
          ),
          Consumer<Model>(
            builder: (_, model, child) {
              return Padding(
                padding: const EdgeInsets.all(20),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5)))),
                  onPressed: () {
                    model.change();
                  },
                  child: const Text("change"),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

```