// pub trait Random {
//   rand(NMShape) -> L
// }

// extern "js" fn get_time() -> Int = "() => new Date().getTime()"

pub fn rand(length : Int) -> L {
  let arr = []
  let rand = @random.Rand::new()
  for i = 0; i < length; i = i + 1 {
    arr.push(to_NMDouble(rand.double()))
  }
  { value: arr, shape: [length] }
}

pub fn ones(length : Int) -> L {
  { value: Array::make(length, NMDouble(1.0)), shape: [length] }
}

pub fn zeros(length : Int) -> L {
  { value: Array::make(length, NMDouble(0.0)), shape: [length] }
}
