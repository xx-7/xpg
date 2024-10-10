```dart

// 数据
class Model {
  Model({this.name});

  String? name = "Jack";

  void change() {
    name = "Changed";
  }
}


// stream

import 'package:demo/model.dart';

class ExampleStream {
  Stream<Model> getStreamModel() {
    return Stream<Model>.periodic(const Duration(milliseconds: 1000),
        (value) => Model(name: "$value")).take(10);
  }
}

// 入口
return StreamProvider<Model>(
  initialData: Model(name: "init"),
  create: (_) => ExampleStream().getStreamModel(),
  child: const Example(),
);

// 使用
import 'package:flutter/material.dart';
import 'package:demo/model.dart';
import 'package:provider/provider.dart';

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
              return Text(model.name ?? "",
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