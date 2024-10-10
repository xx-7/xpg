# install 

```bash
# https://pub.dev/packages/provider

provider: ^6.1.2

```

# Provider

  * Provider
    - 数据改变不自动更新视图
  * ChangeNotifierProvider
    - 数据改变notifyListeners()通知更新视图
  * FutureProvider
    - 默认显示初始数据
    - 只在create future完成时自动更新视图, 手动改变不自动更新
  * StreamProvider
    - 默认显示初始数据
    - 只在create stream里数据更新时自动更新视图
  * MultiProvider
    - 多个Provider
  * ProxyProvider
    - 一个数据依赖其它数据
  * ChangeNotifierProxyProvider
  * ListenableProvider
  * ListenableProxyProvider
  * ValueListenableProvider
    - 监听单一数变化
    - 数据改变不用通知,自动刷新视图

# Consumer

  * Provider.of
  * Consumer
  * Selector
  * InheritedContext