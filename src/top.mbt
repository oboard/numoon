// fn random() -> @nm.L {
//   @nm.rand(6)
// }

test {
  // add
  fn add() {
    let list1 = @nm.array([1.0, 2, 3])
    let list2 = @nm.array([2, 2, 2])
    list1 + list2
  }

  inspect!(add(), content="[3,4,5]")

  // sum
  fn sum() {
    @nm.array([1, 2, 3, 4, 5, 6]).sum()
  }

  inspect!(sum(), content="21")

  // prod
  fn prod() {
    @nm.array([1, 2, 3, 4, 5, 6]).prod()
  }

  inspect!(prod(), content="720")

  // reshape
  fn reshape1() {
    @nm.array([1, 2, 3, 4, 5, 6]).reshape([2, 3])
  }

  inspect!(reshape1(), content="[[1,2,3],[4,5,6]]")
  fn reshape2() {
    @nm.array([[1, 2, 3], [4, 5, 6]]).reshape([3, 2])
  }

  inspect!(reshape2(), content="[[1,2],[3,4],[5,6]]")

  // matrix
  fn matrix() {
    let a = @nm.array([[1, 2], [3, 4]])
    let b = @nm.array([[5, 6], [7, 8]])
    [
      ("add", a + b),
      ("reshape", a.reshape([1, 4])),
      ("matrix", @nm.array([[1, 2], [3, 4]])),
      ("dot", @nm.dot(a, b)),
      ("transpose", a.transpose()),
    ]
  }

  inspect!(
    matrix(),
    content=
      #|[("add", [[6,8],[10,12]]), ("reshape", [[1,2,3,4]]), ("matrix", [[1,2],[3,4]]), ("dot", [[7,10],[15,22]]), ("transpose", [[1,3],[2,4]])]
    ,
  )

  // zeros, ones
  let matrix1 = @nm.zeros(9).reshape([3, 3])
  inspect!(matrix1, content="[[0,0,0],[0,0,0],[0,0,0]]")
  let matrix2 = @nm.ones(6).reshape([2, 3])
  inspect!(matrix2, content="[[1,1,1],[1,1,1]]")

  // arange
  let rows = @nm.arange(end=5)
  inspect!(rows, content="[0,1,2,3,4]")
  let cols = @nm.arange(start=1, end=5, step=0.5)
  inspect!(cols, content="[1,1.5,2,2.5,3,3.5,4,4.5]")

  // pi
  inspect!(@nm.pi, content="3.141592653589793")

  // trigonometric functions
  inspect!(@nm.sinc(1.0), content="3.8982468850708534e-17")
  inspect!(@nm.sinh(1.0), content="1.1752011936438014")
  inspect!(@nm.cosh(1.0), content="1.5430806348152437")
  inspect!(@nm.tanh(1.0), content="0.7615941559557649")
  inspect!(@nm.arcsinh(1.0), content="1.4142135623730951")
  inspect!(@nm.arccosh(1.0), content="0")
  inspect!(@nm.arctanh(0.5), content="0.5493061443340548")
  inspect!(@nm.arctan2(1.0, 1.0), content="0.7853981633974483")
  inspect!(@nm.degrees(pi), content="180")
  inspect!(@nm.radians(180.0), content="3.141592653589793")
  inspect!(@nm.pow(2.0, 3.0), content="8")
}
