include module type of Belt.Array

let t_rpc: Rpc.Datatype.t<'a> => Rpc.Datatype.t<array<'a>>

let hash: (array<'a>, 'a => Hash.t) => Hash.t

let toJson: (array<'a>, 'a => Js.Json.t) => Js.Json.t
let fromJson: (Js.Json.t, Js.Json.t => Or_error.t<'a>) => Or_error.t<array<'a>>

let singleton: 'a => array<'a>
let repeat: ('a, int) => array<'a>
let joinWith: (array<string>, string) => string
let filter: (array<'a>, 'a => bool) => array<'a>
let find: (array<'a>, 'a => bool) => option<'a>
let includes: (array<'a>, 'a) => bool
let flatMap: (array<'a>, 'a => array<'b>) => array<'b>
let flatMapWithIndex: (array<'a>, (int, 'a) => array<'b>) => array<'b>
let mapPartial: (array<'a>, 'a => option<'b>) => array<'b>
let dedup: array<'a> => array<'a>
let splitAt: (array<'a>, int) => (array<'a>, array<'a>)

let push: (array<'a>, 'a) => array<'a>
let pop: array<'a> => ('a, array<'a>)
let last: array<'a> => 'a
