```dart

// 数据
import 'package:flutter/material.dart';

class Model1 with ChangeNotifier {
  Model1({this.name});

  String? name = "Jack";

  void change(String name) {
    this.name = name;
    notifyListeners();
  }
}

class Model2 with ChangeNotifier {
  Model2({this.age});

  int? age = 18;

  void change(int age) {
    this.age = age;
    notifyListeners();
  }
}

// 入口
return MultiProvider(
  providers: [
    ChangeNotifierProvider<Model1>(
        create: (_) => Model1(name: "init")),
    ChangeNotifierProvider<Model2>(create: (_) => Model2(age: 1)),
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
          Consumer<Model2>(
            builder: (_, model, child) {
              return Text((model.age ?? 0).toString(),
                  style: const TextStyle(color: Colors.green, fontSize: 30));
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
                    m1.change("change name");
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
                    m2.change(25);
                  },
                  child: const Text("change age"),
                ),
              );
            },
          ),
          Consumer2<Model1, Model2>(
            builder: (_, m1, m2, child) {
              return Padding(
                padding: const EdgeInsets.all(20),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5)))),
                  onPressed: () {
                    m1.change("change all");
                    m2.change(30);
                  },
                  child: const Text("change all"),
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