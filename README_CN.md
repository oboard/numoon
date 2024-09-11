# oboard/numoon

## 📖 目录

- [介绍](#-介绍)
- [开始使用](#-开始使用)
- [贡献](#-贡献)
- [许可证](#-许可证)

## ✨ 介绍

**Numoon** 是一个开源的 MoonBit 库，它为多维数组对象提供支持，并为高效操作这些数组提供函数。

这里是 Numoon 的一些关键特性：

1. 多维数组对象：Numoon 提供了强大的 N 维数组 NMArray，这是科学计算的基础。

2. 派生对象（如掩码数组和矩阵）：Numoon 允许用户创建特殊数组，比如掩码数组，用于处理缺失或无效数据。

3. 广泛的数学函数库：Numoon 拥有大量的数学函数，包括线性代数、傅里叶变换和随机数生成。
   <!--
   4. 向量化操作：Numoon 的数组操作是向量化的，这意味着你可以在不使用显式循环的情况下对数组执行操作。

   5. 支持多种数据类型：Numoon 支持广泛的数据类型，包括整数、浮点数、复数等。

   6. 操作广播：Numoon 提供了一个强大的机制，允许不同大小的数组之间进行算术操作。

   7. 内存效率：Numoon 数组比原生 MoonBit 数据结构更有效地存储数据。

   8. 工具集成：Numoon 是许多其他科学计算库的基础，如 SciMoon、Moondas 和 MoonPlotlib。
   -->

Numoon 是 MoonBit 中科学计算和数据分析不可或缺的工具，在物理、生物、工程等领域广泛使用。

## 🚀 开始使用

要开始使用 Numoon，你可以简单地使用以下命令安装它：

```bash
moon add oboard/numoon
```

这将安装 Numoon 的最新版本及其依赖项。

要在 MoonBit 程序中使用 Numoon，只需使用以下代码导入库：

你可以使用以下代码创建一个 NMArray 对象：

### 创建数组

```moonbit
a = @nm.array([1, 2, 3])
b = @nm.array([1, 2, 3])
println(a + b)
// 输出: [2, 4, 6]
```

# 数组操作

```moonbit
a = @nm.array([1, 2, 3])
println(a.sum())
println(a.prod())
// 输出: 6 6
```

### 重塑

```moonbit
let a = @nm.array([[1, 2, 3], [4, 5, 6]])
println(a.reshape(3, 2))
// 输出: [[1, 2], [3, 4], [5, 6]]
```

### 随机数生成

```moonbit
let list1 = @nm.rand(6)
println(list1)
// 输出: [[0.2893123275883688, 0.33959090191249325, 0.1521095035725017],
//  0.9314055834969763, 0.8561914513327412, 0.7919828439328577]
```

### 矩阵

```moonbit
let list1 = @nm.array([[1, 2, 3], [4, 5, 6]])
```

#### 矩阵操作

```moonbit
let m2 = @nm.array([[1, 2, 3], [4, 5, 6]])
let m1 = @nm.array([[7, 8], [9, 10], [11, 12]])

let result = @nm.dot(m1, m2)
println(result)

// 输出: [[121.0 136.0 151.0]
//  [153.0 172.0 191.0]
//  [185.0 208.0 231.0]]
```

#### 矩阵转置

```moonbit
let a = @nm.array([[1, 2], [3, 4]])

println(a.transpose())

// 输出: [[1 3]
//  [2 4]]
```

### linspace

start: 序列的起始值。

stop: 序列的结束值。

~num: 要生成的样本数，包括起始和结束值。默认值为 50。

```moonbit
let a = @nm.linspace(0.0, 10.0, num=11)
println(a)

// 输出: [0.0, 1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0]
```

## 🤝 贡献

我们欢迎对 Numoon 的贡献！请阅读我们的 [贡献指南](CONTRIBUTING.md) 以了解更多。

## 👨‍💻 作者

- @oboard
- @Yorkin

## 📝 许可证

本项目采用 MIT 许可证 - 详情请参阅 [LICENSE.md](LICENSE.md) 文件。
