# Copy

> 隐式编译器复制

```rust

#[derive(Debug, Copy, Clone)]
struct Foo;

fn main() {
    let x = Foo;
    // `y` is a copy of `x`
    let y = x;
    println!("{:?}", x); // OK!
}

```

# Clone

>  显示手动复制

```rust

#[derive(Debug, Copy, Clone)]
struct Foo;

#[derive(Debug)]
struct Bar;

impl Copy for Bar {}

impl Clone for Bar {
    fn clone(&self) -> Self {
        *self
    }
}

fn main() {
    let x = Foo;
    // `y` is a clone of `x`
    let y = x.clone();
    println!("{:?} {:?}", x, y); // OK!

    let x = Bar;
    // `y` is a clone of `x`
    let y = x.clone();
    println!("{:?} {:?}", x, y); // OK!
}

```

# Debug Display

>  格式输出: Debug - {:?} Display: {}

```bash
#[derive(Debug)]
struct Foo {
    val: i32,
}

struct Bar {
    val: i32,
}

use std::fmt;

impl fmt::Debug for Bar {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        f.debug_struct("Bar").field("val", &self.val).finish()
    }
}

impl fmt::Display for Bar {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        write!(f, "Bar.val = {}", self.val)
    }
}

fn main() {
    let a = Foo { val: 1 };

    println!("derive Debug: {:?}", a);

    let b = Bar { val: 2 };
    println!("Debug: {:?}", b);

    println!("Display: {}", b);
}
```

# Send Sync

> 线程间传递：Sync -> T , Send -> &T