// Copyright 2024 International Digital Economy Academy
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

let pi4a = 0x0.C90FDA000000000011B5

let pi4b = 0x0.000000A2216800000988

let pi4c = 0x0.000000000000C234BE07

pub let pi = 0x3.243F6A8885A308CA8A54

let pi4 : Double = 4.0 / pi

let sin_ = [
  0x0.00000000AEC7E8FE9D35, -0x0.0000006B9796A4A487D, 0x0.00002E3BC6ACFA913766, -1.98412698295895385996e-4,
  0x0.02222222221EFA06A21A, -0x0.2AAAAAAAAAAA90C58591,
]

pub fn math_sin(x : Double) -> Double {
  if Double::is_inf(x) || Double::is_nan(x) {
    x
  } else {
    let mut sign = false
    let mut x_ = x
    if x_ < 0.0 {
      x_ = -x_
      sign = true
    }
    let mut j = (x_ * pi4).to_int64()
    if j.land(1L) == 1L {
      j += 1L
    }
    let y = j.to_double()
    j = j.land(7L)
    if j > 3L {
      sign = sign.not()
      j -= 4L
    }
    let z = x_ - y * pi4a - y * pi4b - y * pi4c
    let zz = z * z
    (if j == 1L || j == 2L {
      1.0 -
      0.5 * zz +
      zz *
      zz *
      (
        (
          (((cos_[0] * zz + cos_[1]) * zz + cos_[2]) * zz + cos_[3]) * zz +
          cos_[4]
        ) *
        zz +
        cos_[5]
      )
    } else {
      z +
      z *
      zz *
      (
        (
          (((sin_[0] * zz + sin_[1]) * zz + sin_[2]) * zz + sin_[3]) * zz +
          sin_[4]
        ) *
        zz +
        sin_[5]
      )
    }) *
    (if sign { -1.0 } else { 1.0 })
  }
}

let cos_ = [
  -0x0.000000000C7D24D03C8, 0x0.00000008F74EBDA72B71, -0x0.0000049F93DFAB12FDC6,
  0x0.0001A01A019C844F3E07, -0x0.005B05B05B053E453C34, 0x0.0AAAAAAAAAAAA55A47E1,
]

pub fn math_cos(x : Double) -> Double {
  if Double::is_inf(x) || Double::is_nan(x) {
    x
  } else {
    let mut sign = false
    let x_ = x.abs()
    let mut j = (x_ * pi4).to_int64()
    if j.land(1L) == 1L {
      j += 1L
    }
    let y = j.to_double()
    j = j.land(7L)
    if j > 3L {
      sign = sign.not()
      j -= 4L
    }
    let z = x_ - y * pi4a - y * pi4b - y * pi4c
    if j > 1L {
      sign = sign.not()
    }
    let zz = z * z
    (if j == 1L || j == 2L {
      z +
      z *
      zz *
      (
        (
          (((sin_[0] * zz + sin_[1]) * zz + sin_[2]) * zz + sin_[3]) * zz +
          sin_[4]
        ) *
        zz +
        sin_[5]
      )
    } else {
      1.0 -
      0.5 * zz +
      zz *
      zz *
      (
        (
          (((cos_[0] * zz + cos_[1]) * zz + cos_[2]) * zz + cos_[3]) * zz +
          cos_[4]
        ) *
        zz +
        cos_[5]
      )
    }) *
    (if sign { -1.0 } else { 1.0 })
  }
}

let tan_p = [
  -0x3325.B1A49E7E6F070EEA7F33, 0x1199EC.A5FC9DDCB62A659C2F5C, -0x111FEAD.3299175F331F9B486E14,
]

let tan_q = [
  1.0, 0x3571.4BDD66CAE3B4F57353EC, -0x1427BC.582ABC95B9AA3C9963BF, 0x17D98FC.2EAD8EF5BE3D475ECC36,
  -0x335FC07.97CB461BD8709633FE8F,
]

pub fn math_tan(x : Double) -> Double {
  if Double::is_inf(x) || Double::is_nan(x) {
    x
  } else {
    let x_ = x.abs()
    let mut j = (x_ * pi4).to_int64()
    if j.land(1L) == 1L {
      j += 1L
    }
    let y = j.to_double()
    let z = x_ - y * pi4a - y * pi4b - y * pi4c
    let mut zz = z * z
    zz = if zz > 1.0e-14 {
      z +
      z *
      (
        zz *
        ((tan_p[0] * zz + tan_p[1]) * zz + tan_p[2]) /
        ((((zz + tan_q[1]) * zz + tan_q[2]) * zz + tan_q[3]) * zz + tan_q[4])
      )
    } else {
      z
    }
    if j.land(2L) == 2L {
      zz = -1.0 / zz
    }
    if x.signum() < 0.0 {
      -zz
    } else {
      zz
    }
  }
}

let atan_p = [
  -8.750608600031904122785e-01, -1.615753718733365076637e+01, -7.500855792314704667340e+01,
  -1.228866684490136173410e+02, -6.485021904942025371773e+01,
]

let atan_q = [
  2.485846490142306297962e+01, 1.650270098316988542046e+02, 4.328810604912902668951e+02,
  4.853903996359136964868e+02, 1.945506571482613964425e+02,
]

let morebits = 6.123233995736765886130e-17

let tan3pio8 = 2.41421356237309504880

