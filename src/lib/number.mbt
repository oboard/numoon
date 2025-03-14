///|
pub enum NMNum {
  NMInt(Int)
  NMDouble(Double)
  NMString(String)
} derive(Show, Eq)

///|
pub impl Show for NMNum with to_string(self : NMNum) -> String {
  match self {
    NMInt(i) => i.to_string()
    NMDouble(d) => d.to_string()
    NMString(s) => s
  }
}

///|
pub fn NMNum::op_add(self : NMNum, that : NMNum) -> NMNum {
  match (self, that) {
    (NMInt(a), NMInt(b)) => NMInt(a + b)
    (NMDouble(a), NMDouble(b)) => NMDouble(a + b)
    (NMInt(a), NMDouble(b)) => NMDouble(b + a.to_double())
    (NMDouble(a), NMInt(b)) => NMDouble(a + b.to_double())
    (NMString(a), NMString(b)) => NMString(a + b)
    _ => abort("Invalid operands for addition")
  }
}

///|
pub fn NMNum::op_sub(self : NMNum, that : NMNum) -> NMNum {
  match (self, that) {
    (NMInt(a), NMInt(b)) => NMInt(a - b)
    (NMDouble(a), NMDouble(b)) => NMDouble(a - b)
    (NMInt(a), NMDouble(b)) => NMDouble(b - a.to_double())
    (NMDouble(a), NMInt(b)) => NMDouble(a - b.to_double())
    (NMString(a), NMString(b)) => NMString(a + b)
    _ => abort("Invalid operands for addition")
  }
}

///|
pub fn NMNum::op_div(self : NMNum, that : NMNum) -> NMNum {
  match (self, that) {
    (NMInt(a), NMInt(b)) => NMInt(a / b)
    (NMDouble(a), NMDouble(b)) => NMDouble(a / b)
    (NMInt(a), NMDouble(b)) => NMDouble(b / a.to_double())
    (NMDouble(a), NMInt(b)) => NMDouble(a / b.to_double())
    (NMString(a), NMString(b)) => NMString(a + b)
    _ => abort("Invalid operands for addition")
  }
}

///|
pub fn NMNum::op_mul(self : NMNum, that : NMNum) -> NMNum {
  match (self, that) {
    (NMInt(a), NMInt(b)) => NMInt(a * b)
    (NMDouble(a), NMDouble(b)) => NMDouble(a * b)
    (NMInt(a), NMDouble(b)) => NMDouble(b * a.to_double())
    (NMDouble(a), NMInt(b)) => NMDouble(a * b.to_double())
    (NMString(a), NMString(b)) => NMString(a + b)
    _ => abort("Invalid operands for addition")
  }
}

///|
pub fn NMNum::to_int(self : NMNum) -> Int {
  match self {
    NMInt(i) => i
    NMDouble(d) => d.to_int()
    NMString(s) => s.length()
  }
}

///|
pub fn NMNum::to_double(self : NMNum) -> Double {
  match self {
    NMInt(i) => i.to_double()
    NMDouble(d) => d
    NMString(s) => s.length().to_double()
  }
}

///|
pub fn NMNum::from_int(num : Int) -> NMNum {
  NMInt(num)
}

///|
pub fn NMNum::from_double(num : Double) -> NMNum {
  NMDouble(num)
}

///|
test {
  let a : NMNum = NMInt(2)
  let b : NMNum = NMDouble(7.5)
  println(a + b)
}
