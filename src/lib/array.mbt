pub fn length(self : L) -> Int {
  let mut count = 0
  self.shape.each(fn(x) { count *= x })
  count
}

pub struct L {
  mut value : Array[NMNum]
  mut shape : Array[Int]
} derive(Eq)

pub fn output(self : L, logger : Logger) -> Unit {
  logger.write_string(self.to_string())
}

pub fn to_string(self : L) -> String {
  // 根据 shape 生成 Json Array
  let { value, shape } = self
  fn buildArray(val : Array[NMNum], shape : Array[Int]) -> Json {
    if shape.length() == 1 {
      // 如果只有一个维度，直接返回数组的一部分
      return Array(val.map(to_double).map(Json::Number))
    }
    // 初始化结果数组
    let result = []
    let mut index = 0

    // 计算每个子数组的长度
    let subArrayLength = shape[1]
    let totalLength = prod(int_array(shape)).to_int()
    // 确保值的数量与形状匹配
    if val.length() != totalLength {
      println(
        "Error: The total length of shape does not match the length of values.",
      )
      panic()
    }
    // 递归构建多维数组
    for i = 0; i < shape[0]; i = i + 1 {
      result.push(
        buildArray(
          val[index:index + subArrayLength].iter().to_array(),
          shape[1:].iter().to_array(),
        ),
      )
      index += subArrayLength
    }
    Array(result)
  }

  buildArray(value, shape).stringify()
  }

pub fn array(json : Json) -> L {
  L::from(json)
}

pub fn int_array(arr : Array[Int]) -> L {
  { value: arr.map(NMNum::NMInt), shape: [arr.length()] }
}

pub fn L::from(json : Json) -> L {
  match json {
    Json::Array(_) => {
      let value = []
      let shape = []
      fn append(level : Int, data : Json) {
        if shape.length() < level {
          shape.push(0)
        }
        match data {
          Json::Array(array) => {
            for i = 0; i < array.length(); i = i + 1 {
              append(level + 1, array[i])
            }
            if shape[level] < array.length() {
              shape[level] = array.length()
            }
          }
          Number(number) => value.push(NMDouble(number))
          String(string) => value.push(NMString(string))
          True => value.push(NMInt(1))
          False => value.push(NMInt(0))
          Null => value.push(NMInt(0))
          Object(obj) => obj.values().each(fn(value) { append(level, value) })
        }
      }

      append(0, json)
      { value, shape }
    }
    _ => { value: [], shape: [0, 0] }
  }
}

pub fn L::from_array(array : Array[Double]) -> L {
  { value: array.map(NMNum::NMDouble), shape: [array.length(), 1] }
}

pub fn L::to_array(self : L) -> Array[Double] {
  self.value.map(fn(x) { x.to_double() })
}

// pub fn NMList::from_array(array : Array[Double]) -> NMList[NMNum] {
//   { value: array.map(NMNum::from_double).to_list() }
// }
pub fn reshape(self : L, shape : Array[Int]) -> L {
  { value: self.value, shape }
}

pub fn sum(self : L) -> NMNum {
  let mut sum = 0.0
  for i = 0; i < self.value.length(); i = i + 1 {
    sum = sum + self.value[i].to_double()
  }
  NMDouble(sum)
}

pub fn prod(self : L) -> NMNum {
  let mut prod = 1.0
  for i = 0; i < self.value.length(); i = i + 1 {
    prod = prod * self.value[i].to_double()
  }
  NMDouble(prod)
}

pub fn op_add(self : L, other : L) -> L {
  // [1, 2, 3] + [4, 5, 6] => [5, 7, 9]
  let selfArray = self.value
  let otherArray = other.value
  let resultArray = selfArray.mapi(fn(i, x) { x + otherArray[i] })
  { value: resultArray, shape: self.shape }
}

pub fn op_sub(self : L, other : L) -> L {
  // [1, 2, 3] - [4, 5, 6] => [-3, -3, -3]
  let selfArray = self.value
  let otherArray = other.value
  let resultArray = selfArray.mapi(fn(i, x) { x - otherArray[i] })
  { value: resultArray, shape: self.shape }
}

pub fn op_mul(self : L, other : L) -> L {
  // [1, 2, 3] * [4, 5, 6] => [4, 10, 18]
  let selfArray = self.value
  let otherArray = other.value
  let resultArray = selfArray.mapi(fn(i, x) { x * otherArray[i] })
  { value: resultArray, shape: self.shape }
}

pub fn op_div(self : L, other : L) -> L {
  // [1, 2, 3] / [4, 5, 6] => [0.25, 0.4, 0.5]
  let selfArray = self.value
  let otherArray = other.value
  let resultArray = selfArray.mapi(fn(i, x) { x / otherArray[i] })
  { value: resultArray, shape: self.shape }
}

pub fn op_eq(self : L, other : L) -> Bool {
  // [1, 2, 3] == [1, 2, 3] => true
  // [1, 2, 3] == [1, 2, 4] => false
  self.value == other.value
}

test {
  let a = array([[1, 2], [2, 3], [3, 4]])
  inspect!(a, content="[[1,2],[2,3],[3,4]]")
  inspect!(a.shape, content="[3, 2]")
}
