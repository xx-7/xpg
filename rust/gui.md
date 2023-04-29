# GUI

    * slint-ui  类QT,通过读.slint文件宏自动生成，代码质量高
        - 230428 性能有些差,表格创建10000行能卡死, QT秒速.
    * imgui-rs  C++库 imgui的绑定，界面美观
    * egui  类似于imgui的rust实现,原始界面一般,可以定制.        
    * fltk-rs C++库 fltk的绑定
    * gtk-rs  gtk库的绑定
    * conrod 作者不再开发新功能,只维护. 推荐egui.(作者在开发nannou)
    * bevy 游戏引擎开发中，随便一个界面编译后30MB
    * sciter web渲染,性能很好也很小巧, 功能不是很全, 没什么维护长期不更新
    * tauri web渲染, 功能多, win上WebView2问题很多,性能很差

```rust
// windows 去dos框
#![windows_subsystem = "windows"]
```