fn math_xatan(x : Double) -> Double {
  let z = x * x
  x *
  (
    z *
    (
      (((atan_p[0] * z + atan_p[1]) * z + atan_p[2]) * z + atan_p[3]) * z +
      atan_p[4]
    ) /
    (
      ((((z + atan_q[0]) * z + atan_q[1]) * z + atan_q[2]) * z + atan_q[3]) * z +
      atan_q[4]
    )
  ) +
  x
}

fn math_satan(x : Double) -> Double {
  if x <= 0.66 {
    math_xatan(x)
  } else if x > tan3pio8 {
    pi / 2.0 - math_xatan(1.0 / x) + morebits
  } else {
    pi / 4.0 + math_xatan((x - 1.0) / (x + 1.0)) + 0.5 * morebits
  }
}

pub fn math_arctan(x : Double) -> Double {
  if Double::is_inf(x) || Double::is_nan(x) || x == 0.0 {
    x
  } else if x > 0.0 {
    math_satan(x)
  } else {
    -math_satan(-x)
  }
}

pub fn math_arcsin(x : Double) -> Double {
  if Double::is_inf(x) || Double::is_nan(x) || x == 0.0 {
    x
  } else {
    let x_ = x.abs()
    if x_ > 1.0 {
      @double.not_a_number
    } else {
      let temp = (1.0 - x_ * x_).sqrt()
      (if x > 0.7 { pi / 2.0 - math_satan(temp / x_) } else { math_satan(x_ / temp) }) *
      x.signum()
    }
  }
}

pub fn math_arccos(x : Double) -> Double {
  if Double::is_inf(x) || Double::is_nan(x) {
    x
  } else {
    pi / 2.0 - math_arcsin(x)
  }
}

pub fn math_sinh(x : Double) -> Double {
  (x.exp() - (-x).exp()) / 2.0
}

pub fn math_cosh(x : Double) -> Double {
  (x.exp() + (-x).exp()) / 2.0
}

pub fn math_tanh(x : Double) -> Double {
  (x.exp() - (-x).exp()) / (x.exp() + (-x).exp())
}

pub fn math_arcsinh(x : Double) -> Double {
  x.log10() + (x * x + 1.0).sqrt()
}

pub fn math_arccosh(x : Double) -> Double {
  (x + (x * x - 1.0).sqrt()).log10()
}

pub fn math_arctanh(x : Double) -> Double {
  ((1.0 + x).ln() - (1.0 - x).ln()) / 2.0
}

pub fn math_sinc(x : Double) -> Double {
  if x == 0.0 {
    1.0
  } else {
    math_sin(pi * x) / (pi * x)
  }
}

pub fn math_arctan2(y : Double, x : Double) -> Double {
  if x == 0.0 {
    if y > 0.0 {
      pi / 2.0
    } else if y < 0.0 {
      -pi / 2.0
    } else {
      @double.not_a_number
    }
  } else {
    let mut z = y / x
    if z < 0.0 {
      z = -z
      if x < 0.0 {
        -math_arctan(z) - pi
      } else {
        -math_arctan(z) + pi
      }
    } else if x < 0.0 {
      -math_arctan(z) + pi
    } else {
      math_arctan(z)
    }
  }
}

pub fn math_pow(x : Double, y : Double) -> Double {
  if x == 0.0 && y == 0.0 {
    @double.not_a_number
  } else if x == 0.0 {
    if y > 0.0 {
      0.0
    } else {
      @double.not_a_number
    }
  } else if y == 0.0 {
    1.0
  } else if y == 1.0 {
    x
  } else {
    let mut z = x
    let mut n = y.to_int64()
    if n < 0 {
      z = 1.0 / z
      n = -n
    }
    let mut result = 1.0
    while n > 0 {
      if n.land(1) == 1 {
        result *= z
      }
      z *= z
      n = n.shr(1)
    }
    result
  }
}

pub fn math_degrees(x : Double) -> Double {
  x * 180.0 / pi
}

pub fn math_radians(x : Double) -> Double {
  x * pi / 180.0
}

pub fn math_deg2rad(x : Double) -> Double {
  x * pi / 180.0
}

pub fn math_rad2deg(x : Double) -> Double {
  x * 180.0 / pi
}

pub fn math_exp(x : Double) -> Double {
  x.exp()
}

pub fn math_ln(x : Double) -> Double {
  x.ln()
}

test {
  inspect!(math_sinc(1.0), content="3.8982468850708534e-17")
  inspect!(math_sinh(1.0), content="1.1752011936438014")
  inspect!(math_cosh(1.0), content="1.5430806348152437")
  inspect!(math_tanh(1.0), content="0.7615941559557649")
  inspect!(math_arcsinh(1.0), content="1.4142135623730951")
  inspect!(math_arccosh(1.0), content="0")
  inspect!(math_arctanh(0.5), content="0.5493061443340548")
  inspect!(math_arctan2(1.0, 1.0), content="0.7853981633974483")
  inspect!(math_degrees(pi), content="180")
  inspect!(math_radians(180.0), content="3.141592653589793")
  inspect!(math_pow(2.0, 3.0), content="8")
  inspect!(math_exp(1.0), content="2.718281828459045")
  inspect!(math_ln(2.718281828459045), content="1")
  inspect!(math_deg2rad(180.0), content="3.141592653589793")
  inspect!(math_rad2deg(3.141592653589793), content="180")
}
