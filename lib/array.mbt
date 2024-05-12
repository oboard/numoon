pub struct NMShape {
  mut rows : Int
  mut cols : Int
} derive(Show, Debug, Eq)

pub fn length(self : NMShape) -> Int {
  self.rows * self.cols
}

pub struct L {
  mut value : List[NMNum]
  mut shape : NMShape
} derive(Debug, Eq)

pub fn to_string(self : L) -> String {
  let mut result = "["
  let arr = self.value.to_array()
  for i = 0; i < self.shape.rows; i = i + 1 {
    if self.shape.cols > 1 {
      result = result + "["
    }
    for j = 0; j < self.shape.cols; j = j + 1 {
      result = result + arr[i * self.shape.cols + j].to_string()
      if j < self.shape.cols - 1 {
        result = result + ", "
      }
    }
    if self.shape.cols > 1 {
      result = result + "]"
    }
    if i < self.shape.rows - 1 {
      result = result + ",\n "
    }
  }
  result = result + "]"
  result
}

pub fn L::from_array(array : Array[Double]) -> L {
  {
    value: array.map(to_NMDouble).to_list(),
    shape: { rows: array.length(), cols: 1 },
  }
}

// pub fn NMList::from_array(array : Array[Double]) -> NMList[NMNum] {
//   { value: array.map(NMNum::from_double).to_list() }
// }

pub fn int_arr(array : Array[Int]) -> L {
  {
    value: array.map(to_NMInt).to_list(),
    shape: { rows: array.length(), cols: 1 },
  }
}

pub fn double_arr(array : Array[Double]) -> L {
  {
    value: array.map(to_NMDouble).to_list(),
    shape: { rows: array.length(), cols: 1 },
  }
}

pub fn int_list(list : List[Int]) -> L {
  { value: list.map(to_NMInt), shape: { rows: list.length(), cols: 1 } }
}

pub fn double_list(list : List[Double]) -> L {
  { value: list.map(to_NMDouble), shape: { rows: list.length(), cols: 1 } }
}

pub fn array(array : Array[NMNum]) -> L {
  { value: array.to_list(), shape: { rows: array.length(), cols: 1 } }
}

pub fn list(list : List[NMNum]) -> L {
  { value: list, shape: { rows: list.length(), cols: 1 } }
}

pub fn reshape(self : L, rows : Int, cols : Int) -> Unit {
  self.shape = { rows, cols }
}

pub fn sum(self : L) -> NMNum {
  loop self.value, NMNum::from_int(0) {
    Nil, acc => acc
    Cons(x, rest), acc => continue rest, x + acc
  }
}

pub fn op_add(self : L, other : L) -> L {
  // [1, 2, 3] + [4, 5, 6] => [5, 7, 9]
  let selfArray = self.value.to_array()
  let otherArray = other.value.to_array()
  let resultArray = selfArray.mapi(fn(i, x) { x + otherArray[i] })
  { value: resultArray.to_list(), shape: self.shape }
}

pub fn op_sub(self : L, other : L) -> L {
  // [1, 2, 3] - [4, 5, 6] => [-3, -3, -3]
  let selfArray = self.value.to_array()
  let otherArray = other.value.to_array()
  let resultArray = selfArray.mapi(fn(i, x) { x - otherArray[i] })
  { value: resultArray.to_list(), shape: self.shape }
}

pub fn op_mul(self : L, other : L) -> L {
  // [1, 2, 3] * [4, 5, 6] => [4, 10, 18]
  let selfArray = self.value.to_array()
  let otherArray = other.value.to_array()
  let resultArray = selfArray.mapi(fn(i, x) { x * otherArray[i] })
  { value: resultArray.to_list(), shape: self.shape }
}

pub fn op_div(self : L, other : L) -> L {
  // [1, 2, 3] / [4, 5, 6] => [0.25, 0.4, 0.5]
  let selfArray = self.value.to_array()
  let otherArray = other.value.to_array()
  let resultArray = selfArray.mapi(fn(i, x) { x / otherArray[i] })
  { value: resultArray.to_list(), shape: self.shape }
}

pub fn op_eq(self : L, other : L) -> Bool {
  // [1, 2, 3] == [1, 2, 3] => true
  // [1, 2, 3] == [1, 2, 4] => false
  self.value == other.value
}
