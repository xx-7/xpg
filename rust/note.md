# 编译流程
    - text code  ->  tokens  ->  ast  ->  hir  -> mir  ->  llvm ir  ->  llvm  ->  二进制

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
    * Move 后不是马上Drop 只是重置最初始化状态

# Drop
    * 方法 创建顺序 后 -> 先
    * Tuple 左 -> 右
    * Strcut 先自己 再成员创建顺序 先 -> 后
    * 闭包 捕获顺序 先 -> 后
    * panic! 创建顺序 后 -> 先

# Lifetime
    * late bound <'a> 
    * early bound <'longest: 'short>

# Trait

## 常用内置Trait
    * Copy      隐式编译器复制
    * Clone     显示手动复制
    * Debug     格式化时 {:?} 输出
    * Display   格式化时 {} 输出
    * Send      线程间传递所有权
    * Sync      线程间传递不可变借用

## 作用
    * 接口
    * 类型标记
    * 泛型限定
    * 抽象类型

# 过程宏
    * syn
    * quote
    * proc-macro2

# Unsafe
    * 解引用裸指针
    * 调用unsafe的函数或方法
    * 访问或修改可变静态变量
    * 实现unsafe trait
    * 读写Union联合体中的字段

# 原子操作

## Struct
    * AtomicBool
    * AtomicI8	
    * AtomicI16	
    * AtomicI32	
    * AtomicI64	
    * AtomicIsize	
    * AtomicPtr	
    * AtomicU8	
    * AtomicU16	
    * AtomicU32	
    * AtomicU64	
    * AtomicUsize

## Ordering
    * Relaxed 保存原子操作, 不同步, 不重排
    * Release 写操作, 所有读写操作无法排到Release之后, 对所有Acquire线程可见
    * Acquire 读操作, 保证在所有Release写操作之前
    * AcqRel 同时具有 Acquire 和 Release 的效果, 只能用在load store
    * SeqCst 同步所有线程, 所有线程看到是一样的顺序, 就像单线程


## 常见操作

* load(order) -> val
    > 读取值 返回
    > order 可选 SeqCst,Acquire,Relaxed
* store(val, order) 保存值为val 参数
    > 保存值 val
    > order 可选 SeqCst,Release,Relaxed
* swap(val, order) -> pval
    > 交换值 返回pval交换前的值
    > val 交换后的值
* compare_exchange(current,new,success,failure) -> Result<val, val>
    > 如果原子值与current相同，则将值new存储到原子中
    > 成功返Ok(current), 失败返回Err(原子值)
    > success 描述了如果与 current 的比较成功则发生的 read-modify-write 操作所需的顺序
    > failure 描述了在比较失败时发生的加载操作所需的排序
    > 失败排序只能是 SeqCst,Acquire,Relaxed

    * compare_exchange_weak(current,new,success,failure) -> Result<val, val>
    > 如果原子值与current相同，则将值new存储到原子中.
    > 与compare_exchange 不同 即使比较成功也可以可能返回失败, 返回是是否写入成功.
    > 成功返Ok(current)，失败返回Err(原子值)
    > success 描述了如果与 current 的比较成功则发生的 read-modify-write 操作所需的顺序
    > failure 描述了在比较失败时发生的加载操作所需的排序
    > 失败排序只能是 SeqCst,Acquire,Relaxed

    