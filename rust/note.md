# Copy Clone
    * Copy 栈上按位复制
    * Copy 隐式编译器自动行为, Clone 显示手动行为
    * 实现Copy 必须实现 Clone,  pub trait Copy: Clone {}
    * 自动实现Copy和Clone无法改变编译器默认行为
    * &T 引用默认实现Copy, &mut T 未实现
    * Tuple(T, T)/数组 成员全实现Copy, Tuple/数组也默认实现Copy
    * Struct/Enum 默认不实现Copy
    * 按位复制内存相同, 逐成员复制受对齐影响内存不一定相同

# Move
    * Box 实现DerefMove, Arc/Rc 其它大部分未实现
    * Move 后不是马上Drop 只是重新初始化

# Drop
    * 方法 创建顺序 后 -> 先
    * Tuple 左 -> 右
    * Strcut 先自己 再成员创建顺序 先 -> 后
    * 闭包 捕获顺序 先 -> 后
    * panic! 创建顺序 后 -> 先