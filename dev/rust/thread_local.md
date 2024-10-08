# thread_local!

```rust
use std::cell::RefCell;

fn main() {
    thread_local! {
        static c: RefCell<u32>  = RefCell::new((5));
    }
    // LocalKey { .. }
    println!("{:?}", c);

    c.with(|v| {
        // Ok(5)
        println!("{:?}", v.try_borrow_mut());
    });
}
```