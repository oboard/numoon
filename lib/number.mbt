pub enum NMNumber {
  NMInt(Int)
  NMDouble(Double)
  NMString(String)
} derive(Show, Debug, Eq)

fn op_add(self : NMNumber, that : NMNumber) -> NMNumber {
  match (self, that) {
    (NMInt(a), NMInt(b)) => NMInt(a + b)
    (NMDouble(a), NMDouble(b)) => NMDouble(a + b)
    (NMInt(a), NMDouble(b)) => NMDouble(b + a.to_double())
    (NMDouble(a), NMInt(b)) => NMDouble(a + b.to_double())
    (NMString(a), NMString(b)) => NMString(a + b)
    _ => abort("Invalid operands for addition")
  }
}

fn op_sub(self : NMNumber, that : NMNumber) -> NMNumber {
  match (self, that) {
    (NMInt(a), NMInt(b)) => NMInt(a - b)
    (NMDouble(a), NMDouble(b)) => NMDouble(a - b)
    (NMInt(a), NMDouble(b)) => NMDouble(b - a.to_double())
    (NMDouble(a), NMInt(b)) => NMDouble(a - b.to_double())
    (NMString(a), NMString(b)) => NMString(a + b)
    _ => abort("Invalid operands for addition")
  }
}

fn op_div(self : NMNumber, that : NMNumber) -> NMNumber {
  match (self, that) {
    (NMInt(a), NMInt(b)) => NMInt(a / b)
    (NMDouble(a), NMDouble(b)) => NMDouble(a / b)
    (NMInt(a), NMDouble(b)) => NMDouble(b / a.to_double())
    (NMDouble(a), NMInt(b)) => NMDouble(a / b.to_double())
    (NMString(a), NMString(b)) => NMString(a + b)
    _ => abort("Invalid operands for addition")
  }
}

fn op_mul(self : NMNumber, that : NMNumber) -> NMNumber {
  match (self, that) {
    (NMInt(a), NMInt(b)) => NMInt(a * b)
    (NMDouble(a), NMDouble(b)) => NMDouble(a * b)
    (NMInt(a), NMDouble(b)) => NMDouble(b * a.to_double())
    (NMDouble(a), NMInt(b)) => NMDouble(a * b.to_double())
    (NMString(a), NMString(b)) => NMString(a + b)
    _ => abort("Invalid operands for addition")
  }
}

fn to_int(self : NMNumber) -> Int {
  match self {
    NMInt(i) => i
    NMDouble(d) => d.to_int()
    NMString(s) => s.length()
  }
}

fn to_double(self : NMNumber) -> Double {
  match self {
    NMInt(i) => i.to_double()
    NMDouble(d) => d
    NMString(s) => s.length().to_double()
  }
}

pub fn to_NMInt(i : Int) -> NMNumber {
  NMInt(i)
}

pub fn to_NMDouble(d : Double) -> NMNumber {
  NMDouble(d)
}



test {
  let a : NMNumber = NMInt(2)
  let b : NMNumber = NMDouble(7.5)
  println(a + b)
}
