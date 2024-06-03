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
      let x = i * p + j
      c[x] = 0.0
      for k = 0; k < n; k = k + 1 {
        let y = k * n + j
        let z = i * n + k
        c[x] += a[y] * b[z]
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
  let arr = a.value;
  let c = multiplyMatrices(
    arr.map(to_double),
    arr.map(to_double),
    m,
    n,
    p,
  )
  let cL = from_array(c)
  cL.shape = { rows: m, cols: p }
  cL
}

pub fn L::transpose(a : L) -> L {
  let m = a.shape.rows
  let n = a.shape.cols
  let b = Array::make(n * m, 0.0)
  let arr = a.value;
  for i = 0; i < m; i = i + 1 {
    for j = 0; j < n; j = j + 1 {
      let x = j * m + i
      let y = i * n + j
      b[x] = arr[y].to_double()
    }
  }
  let cL = from_array(b)
  cL.shape = { rows: n, cols: m }
  cL
}
