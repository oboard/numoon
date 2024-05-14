fn add() -> Unit {
  let list1 = @nm.int_arr([1, 2, 3])
  let list2 = @nm.int_arr([2, 2, 2])
  println(list1 * list2)
}

fn sum() -> Unit {
  let list1 = @nm.int_arr([1, 2, 3, 4, 5, 6])
  println(list1.sum())
}

fn reshape() -> Unit {
  let list1 = @nm.int_arr([1, 2, 3, 4, 5, 6]).reshape(2, 3)
  println(list1)
}

fn random() -> Unit {
  let list1 = @nm.rand(2, 3)
  println(list1)
}

fn matrixMul1() -> Unit {
  let m1 = @nm.int_arr([1, 2, 3, 4]).reshape(2, 2)
  let m2 = @nm.int_arr([1, 2, 3, 4]).reshape(2, 2)
  let result = @nm.dot(m1, m2)
  println(result)
}

fn matrixMul2() -> Unit {
  let m1 = @nm.int_matrix([[1], [2]])
  let m2 = @nm.int_matrix([[1, 2]])
  let result = @nm.dot(m1, m2)
  println(result)
}

fn matrixMul3() -> Unit {
  let m2 = @nm.int_matrix([[1, 2, 3], [4, 5, 6]])
  let m1 = @nm.int_matrix([[7, 8], [9, 10], [11, 12]])
  let result = @nm.dot(m1, m2)
  println(result)
}

test {
  add()
  sum()
  reshape()
  random()
  matrixMul1()
  matrixMul2()
  matrixMul3()
}
