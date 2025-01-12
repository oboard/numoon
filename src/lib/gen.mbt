// pub trait Random {
//   rand(NMShape) -> L
// }

// extern "js" fn get_time() -> Int = "() => new Date().getTime()"

///|
pub fn rand(length : Int) -> L {
  let arr = []
  let rand = @random.Rand::new()
  for i = 0; i < length; i = i + 1 {
    arr.push(NMDouble(rand.double()))
  }
  { value: arr, shape: [length] }
}

///|
pub fn arange(start~ : Double = 0, end~ : Double, step~ : Double = 1) -> L {
  let arr = []
  for i = start; i < end; i = i + step {
    arr.push(NMDouble(i))
  }
  { value: arr, shape: [arr.length()] }
}

///|
pub fn ones(length : Int) -> L {
  { value: Array::make(length, NMDouble(1.0)), shape: [length] }
}

///|
pub fn zeros(length : Int) -> L {
  { value: Array::make(length, NMDouble(0.0)), shape: [length] }
}
