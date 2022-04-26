 
# SLint

## 渲染

```bash
# gl 渲染过程
# backend::glWindow -> show()
#   mut renderer = glrenderer::GLItemRenderer::new() //renderer 实现 core::item_rendering::ItemRenderer
#   for (component, origin) in components {
#           core::item_rendering::render_component_items(component, &mut renderer, *origin); // origin::Point
#   }
#       render_item_children(renderer, component, -1)
#       递归 实现了Item trait  Item 用宏vtable 生成

```

## .slint文件

```bash
# 解析.slint时会根据文件生成一个MainWindow(名字在slint定义),这个类会实现trait internal::core::api::ComponentHandle
# MainWindow 内部是个helper_crates::vtable::VRc<ComponentVTable, InnerMainWindow>
# InnerMainWindow创建时会调用 slint::create_window -> i_slint_backend_selector::backend().create_window 创建window 然后调用slint::re_exports::init_component_items 初始化组件
# 自动生成的组件主要实现：slint::re_exports::PinnedDrop,WindowHandleAccess,Component,RepeatedComponent

```

### 方式1

```bash

# SLINT_DEFAULT_STYLE.txt internal/backends/selector/build.rs 会生成默认 有 qt native 没有 fluent

# 1. build.rs -> api::build::compile
#       1.1 syntax_node = i_slint_compiler::parser::parse_file  解析文件结构
#       1.2 compiler_config.style = 读取环境变量 SLINT_STYLE, SIXTYFPS_STYLE 没有就往OUT_DIR上两级找SLINT_DEFAULT_STYLE.txt
#       1.3 调用 i_slint_compiler::compile_syntax_node(syntax_node, diag, compiler_config)
#           1.3.1 global_type_registry = typeregister::TypeRegister::builtin() 包含一些初始的字段名， 并调用load_builtins::load_builtins 加载 builtins.slint
#           1.3.2 loader = typeloader::TypeLoader::new（global_type_registry） 根据 compiler_config.style加载 slint/internal/compiler/widgets目录下不同风格的std-widgets.slint 如没有设置还会读SLINT_STYLE
#           1.3.3 loader.load_dependencies_recursively() 加载所有依赖
#           1.3.4 files = loader.all_files() 返回生成文件目录
#       1.4 生成编译依赖输出到ouput 当环境变化或依赖文件发生变化重新生成
#       1.5 设置变量 SLINT_INCLUDE_GENERATED=files
# 2. main.rs -> api::slint::include_modules!()  -> include!(env!("SLINT_INCLUDE_GENERATED"))

```

### 方式2

```bash
# 1. main -> api::macros::slint!(import { MainWindow } from "xx.slint";);
# 2. 过程跟上面类似，只是后面不在保存.rs文件 直接返回 TokenStream


```

