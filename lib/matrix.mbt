fn multiplyMatrices(
  a : Array[Double],
  b : Array[Double],
  m : Int,
  n : Int,
  p : Int
) -> Array[Double] {
  let c = Array::make(m * p, 0.0)
  for i = 0; i < m; i = i + 1 {
    for j = 0; j < p; j = j + 1 {
      c[i * n + j] = 0.0
      for k = 0; k < n; k = k + 1 {
        c[i * n + j] += a[i * n + k] * b[k * n + j]
      }
    }
  }
  c
}

pub fn dot(a : L, b : L) -> L {
  if a.shape.cols != b.shape.rows {
    abort("Matrix dimensions do not match for dot product")
  }
  let m = a.shape.rows
  let n = a.shape.cols
  let p = b.shape.cols
  let c = multiplyMatrices(
    a.value.to_array().map(to_double),
    a.value.to_array().map(to_double),
    m,
    n,
    p,
  )
  let cL = from_array(c);
  cL.shape = { rows: m, cols: p }
  cL
}
