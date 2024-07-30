fn add() -> @nm.L {
  let list1 = @nm.int_arr([1, 2, 3])
  let list2 = @nm.int_arr([2, 2, 2])
  list1 + list2
}

fn sum() -> @nm.NMNum {
  @nm.int_arr([1, 2, 3, 4, 5, 6]).sum()
}

fn reshape() -> @nm.L {
  @nm.int_arr([1, 2, 3, 4, 5, 6]).reshape(2, 3)
}

fn random() -> @nm.L {
  @nm.rand(2, 3)
}

fn matrix() -> Array[(String, @nm.L)] {
  let a = @nm.int_matrix([[1, 2], [3, 4]])
  let b = @nm.int_matrix([[5, 6], [7, 8]])
  [
    ("add", a + b),
    ("reshape", a.reshape(1, 4)),
    ("random", @nm.rand(2, 3)),
    ("matrix", @nm.int_matrix([[1, 2], [3, 4]])),
    ("dot", @nm.dot(a, b)),
    ("transpose", a.transpose()),
  ]
}

test {
  inspect!(add(), content="[3 4 5]")
  inspect!(sum(), content="21.0")
  inspect!(
    reshape(),
    content=
      #|[[1 2]
      #| [3 4]
      #| [5 6]]
    ,
  )
  inspect!(
    random(),
    content=
      #|[[0.0 0.0]
      #| [0.0 0.0]
      #| [0.0 0.0]]
    ,
  )
  inspect!(
    matrix(),
    content=
      #|[(add, [[6 8]
      #| [10 12]]), (reshape, [[1]
      #| [2]
      #| [3]
      #| [4]]), (random, [[0.0 0.0]
      #| [0.0 0.0]
      #| [0.0 0.0]]), (matrix, [[1 2]
      #| [3 4]]), (dot, [[7.0 10.0]
      #| [15.0 22.0]]), (transpose, [[1.0 3.0]
      #| [2.0 4.0]])]
    ,
  )
}
