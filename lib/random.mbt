pub trait Random {
  rand(NMShape) -> L
}

// extern "js" fn get_time() -> Int = "() => new Date().getTime()"

pub fn rand(rows : Int, cols : Int) -> L {
  let shape = { rows, cols }
  let length = shape.length()
  let mut list = [].to_list()
  // let base = match @wasi.get_clock_time(Realtime, 1000000000L) {
  //   Ok(time) => time.to_int()
  //   Err(err) => abort("Failed to get clock time: \(err)")
  // }
  for i = 0; i < length; i = i + 1 {
    list = Cons(to_NMDouble(@random.RandomDouble::new().summon()), list)
  }
  { value: list, shape }
}
