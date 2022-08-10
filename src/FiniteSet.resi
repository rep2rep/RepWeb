type t<'a>

let t_rpc: Rpc.Datatype.t<'a> => Rpc.Datatype.t<t<'a>>

let toJson: (t<'a>, 'a => Js.Json.t) => Js.Json.t
let fromJson: (Js.Json.t, Js.Json.t => Or_error.t<'a>) => Or_error.t<t<'a>>

let empty: unit => t<'a>
let fromArray: array<'a> => t<'a>
let toArray: t<'a> => array<'a>
