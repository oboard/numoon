/// Performs matrix multiplication between two matrices. The function multiplies
/// the matrix `self` by the matrix `other` and returns the resulting matrix.
///
/// # Parameters
///
/// - `self` : The first matrix to be multiplied. It must be a 2-dimensional
/// matrix.
/// - `other` : The second matrix to be multiplied. It must be a 2-dimensional
/// matrix and have the same number of rows as the number of columns in `self`.
///
/// # Returns
///
/// - A new matrix that is the result of multiplying `self` by `other`. The
/// resulting matrix will have dimensions `[m, p]`, where `m` is the number of
/// rows in `self` and `p` is the number of columns in `other`.
///
/// # Errors
///
/// - The function will abort with an error message if the dimensions of the
/// matrices do not match for multiplication. Specifically, it checks:
///  - Both `self` and `other` must be 2-dimensional matrices.
///  - The number of columns in `self` must be equal to the number of rows in
/// `other`.
pub fn L::matmul(self : L, other : L) -> L {
  let a = self.value
  let b = other.value
  let m = self.shape[0]
  let n = self.shape[1]
  let p = other.shape[1]
  if self.shape.length() != 2 ||
    other.shape.length() != 2 ||
    n != other.shape[0] {
    abort("Matrix dimensions do not match for dot product")
  }
  let res = Array::make(m * p, NMDouble(0.0))
  for i = 0; i < m; i = i + 1 {
    for j = 0; j < p; j = j + 1 {
        for k = 0; k < n; k = k + 1 {
            res[i * p + j] += a[i * n + k] * b[k * p + j]
        }
    }
}
  { value: res, shape: [m, p] }
}

test "Matrix multiplication example" {

  // matrix multiplication
  fn matrix_multiplication() {
    let matrix1 = array([[1, 2, 3], [4, 5, 6]])
    let matrix2 = array([[7, 8], [9, 10], [11, 12]])
    // or matrix1.matmul(matrix2)
    matmul(matrix1, matrix2)
  }

  inspect!(matrix_multiplication(), content="[[58,64],[139,154]]")
}

pub fn L::transpose(self : L) -> L {
  let m = self.shape[0]
  let n = self.shape[1]
  let b = Array::make(n * m, 0.0)
  let arr = self.value
  for i = 0; i < m; i = i + 1 {
    for j = 0; j < n; j = j + 1 {
      let x = j * m + i
      let y = i * n + j
      b[x] = arr[y].to_double()
    }
  }
  let cL = from_array(b)
  cL.shape = [n, m]
  cL
}

test "transpose example" {
  let matrix = array([1.0, 2.0, 3.0, 4.0]).reshape([2, 2])
  let transposed = matrix.transpose()
  inspect!(transposed, content="[[1,3],[2,4]]")
  inspect!(transposed.shape, content="[2, 2]")
}