include module type of Belt.Option

let t_rpc: Rpc.Datatype.t<'a> => Rpc.Datatype.t<option<'a>>

let hash: (option<'a>, 'a => Hash.t) => Hash.t

let toJson: (option<'a>, 'a => Js.Json.t) => Js.Json.t
let fromJson: (Js.Json.t, Js.Json.t => Or_error.t<'a>) => Or_error.t<option<'a>>

let toString: (option<'a>, 'a => string) => string

let some: 'a => option<'a>
let flatten: option<option<'a>> => option<'a>
let iter: (option<'a>, 'a => unit) => unit
let both: ((option<'a>, option<'b>)) => option<('a, 'b)>
let both3: ((option<'a>, option<'b>, option<'c>)) => option<('a, 'b, 'c)>
let first: array<option<'a>> => option<'a>
let all: array<option<'a>> => option<array<'a>>
