///|
pub fn L::length(self : L) -> Int {
  match self.shape.length() {
    0 => 0
    1 => self.shape[0]
    _ => self.shape.fold(init=1, fn(acc, x) { acc * x })
  }
}

///|
pub struct L {
  value : Array[NMNum]
  mut shape : Array[Int]
} derive(Show)

///|
#alias("_[_]")
pub fn L::get(self : L, index : Int) -> NMNum {
  self.value[index]
}

///|
#alias("_[_]=_")
pub fn L::set(self : L, index : Int, value : NMNum) -> L {
  self.value[index] = value
  self
}

///|
#alias("_[_:_]")
pub fn L::as_view(self : L, start~ : Int, end? : Int) -> L {
  let value = self.value
  let start = start
  let end = end.unwrap_or(value.length())
  { value: value[start:end].iter().to_array(), shape: [value.length()] }
}

///|
pub fn L::to_json(self : L) -> Json {
  let { value, shape } = self
  fn buildArray(val : Array[NMNum], shape : Array[Int]) -> Json {
    if shape.length() == 1 {
      // 如果只有一个维度，直接返回数组的一部分
      return val.map(x => x.to_double()).map(x => x.to_json()).to_json()
    }
    // 初始化结果数组
    let result = []
    let mut index = 0

    // 计算每个子数组的长度
    let subArrayLength = shape[1]
    let totalLength = int_array(shape).prod().to_int()
    // 确保值的数量与形状匹配
    if val.length() != totalLength {
      abort("The total length of shape does not match the length of values.")
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
    result.to_json()
  }

  buildArray(value, shape)
}

///|
pub impl Show for L with to_string(self : L) -> String {
  self.to_json().stringify()
}

///|
pub fn array(json : Json) -> L {
  L::from(json)
}

///|
pub fn int_array(arr : Array[Int]) -> L {
  { value: arr.map(x => NMNum::NMInt(x)), shape: [arr.length()] }
}

///|
pub fn double_array(arr : Array[Double]) -> L {
  { value: arr.map(x => NMNum::NMDouble(x)), shape: [arr.length(), 1] }
}

///|
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
          Number(number, ..) => value.push(NMDouble(number))
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

///|
pub fn L::from_array(array : Array[Double]) -> L {
  { value: array.map(x => NMNum::NMDouble(x)), shape: [array.length(), 1] }
}

///|
pub fn L::to_array(self : L) -> Array[Double] {
  self.value.map(x => x.to_double())
}

// pub fn NMList::from_array(array : Array[Double]) -> NMList[NMNum] {
//   { value: array.map(NMNum::from_double).to_list() }
// }

///|
pub fn L::reshape(self : L, shape : Array[Int]) -> L {
  { value: self.value, shape }
}

///|
pub fn L::sum(self : L) -> NMNum {
  let mut sum = 0.0
  for i = 0; i < self.value.length(); i = i + 1 {
    sum = sum + self.value[i].to_double()
  }
  NMDouble(sum)
}

///|
pub fn L::prod(self : L) -> NMNum {
  let mut prod = 1.0
  for i = 0; i < self.value.length(); i = i + 1 {
    prod = prod * self.value[i].to_double()
  }
  NMDouble(prod)
}

///|
pub impl Add for L with add(self : L, other : L) -> L {
  // [1, 2, 3] + [4, 5, 6] => [5, 7, 9]
  let selfArray = self.value
  let otherArray = other.value
  let resultArray = selfArray.mapi(fn(i, x) { x + otherArray[i] })
  { value: resultArray, shape: self.shape }
}

///|
pub impl Sub for L with sub(self : L, other : L) -> L {
  // [1, 2, 3] - [4, 5, 6] => [-3, -3, -3]
  let selfArray = self.value
  let otherArray = other.value
  let resultArray = selfArray.mapi(fn(i, x) { x - otherArray[i] })
  { value: resultArray, shape: self.shape }
}

///|
pub impl Mul for L with mul(self : L, other : L) -> L {
  // [1, 2, 3] * [4, 5, 6] => [4, 10, 18]
  let selfArray = self.value
  let otherArray = other.value
  let resultArray = selfArray.mapi(fn(i, x) { x * otherArray[i] })
  { value: resultArray, shape: self.shape }
}

///|
pub impl Div for L with div(self : L, other : L) -> L {
  // [1, 2, 3] / [4, 5, 6] => [0.25, 0.4, 0.5]
  let selfArray = self.value
  let otherArray = other.value
  let resultArray = selfArray.mapi(fn(i, x) { x / otherArray[i] })
  { value: resultArray, shape: self.shape }
}

///|
pub impl Eq for L with equal(self : L, other : L) -> Bool {
  // [1, 2, 3] == [1, 2, 3] => true
  // [1, 2, 3] == [1, 2, 4] => false
  self.value == other.value
}

///|
test {
  let a = array([[1, 2], [2, 3], [3, 4]])
  inspect(a, content="[[1,2],[2,3],[3,4]]")
  inspect(a.shape, content="[3, 2]")
}
