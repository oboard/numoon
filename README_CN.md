# oboard/numoon

## 📖目录

- [介绍](#-介绍)
- [开始使用](#-开始使用)
- [贡献](#-贡献)
- [许可证](#-许可证)

## ✨介绍

**Numoon** 是一个开源的 MoonBit 数组库，它提供对多维数组对象的支持以及用于高效操作这些数组的函数。

<!-- Numoon 的核心是其 N 维数组对象 NMArray，它与基本的 MoonBit 列表非常相似，但可以存储任何数据类型并执行向量化的数学运算。这使得 Numoon 非常适合数值计算。 -->

以下是 Numoon 的一些关键特性：

1. 多维数组对象：Numoon 提供了一个强大的 N 维数组 NMArray，这是科学计算的基础。

2. 派生对象（如掩码数组和矩阵）：Numoon 允许用户创建特殊数组，例如掩码数组，用于处理缺失或无效的数据。

3. 广泛的数学函数库：Numoon 拥有大量的数学函数，包括线性代数、傅里叶变换和随机数生成。
<!-- 
4. 向量化操作：Numoon 的数组操作是向量化的，这意味着你可以在不显式使用循环的情况下对数组执行操作。

5. 支持各种数据类型：Numoon 支持广泛的数据类型，包括整数、浮点数、复数等。

6. 操作广播：Numoon 提供了一个强大的机制，允许不同大小的数组之间进行算术运算。

7. 内存效率：Numoon 数组比原生 MoonBit 数据结构存储数据更有效。

8. 工具集成：Numoon 是许多其他科学计算库的基础，如 SciMoon、Moondas 和 MoonPlotlib。 -->

Numoon 是 MoonBit 中科学计算和数据分析的不可或缺的工具，在物理学、生物学、工程学等领域广泛使用。

## 🚀开始使用

要开始使用 Numoon，你只需使用以下命令安装即可：

```bash
moon install oboard/numoon
```

这将安装最新版本的 Numoon 及其依赖项。

要在你的 MoonBit 程序中使用 Numoon，只需使用以下代码导入库：

你可以使用以下代码创建一个 NMArray 对象：

### 创建数组

```moonbit
a = @nm.int_array([1, 2, 3])
b = @nm.int_array([1, 2, 3])
println(a + b) 
// 输出：[2, 4, 6]
```

这创建了一个一维整数数组并执行了向量加法。

```moonbit
a = @nm.double_array([1.0, 2.0, 3.0])
```

### 随机数生成

```moonbit
let list1 = @nm.rand(2, 3)
println(list1)
// 输出：[[0.2893123275883688, 0.33959090191249325, 0.1521095035725017],
//  [0.9314055834969763, 0.8561914513327412, 0.7919828439328577]]
```

### 矩阵

```moonbit
let list1 = @nm.int_matrix([[1, 2, 3], [4, 5, 6]])
```

#### 矩阵操作
```moonbit
let m2 = @nm.int_matrix([[1, 2, 3], [4, 5, 6]])
let m1 = @nm.int_matrix([[7, 8], [9, 10], [11, 12]])

let result = @nm.dot(m1, m2)
println(result)

// 输出：[[121.0 136.0 151.0]
//  [153.0 172.0 191.0]
//  [185.0 208.0 231.0]]
```

## 🤝贡献

欢迎参与贡献，共建美好 MoonBit 社区！
[贡献指南](CONTRIBUTING.md)

## 👨‍💻作者
- @oboard
- @Yorkin

## 📝许可证

本项目根据 MIT 许可证授权 - 详情请参阅 [LICENSE.md](LICENSE.md) 文件。