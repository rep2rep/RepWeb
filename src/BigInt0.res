type t

@val external fromInt: int => t = "BigInt"
@val external fromString: string => t = "BigInt"

external add: (t, t) => t = "%addfloat"
external sub: (t, t) => t = "%subfloat"
external mul: (t, t) => t = "%mulfloat"
external div: (t, t) => t = "%divfloat"
external mod: (t, t) => t = "%modfloat"

external bitand: (t, t) => t = "%andint"
external bitor: (t, t) => t = "%orint"
external bitxor: (t, t) => t = "%xorint"
external bitshiftleft: (t, t) => t = "%lslint"
external bitshiftright: (t, t) => t = "%asrint"

let zero = %raw("0n")
let one = %raw("1n")
let inc = t => add(t, one)
