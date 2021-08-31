
| Phantom type              | 'a   | T                       |
| :------------------------ | :--- | :---------------------- |
| PhantomData<T>            | -    | 协变  (with drop check) |
| PhantomData<&'a T>        | 协变 | 协变                    |
| PhantomData<&'a mut T>    | 协变 | 不变                    |
| PhantomData<*const T>     | -    | 协变                    |
| PhantomData<*mut T>       | -    | 不变                    |
| PhantomData<fn(T)>        | -    | 逆变                    |
| PhantomData<fn() -> T>    | -    | 协变                    |
| PhantomData<fn(T) -> T>   | -    | 不变                    |
| PhantomData<Cell<&'a ()>> | 不变 | -                       |

# 例子

## 未使用生命周期

```rust

struct Slice<'a, T> {
    start: *const T,
    end: *const T,
}

use std::marker::PhantomData;

struct Slice<'a, T: 'a> {
    start: *const T,
    end: *const T,
    _mark: PhantomData<&'a T>,
}

```

## 未使用类型
```rust
use std::marker::PhantomData;
use std::mem;

struct ExternalResource<R> {
   resource_handle: *mut (),
   _mark: PhantomData<R>,
}

impl<R: ResType> ExternalResource<R> {
    fn new() -> Self {
        let size_of_res = mem::size_of::<R>();
        Self {
            resource_handle: foreign_lib::new(size_of_res),
            _mark: PhantomData,
        }
    }

    fn do_stuff(&self, param: ParamType) {
        let foreign_params = convert_params(param);
        foreign_lib::do_stuff(self.resource_handle, foreign_params);
    }
}
```

## 标记关系 with drop check

```rust

struct Vec<T> {
    data: *const T, // *const for variance!
    len: usize,
    cap: usize,
}

use std::marker;

struct Vec<T> {
    data: *const T, // *const for variance!
    len: usize,
    cap: usize,
    _marker: marker::PhantomData<T>,
}

```