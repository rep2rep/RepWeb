type t

@val external fromInt: int => t = "BigInt"
@val external fromString: string => t = "BigInt"

external add: (t, t) => t = "%addfloat"
external sub: (t, t) => t = "%subfloat"
external mul: (t, t) => t = "%mulfloat"
external div: (t, t) => t = "%divfloat"
external mod: (t, t) => t = "%modfloat"


let zero = %raw("0n")
let one = %raw("1n")
let inc = t => add(t, one)
