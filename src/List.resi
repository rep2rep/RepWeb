include module type of Belt.List

let t_rpc: Rpc.Datatype.t<'a> => Rpc.Datatype.t<list<'a>>

let toJson: (list<'a>, 'a => Js.Json.t) => Js.Json.t
let fromJson: (Js.Json.t, Js.Json.t => Or_error.t<'a>) => Or_error.t<list<'a>>

let toString: (list<'a>, 'a => string) => string

let empty: list<'a>
let singleton: 'a => list<'a>
let isEmpty: list<'a> => bool
let range: int => list<int>
let mapPartial: (list<'a>, 'a => option<'b>) => list<'b>
let allSome: list<option<'a>> => option<list<'a>>
