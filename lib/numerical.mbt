/// start: The starting value of the sequence.
/// 
/// stop: The ending value of the sequence.
/// 
/// ~num: The number of samples to generate, inclusive of both start and stop. Default is 50.
pub fn linspace(
  start : Double,
  stop : Double,
  ~num : Int = 50
) -> Array[Double] {
  let step = (stop - start) / (num.to_double() - 1.0)
  let arr = []
  for i = 0; i < num; i = i + 1 {
    arr.push(start + i.to_double() * step)
  }
  arr
}

test {
  inspect(
    linspace(0.0, 10.0, num=11),
    content="[0.0, 1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0]",
  )!
}
