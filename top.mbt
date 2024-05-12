pub fn add() -> Unit {
  let list1 = @nm.int_arr([1, 2, 3])
  let list2 = @nm.int_arr([2, 2, 2])
  println(list1 * list2)
}

pub fn sum() -> Unit {
  let list1 = @nm.int_arr([1, 2, 3, 4, 5, 6])
  println(list1.sum())
}

pub fn reshape() -> Unit {
  let list1 = @nm.int_arr([1, 2, 3, 4, 5, 6])
  list1.reshape(2, 3)
  println(list1)
}

pub fn random() -> Unit {
  let list1 = @nm.rand(2, 3)
  println(list1)
}

pub fn matrixMul() -> Unit {
  let m1 = @nm.int_arr([1, 2])
  m1.reshape(2, 3)
  let m2 = @nm.int_arr([1, 2])
  m2.reshape(3, 2)
  let result = @nm.dot(m1, m2)
  println(result)
}

test {
  random()
}
