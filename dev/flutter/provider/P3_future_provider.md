```dart

// 数据
class Model {
  Model({this.name});

  String? name = "Jack";

  Future<void> change() async {
    await Future.delayed(const Duration(milliseconds: 2000));
    //不会自动更新视图
    name = "Changed";
  }
}

// future

import 'package:demo/model.dart';

class ExampleFuture {
  Future<Model> asyncGetModel() async {
    await Future.delayed(const Duration(milliseconds: 2000));
    return Model(name: "Loaded.");
  }
}

// 入口
return FutureProvider<Model>(
    initialData: Model(name: "init"),
    create: (_) => ExampleFuture().asyncGetModel(),
    child:  const Example(),
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