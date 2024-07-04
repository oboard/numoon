// pub trait Random {
//   rand(NMShape) -> L
// }

// extern "js" fn get_time() -> Int = "() => new Date().getTime()"

pub fn rand(rows : Int, cols : Int) -> L {
  let shape = { rows, cols }
  let length = shape.length()
  let arr = []
  // let base = match @wasi.get_clock_time(Realtime, 1000000000L) {
  //   Ok(time) => time.to_int()
  //   Err(err) => abort("Failed to get clock time: \(err)")
  // }
  let state = @random.RandomState::new()
  for i = 0; i < length; i = i + 1 {
    arr.push(to_NMDouble(@random.gen_double(state)))
  }
  { value: arr, shape }
}
