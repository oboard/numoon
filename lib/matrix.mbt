fn multiplyMatrices(
  a : Array[Double],
  b : Array[Double],
  m : Int,
  n : Int,
  p : Int
) -> Array[Double] {
  let c = Array::make(m * p, 0.0)
  // for(int i = 0;i<e.getrow();++i)
  //   {
  //       for(int j = 0;j<f.getcol();++j)
  //       {
  //            ret[i][j] = 0;
  //            for(int k = 0;k<e.getcol();++k)
  //            {
  //               ret[i][j]+= e[i][k]*f[k][j];
  //            }                
  //       }
  //   }
  for i = 0; i < m; i = i + 1 {
    for j = 0; j < p; j = j + 1 {
      let x = i * p + j
      // println("i: \(i), j: \(j), x: \(x)")
      c[x] = 0.0
      for k = 0; k < n; k = k + 1 {
        let y = k * n + j
        let z = i * n + k
        // println("i: \(i), j: \(j), k: \(k), x: \(x), y: \(y), z: \(z)")
        // let aa = a[y]
        // let bb = b[z]
        // let cc = aa * bb
        // println("\(aa) * \(bb) = \(cc)")
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
  let c = multiplyMatrices(
    a.value.to_array().map(to_double),
    a.value.to_array().map(to_double),
    m,
    n,
    p,
  )
  let cL = from_array(c)
  cL.shape = { rows: m, cols: p }
  cL
}
