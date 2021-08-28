# 插件开发

[官方例子](https://code.visualstudio.com/docs/extensions/yocode)  

# 常用插件

  * ES7 React/Redux/GraphQL/React-Native snippets
  * Rust
  * Rust-analyzer
  * Rust syntax
  * Crates
  * Better toml
  * Rust test lens
  * Tabnine

# 设置

```
{
    "workbench.activityBar.visible": false,
    "workbench.startupEditor": "newUntitledFile",
    "workbench.colorTheme": "Winter is Coming (Dark Blue)",
    "explorer.confirmDelete": false,
    "workbench.editor.enablePreview": false,
    "window.title": "${dirty}${activeEditorLong}${separator}${rootName}${separator}${appName}",
    "explorer.confirmDragAndDrop": false,
    "files.exclude": {
        "**/*.meta": true
    },
    "rust.rustfmt_path": "/home/fex/.rustup/toolchains/stable-x86_64-unknown-linux-gnu/bin/rustfmt",
    "rust-client.rlsPath": "/home/fex/.rustup/toolchains/stable-x86_64-unknown-linux-gnu/bin/rls",
    "editor.formatOnSave": true,
    "breadcrumbs.enabled": false,
    "javascript.implicitProjectConfig.experimentalDecorators": true,
    "editor.minimap.enabled": true,
    "editor.renderWhitespace": "none",
    "editor.fontFamily": "'Fira Code Retina', 'monospace', monospace, 'Droid Sans Fallback'",
    "editor.fontLigatures": true,
    "editor.fontSize": 16,
}
```

# 文件监视

```bash
 "files.watcherExclude": {
      "**/.git/objects/**": true,
      "**/.git/subtree-cache/**": true,
      "**/node_modules/*/**": true
  }
```