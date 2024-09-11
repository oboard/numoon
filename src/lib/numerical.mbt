
/// Generate an array of linearly spaced values between `start` and `stop`.
///
/// # Parameters
///
/// - `start` : The starting value of the sequence.
/// - `stop` : The ending value of the sequence.
/// - `num` : The number of samples to generate. Defaults to 50.
///
/// # Returns
///
/// - An array of `num` linearly spaced values between `start` and `stop`.
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
 let result = linspace(0.0, 1.0, num = 5)
 inspect!(result, content="[0, 0.25, 0.5, 0.75, 1]")
}