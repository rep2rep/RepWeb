type t = bool

let t_rpc: Rpc.Datatype.t<bool>

let hash: t => Hash.t

let not: t => t

let toString: t => string
let fromString: string => option<t>

let toJson: t => Js.Json.t
let fromJson: Js.Json.t => Or_error.t<t>
