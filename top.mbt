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

fn matrix() -> Unit {
  let a = @nm.int_matrix([[1, 2], [3, 4]])
  let b = @nm.int_matrix([[5, 6], [7, 8]])
  println(a + b)
  println(a - b)
  println(@nm.dot(a, b))
  println(a * b)
  println(a.transpose())
}

test {
  // add()
  // sum()
  // reshape()
  // random()
  matrix()
}
