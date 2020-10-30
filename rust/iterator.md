## 基本Range
```
for i in 1..5 {
    print!("{} ", i);
}
// output: 1 2 3 4
```
```
for i in 1..=5 {
    print!("{} ", i);
}
// output: 1 2 3 4 5
```

## count 返回元素数量
```
println!("count = {}", (0..5).count());
// output: count = 5
```

## filter 过滤元素
```
for i in (0..10).filter(|x| (x % 2 == 0)) {
  print!("{} ", i);
}
// output: 0 2 4 6 8
```

## rev 返转
```
for i in (0..5).rev() {
  print!("{} ", i);
}
// output: 4 3 2 1 0
```

## map 给每个元素应用闭包
```
for i in (1..5).map(|x| x * x) {
    print!("{} ", i);
}
// output: 1 4 9 16 25
```

## fold 给每个元素应用闭包 结果传递下一个元素
```
let result = (1..5).fold(0, |acc, x| acc + x);
println!("sum = {}", result);

// output: sum = 10
```

## chain 组合
```
let r = (1..4).chain(5..8);

for i in r {
  print!("{} ", i);
}
// output: 1 2 3 5 6 7
```

## zip 组合
```
let names = ["zhang", "li", "wang"];
let ages = [25, 26, ‎27];

let p = names.iter().zip(ages.iter());

for (n, a) in p {
  println!("{:10}: age = {}", n, a);
}
// output
//zhang     : age = 25
//li        : age = 26
//wang      : age = 27
```

## enumerate 包含索引
```
let e = vec![1, 2, 3];
for (i, n) in e.iter().enumerate() {
    println!("e[{}] = {}", i, n);
}
//output
//e[0] = 1
//e[1] = 2
//e[2] = 3
```

## min max sum
```
let max = (1..6).max();
let min = (1..6).min();
let sum: i32 = (1..6).sum();

println!("max = {:?}, min = {:?}, sum = {}", max, min, sum);

//output
//max = Some(5), min = Some(1), sum = 15
```

## take 限制迭代次数
## collect 从迭代器获取值并转换
```
let v = (1..6).take(3).collect::<Vec<i32>>();
println!("{:?}", v)
//output [1, 2, 3]
```