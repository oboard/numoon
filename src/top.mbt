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
}
