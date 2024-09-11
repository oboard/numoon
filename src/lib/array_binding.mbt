pub fn L::map(self : L, func : (NMNum) -> NMNum) -> L {
  { value: self.value.map(func), shape: self.shape }
}

pub fn L::map_double(self : L, func : (Double) -> Double) -> L {
  {
    value: self.value.map(to_double).map(func).map(NMNum::NMDouble),
    shape: self.shape,
  }
}

pub fn L::filter(self : L, func : (NMNum) -> Bool) -> L {
  { value: self.value.filter(func), shape: self.shape }
}

pub fn L::fold(
  self : L,
  ~init : NMNum,
  func : (NMNum, NMNum) -> NMNum
) -> NMNum {
  self.value.fold(~init, func)
}

pub fn L::sin(self : L) -> L {
  self.map_double(math_sin)
}

pub fn L::cos(self : L) -> L {
  self.map_double(math_cos)
}

pub fn L::tan(self : L) -> L {
  self.map_double(math_tan)
}

pub fn L::arcsin(self : L) -> L {
  self.map_double(math_arcsin)
}

pub fn L::arccos(self : L) -> L {
  self.map_double(math_arccos)
}

pub fn L::arctan(self : L) -> L {
  self.map_double(math_arctan)
}

pub fn L::sinh(self : L) -> L {
  self.map_double(math_sinh)
}

pub fn L::cosh(self : L) -> L {
  self.map_double(math_cosh)
}

pub fn L::tanh(self : L) -> L {
  self.map_double(math_tanh)
}

pub fn L::arcsinh(self : L) -> L {
  self.map_double(math_arcsinh)
}

pub fn L::arccosh(self : L) -> L {
  self.map_double(math_arccosh)
}

pub fn L::arctanh(self : L) -> L {
  self.map_double(math_arctanh)
}

pub fn L::exp(self : L) -> L {
  self.map_double(math_exp)
}

pub fn L::ln(self : L) -> L {
  self.map_double(math_ln)
}

pub fn L::multiply(self : L, other : Json) -> L {
  match other {
    Number(num) => self.map_double(fn(x) { x * num })
    _ => self
  }
}

pub fn L::divide(self : L, other : Json) -> L {
  match other {
    Number(num) => self.map_double(fn(x) { x / num })
    _ => self
  }
}

pub fn L::round(self : L) -> L {
  self.map_double(fn(x) { x.round() })
}

pub fn L::floor(self : L) -> L {
  self.map_double(fn(x) { x.floor() })
}

pub fn L::ceil(self : L) -> L { 
  self.map_double(fn(x) { x.ceil() })
}

pub fn L::abs(self : L) -> L {
  self.map_double(fn(x) { x.abs() })
}

pub fn L::sqrt(self : L) -> L {
  self.map_double(fn(x) { x.sqrt() })
}