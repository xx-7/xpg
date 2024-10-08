 
# egui

## 渲染

```bash
# core 渲染
# egui::Context::run(input, run_ui: FoOnce(&Context))
#       -> egui::context::Context::begin_frame(input) // -> begin_frame_mut 处理输入事件
#       -> run_ui //生成ui的内联函数
#       -> egui::context::Context::end_frame
#       -> return FullOutput{platform_output, needs_repaint, textures_delta, shapes}
#              -> platform_output 需要输出的，鼠标样式, 复制粘贴板,事件等
#              -> needs_repaint 是否需要重绘
#              -> textures_delta {free,set} set在使用的texture free 要删除的
#              -> shapes run_ui过程中调用painter.add() 添加的各种操作 Shape::Path, Shape::Circle, Shape::Text,  实现在epint
#                   -> 得到shapes后调用txt.tessellate -> epaint::ClippedPrimitive
#                   -> ClippedPrimitive中包含一个rect和一个primitive   primitive可能是Mesh PaintCallback 后面交给实际平台的渲染引擎


# native 渲染
#  -> egui_glow::epi_backend::run
#       -> egui-winit::epi::EpiIntegration::update(dyn App)
#           -> egui::context::Context::run   //core渲染
```

## UI

```bash
# run_ui 生成ui内联函数时会带个ui的参数
# 下面有很多方面可以生成ui元素,元素的实现在/egui/widgets 实现 trait Widget
# trait Widget 有个构建ui方法 fn ui(self, ui: &mut Ui) -> Response
# 构建ui的方法大部分返回 egui::Response  Response包含ctx, layer_id, rect(展示位置),一些事件，比如 clicked hovered 这些，
# 也有些返回InnerResponse 包含自定义的一些方法


```

## Texture

```bash
# 主要用来加载图片和字体

```