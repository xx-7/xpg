# api

- std::pin::Pin
- std::marker::Unpin
- std::marker::PhantomPinned
- impl !Unpin for T

# 概念

- Pin自身个智能指针, impl了Deref和DerefMut
- Pin包裹的内容只能是指针
- Pin<P<T>>具有钉住T不能移动的功能,功能是否生效取决于T是 impl Unpin
- Unpin是编译器默认实现，PhantomPinned, impl Future实现 !Unpin
- Pin<P<T>>默认情况下钉住不生效,impl !Unpin情况才会生效

# 交换引用失效示例

```rust
#[derive(Debug)]
struct Test {
    a: String,
    b: *const String,
}

impl Test {
    fn new(txt: &str) -> Self {
        Test {
            a: String::from(txt),
            b: std::ptr::null(),
        }
    }

    fn init(&mut self) {
        let self_ref: *const String = &self.a;
        self.b = self_ref;
    }

    fn a(&self) -> &str {
        &self.a
    }

    fn b(&self) -> &String {
        unsafe { &*(self.b) }
    }
}

fn main() {
    let mut test1 = Test::new("test1");
    test1.init();
    let mut test2 = Test::new("test2");
    test2.init();
    //test1 a: test1, b: test1
    println!("test1 a: {}, b: {}", test1.a(), test1.b());

    std::mem::swap(&mut test1, &mut test2);
    test1.a = "I've totally changed now!".to_string();

    //test2 a: test1, b: I've totally changed now!
    println!("test2 a: {}, b: {}", test2.a(), test2.b());
}

```
# Pin到栈上

```rust

use std::marker::PhantomPinned;
use std::pin::Pin;

#[derive(Debug)]
struct Test {
    a: String,
    b: *const String,
    _marker: PhantomPinned,
}

impl Test {
    fn new(txt: &str) -> Self {
        Test {
            a: String::from(txt),
            b: std::ptr::null(),
            _marker: PhantomPinned, // This makes our type `!Unpin`
        }
    }

    fn init<'a>(self: Pin<&'a mut Self>) {
        let self_ptr: *const String = &self.a;
        let this = unsafe { self.get_unchecked_mut() };
        this.b = self_ptr;
    }

    fn a<'a>(self: Pin<&'a Self>) -> &'a str {
        &self.get_ref().a
    }

    fn b<'a>(self: Pin<&'a Self>) -> &'a String {
        unsafe { &*(self.b) }
    }
}

pub fn main() {
    let mut t1 = Test::new("test1");
    let mut test1 = unsafe { Pin::new_unchecked(&mut t1) };
    Test::init(test1.as_mut());

    let mut t2 = Test::new("test2");
    let mut test2 = unsafe { Pin::new_unchecked(&mut t2) };
    Test::init(test2.as_mut());

    println!(
        "a: {}, b: {}",
        Test::a(test1.as_ref()),
        Test::b(test1.as_ref())
    );
    // Compilier Error
    std::mem::swap(test1.get_mut(), test2.get_mut());
    println!(
        "a: {}, b: {}",
        Test::a(test2.as_ref()),
        Test::b(test2.as_ref())
    );
}

```

# Pin到堆上

```rust
use std::marker::PhantomPinned;
use std::pin::Pin;

#[derive(Debug)]
struct Test {
    a: String,
    b: *const String,
    _marker: PhantomPinned,
}

impl Test {
    fn new(txt: &str) -> Pin<Box<Self>> {
        let t = Test {
            a: String::from(txt),
            b: std::ptr::null(),
            _marker: PhantomPinned,
        };
        let mut boxed = Box::pin(t);
        let self_ptr: *const String = &boxed.as_ref().a;
        unsafe { boxed.as_mut().get_unchecked_mut().b = self_ptr };

        boxed
    }

    fn a<'a>(self: Pin<&'a Self>) -> &'a str {
        &self.get_ref().a
    }

    fn b<'a>(self: Pin<&'a Self>) -> &'a String {
        unsafe { &*(self.b) }
    }
}

pub fn main() {
    let mut test1 = Test::new("test1");
    let mut test2 = Test::new("test2");

    println!("a: {}, b: {}", test1.as_ref().a(), test1.as_ref().b());
    // Compilier Error
    // std::mem::swap(&mut *test1, &mut *test2);
    println!("a: {}, b: {}", test2.as_ref().a(), test2.as_ref().b());
}
```