pub fn add() -> Unit {
  let list1 = @nm.int_array([1, 2, 3])
  let list2 = @nm.double_array([2.2, 2.2, 3.2])
  println(list1 + list2)
}

test {
  add()
}
