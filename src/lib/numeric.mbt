///| Generate an array of linearly spaced values between `start` and `stop`.
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
  num~ : Int = 50
) -> Array[Double] {
  let step = (stop - start) / (num.to_double() - 1.0)
  let arr = []
  for i = 0; i < num; i = i + 1 {
    arr.push(start + i.to_double() * step)
  }
  arr
}

test "linspace" {
  let result = linspace(0.0, 1.0, num=5)
  inspect!(result, content="[0, 0.25, 0.5, 0.75, 1]")
}

///|
pub enum ConvolveMode {
  SAME
  VALID
  FULL
}

///| Convolve the input list `self` with the `kernel` list using the specified
/// `mode`.
///
/// # Parameters
///
/// - `self` : The input list to be convolved.
/// - `kernel` : The kernel list used for convolution.
/// - `mode` : The mode of convolution. Defaults to `ConvolveMode::FULL`.
///
/// # Returns
///
/// - A new list representing the result of the convolution. The shape of the
/// output list depends on the `mode` specified.
///
/// # Modes
///
/// - `ConvolveMode::FULL` : Returns the full convolution output.
/// - `ConvolveMode::SAME` : Returns the output with the same size as the input
/// list.
/// - `ConvolveMode::VALID` : Returns the output where no zero-padding was done
/// on the input list.
pub fn L::convolve(
  self : L,
  kernel : L,
  mode~ : ConvolveMode = ConvolveMode::FULL
) -> L {
  let n = self.length()
  let m = kernel.length()
  let output = Array::make(n + m - 1, NMDouble(0.0))
  for i = 0; i < n; i = i + 1 {
    for j = 0; j < m; j = j + 1 {
      output[i + j] += self[i] * kernel[j]
    }
  }
  match mode {
    ConvolveMode::SAME => {
      let center = (m - 1) / 2
      {
        value: output[center:n + m - 1 - center].iter().to_array(),
        shape: [n, 1],
      }
    }
    ConvolveMode::VALID => {
      let center = (m - 1) / 2
      {
        value: output[center:n - center].iter().to_array(),
        shape: [n - m + 1, 1],
      }
    }
    ConvolveMode::FULL => { value: output, shape: [output.length()] }
  }
}

test "valid convolve" {
  fn convolve() {
    let a = array([100, 20])
    let b = array([1])
    a.convolve(b, mode=ConvolveMode::VALID)
  }

  inspect!(convolve().value, content="[100, 20]")
}

test "full convolve" {
  fn convolve() {
    let a = array([1, 2, 3])
    let b = array([0, 1, 0.5])
    a.convolve(b)
  }

  inspect!(convolve(), content="[0,1,2.5,4,1.5]")
}

test "same convolve" {
  fn convolve() {
    let a = array([1, 2, 3])
    let b = array([0, 1, 0.5])
    a.convolve(b, mode=ConvolveMode::SAME)
  }

  inspect!(convolve(), content="[[1],[2.5],[4]]")
}
