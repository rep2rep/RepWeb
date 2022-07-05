type t

let hash: t => Hash.t
let fromInt: int => t
let fromString: string => t

let add: (t, t) => t
let sub: (t, t) => t
let mul: (t, t) => t
let mod: (t, t) => t
let div: (t, t) => t

let zero: t
let one: t
