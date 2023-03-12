# 寄存器

包含31个通用寄存器(x0-x30), sp, pc, cpsr和xzr

## 通用寄存器

- 通用寄存器x0-x30有64bit, 低位w0-w30有32bit, x0和w0本质是一个寄存器, 用的位数不一样
- 可以用来存放函数参数
- x0一般用来存放返回返回值

## 特殊寄存器

- sp：Stack Pointer, 保存栈顶地址
- fp：Frame Pointer, 保存栈底地址
- lr：Link Register, 跳转指令下一条指令的地址
- pc：下一条指令的地址

## cpsr寄存器(状态寄存器)

- N：Negative Cndition Flag，代表运算结果是负数
- Z：Zero Condition Flag， Z 为 1 代表0，否则Z 为 0 代表 1
- C：Carry Condition Flag, 无符号运算有溢出时C 为 1
- V：Overflow Condition Flag, 有符号运算有溢出时C 为 1

## xzr(零寄存器)

xzr/wzr分别表示64/32位，其做用就是0，写进去表明丢弃结果，读出来是0

# 指令

```js
// R,H W 字节操作配合的是X,W寄存器,会扩展并清零其它位

// mov
MOV     X1, X2              // X1 <- X2
MOV     X1, 0x8             // X1 <- 0x8

// add
ADD     X0, X0, #1          // X0 <- X0 + 1
ADD     X0, X1, X2          // X0 <- X1 + X2
ADD     X0, X1, [X2]        // X0 <- [X1 + [X2]]

// sub
SUB     X0, X1, X2          // X0 <- X1 - X2

// mul
MUL     X0, X1, X2          // X0 <- X1 * X2

// sdiv
SDIV    X0, X1, X2          // X0 <- X1 / X2

// and
AND     X0, X0, #0xf         // X0 <- X0 & 0xf

// orr
ORR     X0, X0, #0xf         // X0 <- X0 | 0xf

// ldr
LDR     R1, [R2]            // R1 <- [R2]
LDR     R1, [R2, R3]        // R1 <- [R2+R3]
LDRB    R1, [R2]            // R1 <- [R2]  8bit
LDRH    R1, [R2]            // R1 <- [R2] 16bit
LDRW    R1, [R2]            // R1 <- [R2] 32bit
LDUR    R1, [R2, #-0x8]     // R1 <- [R2-0x8]  负地址
LDP     R1, R2, [R3]        // R1 <- [R3], R2 <- [R3+0x8]

// str
STR     R0, [R1]            // R0 -> [R1]
STR     R0, [R1, #12]       // R0 -> [R1+12]
STRB    R1, [R2]            // R1 -> [R2]  8bit
STRH    R1, [R2]            // R1 -> [R2] 16bit
STRW    R1, [R2]            // R1 -> [R2] 32bit
STUR    R1, [R2, #-0x8]     // R1 -> [R2-0x8]  负地址
STP     R1, R2, [R3]        // R1 -> [R3], R2 -> [R3+0x8]

// svc
SVC     0                   // 系统调用

// jump
B       LBB0_1              // 跳转无返回
BL      LBB0_1              // 跳转有返回, 先将下一条指令地址保存到lr(X30)中
BR      X0                  // 跳转到寄存器指向地址, 无返回
BLR     X0                  // 跳转到寄存器指向地址, 有返回, 先将下一条指令地址保存到lr(X30)中
RET                         // 返回

// csel
CSEL    X0, X1, X2, COND    // X0 = COND ? X1 : X2
                            // COND: EQ	等于
                            // NE	不等于
                            // CS	无符号数大于/等于
                            // HS	无符号数大于/等于
                            // CC	无符号数小于
                            // LO	无符号数小于
                            // MI	负数
                            // PL	非负数
                            // VS	上溢出
                            // VC	没有上溢出
                            // HI	无符号数大于
                            // LS	无符号数小于/等于
                            // GE	大于等于
                            // LT	小于
                            // GT	大于
                            // LE	小于等于
                            // AL	无条件执行

```