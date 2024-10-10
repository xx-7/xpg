```dart

// 数据
import 'package:flutter/material.dart';

class Model1 with ChangeNotifier {
  Model1({this.name});

  String? name = "Jack";

  void change({required String name}) {
    this.name = name;
    notifyListeners();
  }
}

class Model2 {
  Model2({this.model});

  Model1? model;

  void change() {
    model?.change(name: "proxy changed");
  }
}

// 入口
return MultiProvider(
    providers: [
      ChangeNotifierProvider<Model1>(
          create: (_) => Model1(name: "init")),
      ProxyProvider<Model1, Model2>(
          update: (_, m1, m2) => Model2(model: m1)),
    ],
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
          Consumer<Model1>(
            builder: (_, model, child) {
              return Text(model.name ?? "",
                  style: const TextStyle(color: Colors.red, fontSize: 30));
            },
          ),
          Consumer<Model1>(
            builder: (_, m1, child) {
              return Padding(
                padding: const EdgeInsets.all(20),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5)))),
                  onPressed: () {
                    m1.change(name: "change name");
                  },
                  child: const Text("change name"),
                ),
              );
            },
          ),
          Consumer<Model2>(
            builder: (_, m2, child) {
              return Padding(
                padding: const EdgeInsets.all(20),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5)))),
                  onPressed: () {
                    m2.change();
                  },
                  child: const Text("proxy change"),
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