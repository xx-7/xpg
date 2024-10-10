```dart

// 数据
import 'package:flutter/material.dart';

class Model with ChangeNotifier {
  int age = 0;

  void change() {
    age++;
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(Provider.of<Model>(context).age.toString(),
              style: const TextStyle(color: Colors.red, fontSize: 30)),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5)))),
            onPressed: () {
              Provider.of<Model>(context, listen: false).change();
            },
            child: const Text("change"),
          )
        ],
      ),
    );
  }
}

```