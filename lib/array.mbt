pub struct NMList[NMNumber] {
  value : List[NMNumber]
} derive(Show, Debug, Eq)

pub fn int_array(array : Array[Int]) -> NMList[NMNumber] {
  { value: array.map(to_NMInt).to_list() }
}

pub fn double_array(array : Array[Double]) -> NMList[NMNumber] {
  { value: array.map(to_NMDouble).to_list() }
}

pub fn int_list(list : List[Int]) -> NMList[NMNumber] {
  { value: list.map(to_NMInt) }
}

pub fn double_list(list : List[Double]) -> NMList[NMNumber] {
  { value: list.map(to_NMDouble) }
}

pub fn array(array : Array[NMNumber]) -> NMList[NMNumber] {
  { value: array.to_list() }
}

pub fn list(list : List[NMNumber]) -> NMList[NMNumber] {
  { value: list }
}

pub fn sum(xs : NMList[NMNumber]) -> Option[NMNumber] {
  loop xs.value, xs.value.head() {
    Nil, acc =>
      match acc {
        Some(acc) => Some(acc)
        None => None
      } // break 可以省略
    Cons(x, rest), acc =>
      continue rest,
        match acc {
          Some(acc) => Some(x + acc)
          None => None
        }
  }
}

pub fn op_add(
  self : NMList[NMNumber],
  other : NMList[NMNumber]
) -> NMList[NMNumber] {
  // [1, 2, 3] + [4, 5, 6] => [5, 7, 9]
  let selfArray = self.value.to_array()
  let otherArray = other.value.to_array()
  let resultArray = selfArray.mapi(fn(i, x) { x + otherArray[i] })
  { value: resultArray.to_list() }
}
