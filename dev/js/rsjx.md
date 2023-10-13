- [Observable](#Observable)
- [Observer](#Observer)
- [Operators](./rxjs_operators.md)
- [Subscription](#Subscription)
- [Subject](#Subject)
- [Scheduler](#Scheduler)



## Observable

observable 是基于数据流，异步订阅发布模式实现。创建的时候传入数据源、发布数据方法，subscribe时订阅数据，

示例：

```typescript
 
    const observable = new Observable(subscriber => {
      subscriber.next(1);
      subscriber.next(2);
      subscriber.next(3);
      setTimeout(() => {
        subscriber.next(4);
        subscriber.complete();
      }, 1000);
    });

    console.log('just before subscribe');
    observable.subscribe({
      next(x) { console.log('got value ' + x); },
      error(err) { console.error('something wrong occurred: ' + err); },
      complete() { console.log('done'); }
    });
    console.log('just after subscribe');

```

输出:

```
just before subscribe
got value 1
got value 2
got value 3
just after subscribe
got value 4
done
```

单发布多订阅示例:

```typescript
    const foo = new Observable(subscriber => {
      console.log('Hello');
      subscriber.next(42);
    });

    foo.subscribe(x => {
      console.log(x);
    });
    foo.subscribe(y => {
      console.log(y);
    });
```
输出:
```
Hello
42
Hello
42
```

## Observer

observer 是observable 订阅方法subscribe时转了的回调方法。包含三个回调方法：

1. next: (value: T) => void  产生数据时回调
2. error: (err: any) => void 出错时回调
3. complete: () => void 结束时回调。

 出错流关闭，无法再next数据。示例：

```typescript
    const observable = new Observable(subscriber => {
      subscriber.next(1);
      subscriber.next(2);
      setTimeout(() => {
        subscriber.next(3);
        subscriber.error('something error');
        subscriber.next(4);
      }, 1000);
    });

    console.log('just before subscribe');
    observable.subscribe({
      next(x) { console.log('got value ' + x); },
      error(err) { console.error('something wrong occurred: ' + err); },
      complete() { console.log('done'); }
    });
    console.log('just after subscribe');
```
输出：
```
just before subscribe
got value 1
got value 2
just after subscribe
got value 3
something wrong occurred: something error
```

流complete后无法再next数据。示例：
```typescript
    const observable = new Observable(subscriber => {
      subscriber.next(1);
      subscriber.next(2);
      setTimeout(() => {
        subscriber.next(3);
        subscriber.complete()
        subscriber.next(4);
      }, 1000);
    });

    console.log('just before subscribe');
    observable.subscribe({
      next(x) { console.log('got value ' + x); },
      error(err) { console.error('something wrong occurred: ' + err); },
      complete() { console.log('done'); }
    });
    console.log('just after subscribe');
```
输出:
```
just before subscribe
got value 1
got value 2
just after subscribe
got value 3
done
```

## Subscription
Subscription 是observable.subscribe() 订阅后返回对象

- add 添加其它Subscription
- unsubscribe 取消订阅

示例:
```typescript
    const observable1 = interval(400);
    const observable2 = interval(300);

    const subscription = observable1.subscribe(x => console.log('first: ' + x));
    const childSubscription = observable2.subscribe(x => console.log('second: ' + x));

    subscription.add(childSubscription);
    setTimeout(() => {
      subscription.unsubscribe();
    }, 1000);
```
输出:
```
second: 0
first: 0
second: 1
first: 1
second: 2
```

## Subject
- [Multicasted](#Multicasted)
- [BehaviorSubject](#BehaviorSubject)
- [ReplaySubject](#ReplaySubject)
- [AsyncSubject](#AsyncSubjec)

Subject 继承Observable 实现了 Subscription
示例:

```typescript
    const subject = new Subject<number>();

    subject.subscribe({
      next: (v) => console.log(`observerA: ${v}`)
    });
    subject.subscribe({
      next: (v) => console.log(`observerB: ${v}`)
    });

    const observable = from([1, 2, 3]);

    observable.subscribe(subject);
```
输出:
```
observerA: 1
observerB: 1
observerA: 2
observerB: 2
observerA: 3
observerB: 3
```
### Multicasted
multicast 广播
```typescript
    const source = interval(500);
    const subject = new Subject();
    const refCounted = source.pipe(multicast(subject), refCount());
    let subscription1, subscription2;

    console.log('observerA subscribed');
    subscription1 = refCounted.subscribe({
      next: (v) => console.log(`observerA: ${v}`)
    });

    setTimeout(() => {
      console.log('observerB subscribed');
      subscription2 = refCounted.subscribe({
        next: (v) => console.log(`observerB: ${v}`)
      });
    }, 600);

    setTimeout(() => {
      console.log('observerA unsubscribed');
      subscription1.unsubscribe();
    }, 1200);


    setTimeout(() => {
      console.log('observerB unsubscribed');
      subscription2.unsubscribe();
    }, 2000);
```
输出:
```
observerA subscribed
observerA: 0
observerB subscribed
observerA: 1
observerB: 1
observerA unsubscribed
observerB: 2
observerB: 3
observerB unsubscribed
```


###  BehaviorSubject
BehaviorSubject 有个初始值，subscribe订阅时会把历史最新值发布到流.
```typescript
    const subject = new BehaviorSubject(0);

    subject.subscribe({
      next: (v) => console.log(`observerA: ${v}`)
    });

    subject.next(1);
    subject.next(2);

    subject.subscribe({
      next: (v) => console.log(`observerB: ${v}`)
    });

    subject.next(3);
```
输出：
```
observerA: 0
observerA: 1
observerA: 2
observerB: 2
observerA: 3
observerB: 3
```

### ReplaySubject
ReplaySubject 能把参数设置的历史多少个数据发布给新订阅者
```typescript
    const subject = new ReplaySubject(2);

    subject.subscribe({
      next: (v) => console.log(`observerA: ${v}`)
    });

    subject.next(1);
    subject.next(2);
    subject.next(3);
    subject.next(4);

    subject.subscribe({
      next: (v) => console.log(`observerB: ${v}`)
    });
```
输出:
```
observerA: 1
observerA: 2
observerA: 3
observerA: 4
observerB: 3
observerB: 4
```

### AsyncSubject
AsyncSubject 只在complete()后发出最后一个

```typescript
    const subject = new AsyncSubject();

    subject.subscribe({
      next: (v) => console.log(`observerA: ${v}`)
    });

    subject.next(1);
    subject.next(2);
    subject.next(3);
    subject.next(4);

    subject.subscribe({
      next: (v) => console.log(`observerB: ${v}`)
    });

    subject.next(5);
    subject.complete();
```
输出:
```
observerA: 5
observerB: 5
```

## Scheduler

调度器，可以控制何时发布数据。
- null 默认没有调试同时、递归发布数据
- queueScheduler 队列方式高用
- asapScheduler
- asyncScheduler 异步调用setInterval 
- animationFrameScheduler

示例:
```typescript
    const observable = new Observable((observer) => {
      observer.next(1);
      observer.next(2);
      observer.next(3);
      observer.complete();
    }).pipe(
      observeOn(asyncScheduler)
    );

    console.log('just before subscribe');
    observable.subscribe({
      next(x) {
        console.log('got value ' + x)
      },
      error(err) {
        console.error('something wrong occurred: ' + err);
      },
      complete() {
        console.log('done');
      }
    });
    console.log('just after subscribe');
```

输出:
```
just before subscribe
just after subscribe
got value 1
got value 2
got value 3
done
```




## 参考资源

+ [RxJs-Dev](https://rxjs.dev/guide/)
+ [源码](https://github.com/ReactiveX/rxjs)