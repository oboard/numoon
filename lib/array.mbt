pub struct NMShape {
  mut rows : Int
  mut cols : Int
} derive(Show, Debug, Eq)

pub fn length(self : NMShape) -> Int {
  self.rows * self.cols
}

pub struct L {
  mut value : Array[NMNum]
  mut shape : NMShape
} derive(Debug, Eq)

pub fn output(self : L, logger : Logger) -> Unit {
  logger.write_string(self.to_string())
}

pub fn to_string(self : L) -> String {
  let mut result = "["
  let arr = self.value
  let x2 = self.shape.rows > 0 && self.shape.cols > 0
  for i = 0
      i < match x2 {
       false => 1
       true => self.shape.cols
     }
      i = i + 1 {
    if x2 {
      result = result + "["
    }
    for j = 0; j < self.shape.rows; j = j + 1 {
      result = result + arr[i * self.shape.rows + j].to_string()
      if j < self.shape.rows - 1 {
        result = result + " "
      }
    }
    if x2 {
      result = result + "]"
    }
    if i < self.shape.cols - 1 {
      result = result + "\n "
    }
  }
  result = result + "]"
  result
}

pub fn L::from_array(array : Array[Double]) -> L {
  { value: array.map(to_NMDouble), shape: { rows: array.length(), cols: 0 } }
}

pub fn L::to_array(self : L) -> Array[Double] {
  self.value.map(fn(x) { x.to_double() })
}

// pub fn NMList::from_array(array : Array[Double]) -> NMList[NMNum] {
//   { value: array.map(NMNum::from_double).to_list() }
// }

pub fn int_matrix(matrix : Array[Array[Int]]) -> L {
  let rows = matrix.length()
  let cols = matrix[0].length()
  let value = Array::make(rows * cols, to_NMInt(0))
  for i = 0; i < rows; i = i + 1 {
    for j = 0; j < cols; j = j + 1 {
      value[i * cols + j] = to_NMInt(matrix[i][j])
    }
  }
  { value, shape: { rows, cols } }
}

pub fn double_matrix(matrix : Array[Array[Double]]) -> L {
  let rows = matrix.length()
  let cols = matrix[0].length()
  let value = Array::make(rows * cols, to_NMDouble(0.0))
  for i = 0; i < rows; i = i + 1 {
    for j = 0; j < cols; j = j + 1 {
      value[i * cols + j] = to_NMDouble(matrix[i][j])
    }
  }
  { value, shape: { rows, cols } }
}

pub fn int_arr(array : Array[Int]) -> L {
  { value: array.map(to_NMInt), shape: { rows: array.length(), cols: 0 } }
}

pub fn double_arr(array : Array[Double]) -> L {
  { value: array.map(to_NMDouble), shape: { rows: array.length(), cols: 0 } }
}

pub fn array(array : Array[NMNum]) -> L {
  { value: array, shape: { rows: array.length(), cols: 0 } }
}

pub fn reshape(self : L, rows : Int, cols : Int) -> L {
  { value: self.value, shape: { rows, cols } }
}

pub fn sum(self : L) -> NMNum {
  let mut sum = 0.0
  for i = 0; i < self.value.length(); i = i + 1 {
    sum = sum + self.value[i].to_double()
  }
  to_NMDouble(sum)
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
