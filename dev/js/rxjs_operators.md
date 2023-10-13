|   类别   | 方法                                                         |
| :------- | :----------------------------------------------------------- |
|   [创建](#创建)   | [ajax](#ajax) [bindCallback](#bindCallback) [bindNodeCallback](#bindNodeCallback) [defer](#defer) [empty](#empty) [from](#from) [fromEvent](#fromEvent) [fromEventPattern](#fromEventPattern) [generate](#generate) [interval](#interval) [of](#of) [range](#range) [throwError](#throwError) [timer](#timer) [iif](#iif) |
|   [组合](#组合)   | [combineLatest](#combineLatest) [concat](#concat) [forkJoin](#forkJoin) [merge](#merge) [partition](#partition) [race](#race) [zip](#zip) [combineAll](#combineAll) [concatAll](#concatAll) [exhaust](#exhaust) [mergeAll](#mergeAll) [startWith](#startWith) [withLatestFrom](#withLatestFrom) |
|   [转换](#转换)   | [buffer](#buffer) [bufferCount](#bufferCount) [bufferTime](#bufferTime) [bufferToggle](#bufferToggle) [bufferWhen](#bufferWhen) [concatMap](#concatMap) [concatMapTo](#concatMapTo) [exhaust](#exhaust) [exhaustMap](#exhaustMap) [expand](#expand) [groupBy](#groupBy) [map](#map) [mapTo](#mapTo) [mergeMap](#mergeMap) [mergeMapTo](#mergeMapTo) [mergeScan](#mergeScan) [pairwise](#pairwise) [partition](#partition) [pluck](#pluck) [scan](#scan) [switchMap](#switchMap) [switchMapTo](#switchMapTo) [window](#window) [windowCount](#windowCount) [windowTime](#windowTime) [windowToggle](#windowToggle) [windowWhen](#windowWhen) |
|   [过滤](#过滤)   | [audit](#audit) [auditTime](#auditTime) [debounce](#debounce) [debounceTime](#debounceTime) [distinct](#distinct) [distinctKey](#distinctKey) [distinctUntilChanged](#distinctUntilChanged) [distinctUntilKeyChanged](#distinctUntilKeyChanged) [elementAt](#elementAt) [filter](#filter) [first](#first) [ignoreElements](#ignoreElements) [last](#last) [repeat](#repeat) [sample](#sample) [sampleTime](#sampleTime) [single](#single) [skip](#skip) [skipLast](#skipLast) [skipUntil](#skipUntil) [skipWhile](#skipWhile) [take](#take) [takeLast](#takeLast) [takeUntil](#takeUntil) [takeWhile](#takeWhile) [throttle](#throttle) [throttleTime](#throttleTime) |
|   [广播](#广播)   | [multicast](#multicast) [publish](#publish) [publishBehavior](#publishBehavior) [publishLast](#publishLast) [publishReplay](#publishReplay) [share](#share) |
|   [错误](#错误)   | [catchError](#catchError) [retry](#retry) [retryWhen](#retryWhen) |
|   [工具](#工具)   | [tap](#tap) [delay](#delay) [delayWhen](#delayWhen) [dematerialize](#dematerialize) [materialize](#materialize) [observeOn](#observeOn)  [subscribeOn](#subscribeOn) [timeInterval](#timeInterval) [timestamp](#timestamp) [timeout](#timeout) [timeoutWith](#timeoutWith) [toArray](#toArray) |
|    [条件](#条件)    | [defaultIfEmpty](#defaultIfEmpty) [every](#every) [find](#find) [findIndex](#findIndex) [isEmpty](#isEmpty) |
|&nbsp; &nbsp; &nbsp; &nbsp; [数学](#数学) &nbsp; &nbsp; &nbsp; &nbsp;| [count](#count) [max](#max) [min](#min) [reduce](#reduce) |


## 创建

### from
可以转入ObservableInput 和调度器 内部通过innerFrom返回Observable
ObservableInput  包含类型有Observable,Iterable,Promise,Array,AsyncIterable
示例：
```typescript
from([1, 'a', '2', 'c']).subscribe((val) => console.info(val));
//output 1 a 2 c

from('abc').subscribe((val) => console.info(val));
//ouput a b c 

from(new Promise(resolve => resolve('abc'))).subscribe(res => {
    console.log(res);
});
//output abc

let map = new Map();
map.set('a', 1);
map.set('b', 2);
from(map).subscribe(val => {
    console.log(val);
});
//ouput ["a", 1] ["b", 2]
```

### fromEvent
传入target, 事件类型
示例:
```typescript
fromEvent(document, 'click').subscribe(x => {
	console.log('click', x);
});
```
### interval
示例:
```typescript
interval(1000).subscribe((val) => console.info(val));
//interval 1000ms output 0 1 2 3 4 5 ... 
```

### of
可变参数方式转了数据源 实际内部先转换成数组再调用from
示倒:
```
of(1, 'a', '2', 'c').subscribe((val) => console.info(val));
```
输出:
```
1
a
2
c
```
### timer
示例:
```typescript
timer(3000, 1000).subscribe((val) => console.info(val));
//after 3000ms interval 1000ms ouput 0 1 2 3 4 5 ...

timer(2000).subscribe((val) => console.info(val));
//after 2000ms ouput 0
```

## 组合
###  merge
合并多个源

示例:
```typescript
const result = merge(interval(1000), interval(2000)).pipe(take(6));
result.subscribe(x => console.log(x));
```
```
0
1
0
2
3
1
```
### mergeAll
高阶转换

示例:
```typescript
const higherOrder = timer(1000).pipe(map((ev) => interval(1000).pipe(take(4))));
const firstOrder = higherOrder.pipe(mergeAll());
firstOrder.subscribe(x => console.log(x));
```
输出: 
>不用mergeAll 输出的是Observable对象
```
0
1
2
3
```

## 转换

### map
示例:
```typescript
of(1, 2, 3, 4).pipe(
	map((val) => val + 1)
).subscribe((val) => console.info(val));
```
输出:
```
2
3
4
5
```
### switchMap
示例:
```typescript
of(1, 2, 3).pipe(
	switchMap((val) => of(val + 1))
).subscribe((val) => console.info(val));

of(1, 2, 3).pipe(
	switchMap((val) => from([val + 1]))
).subscribe((val) => console.info(val));
```
输出
```
2
3
4
2
3
4
```

## 过滤
### debounce
传入一个 ObservableInput durationSelector 当数据a流入 先 durationSelector.unsubscribe 再durationSelector.subscribe 当durationSelector有数据b流入才返回a
示例:
```typescript
interval(1000).pipe(
	take(5),
	debounce((val) => {
	console.info('debounce: ' + val);
		return timer(val * 500);
	})
).subscribe((val) => console.info('interval: ' + val));
```
输出
```
debounce: 0
interval: 0
debounce: 1
interval: 1
debounce: 2
debounce: 3
debounce: 4
interval: 4
```
### debounceTime
传入毫秒数a  两次数据流入大于a毫秒才会输出, 小于会舍弃旧数据.
实现调用的是debounce方法，ObservableInput传入的是timer(a)
示例:
```typescript
interval(800).pipe(
	filter(val => val <= 3 || val == 5),
	debounceTime(1000)
).subscribe((val) => console.info(val));
```
输出:
```
3
5
```

### filter
传入 ()=> bool 方法
示例:
``` 
of(1, 2, 3, 4).pipe(
	filter((val) => val % 2 == 0)
).subscribe((val) => console.info(val));
```
输出:
```
2
4
```
### repeat
参数a 源流complete后，重复a次 没有参数时，一直重复
```typescript
const example = interval(500).pipe(take(3), repeat(2));
example.subscribe(x => console.log(x));
```
示例:
```
0
1
2
0
1
2
```

### takeUntil
参数ObservableInput 类型 a，a有数据时源流结束。

示例:
```typescript
const result = interval(1000).pipe(takeUntil(timer(5000)));
result.subscribe(x => console.log(x));
```
输出:
```
0
1
2
3
```

### takeWhile
满足条件时发送源数据，不满足时立即complete

示例:
```typescript
const result = interval(1000).pipe(takeWhile(x => x < 4));
result.subscribe(x => console.log(x));
```
输出:
```
0
1
2
3
```



## 广播

## 错误

## 工具
### tap
传入一个 ObservableInput 类似监听守护
示例:
``` 
of(1, 2).pipe(
    tap({
        next: (val => {
            console.log('tap next', val);
        }),
        complete: () => {
            console.log('tap complete');
        }
    })
)
    .subscribe({
        next: (val => {
          console.log('subscribe next', val);
        }),
        complete: () => {
          console.log('subscribe complete');
        }
    });
```
输出:
```
tap next 1
subscribe next 1
tap next 2
subscribe next 2
tap complete
subscribe complete
```

## 条件

## 数学

```

```