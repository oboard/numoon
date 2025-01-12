// add
test "add" {
  fn add() {
    let list1 = @nm.array([1.0, 2, 3])
    let list2 = @nm.array([2, 2, 2])
    list1 + list2
  }

  inspect!(add(), content="[3,4,5]")
}

test "add number" {
  fn add() {
    let num1 = @nm.from_int(1)
    let num2 = @nm.from_double(1.1)
    num1 + num2
  }

  inspect!(add(), content="2.1")
}

// sum
test "sum" {
  fn sum() {
    @nm.array([1, 2, 3, 4, 5, 6]).sum()
  }

  inspect!(sum(), content="21")
}

test "sum2" {
  fn sum() {
    @nm.array([1, 1.1]).sum()
  }

  inspect!(sum(), content="2.1")
}

// prod
test "prod" {
  fn prod() {
    @nm.array([1, 2, 3, 4, 5, 6]).prod()
  }

  inspect!(prod(), content="720")
}

// reshape1
test "reshape1" {
  fn reshape1() {
    @nm.array([1, 2, 3, 4, 5, 6]).reshape([2, 3])
  }

  inspect!(reshape1(), content="[[1,2,3],[4,5,6]]")
}

// reshape2
test "reshape2" {
  fn reshape2() {
    @nm.array([[1, 2, 3], [4, 5, 6]]).reshape([3, 2])
  }

  inspect!(reshape2(), content="[[1,2],[3,4],[5,6]]")
}

// matrix_multiplication
test "matrix_multiplication" {
  fn matrix_multiplication() {
    let matrix1 = @nm.array([[1, 2, 3], [4, 5, 6]])
    let matrix2 = @nm.array([[7, 8], [9, 10], [11, 12]])
    @nm.matmul(matrix1, matrix2)
  }

  inspect!(matrix_multiplication(), content="[[58,64],[139,154]]")
}

// transpose
test "transpose" {
  fn transpose() {
    let matrix = @nm.array([[1, 2, 3], [4, 5, 6]])
    matrix.transpose()
  }

  inspect!(transpose(), content="[[1,4],[2,5],[3,6]]")
}

// convolve
test "convolve" {
  fn convolve() {
    let a = @nm.array([[1, 2], [3, 4]])
    let b = @nm.array([5, 6])
    a.convolve(b)
  }

  inspect!(convolve(), content="[5,16,27,38,24]")
}

// zeros
test "zeros" {
  let matrix1 = @nm.zeros(9).reshape([3, 3])
  inspect!(matrix1, content="[[0,0,0],[0,0,0],[0,0,0]]")
}

// ones
test "ones" {
  let matrix2 = @nm.ones(6).reshape([2, 3])
  inspect!(matrix2, content="[[1,1,1],[1,1,1]]")
}

// arange
test "arange" {
  let rows = @nm.arange(end=5)
  inspect!(rows, content="[0,1,2,3,4]")
  let cols = @nm.arange(start=1, end=5, step=0.5)
  inspect!(cols, content="[1,1.5,2,2.5,3,3.5,4,4.5]")
}

// pi
test "pi" {
  inspect!(@nm.pi, content="3.141592653589793")
}

// trigonometric functions
test "trigonometric_functions" {
  inspect!(@nm.math_sinc(1.0), content="3.8982468850708534e-17")
  inspect!(@nm.math_sinh(1.0), content="1.1752011936438014")
  inspect!(@nm.math_cosh(1.0), content="1.5430806348152437")
  inspect!(@nm.math_tanh(1.0), content="0.7615941559557649")
  inspect!(@nm.math_arcsinh(1.0), content="1.4142135623730951")
  inspect!(@nm.math_arccosh(1.0), content="0")
  inspect!(@nm.math_arctanh(0.5), content="0.5493061443340548")
  inspect!(@nm.math_arctan2(1.0, 1.0), content="0.7853981633974483")
  inspect!(@nm.math_degrees(@nm.pi), content="180")
  inspect!(@nm.math_radians(180.0), content="3.141592653589793")
  inspect!(@nm.math_pow(2.0, 3.0), content="8")
}

test "functions on arrays" {
  inspect!(
    @nm.array([0.1, 0.2, 0.3])
    .sin()
    .cos()
    .arccos()
    .arcsin()
    .multiply(10)
    .round()
    .divide(10),
    content="[0.1,0.2,0.3]",
  )
}

test "slice" {
  let arr = @nm.array([1, 2, 3, 4, 5])
  inspect!(arr[2:4], content="[3,4]")
}
