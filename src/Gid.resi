type t

let t_rpc: Rpc.Datatype.t<t>

let create: unit => t
let combine: array<t> => t

let toString: t => string
let fromString: string => t

let toJson: t => Js.Json.t
let fromJson: Js.Json.t => Or_error.t<t>

module Set: {
  type elt = t
  type t

  let toJson: t => Js.Json.t
  let fromJson: Js.Json.t => Or_error.t<t>

  let empty: t
  let isEmpty: t => bool
  let has: (t, elt) => bool
  let add: (t, elt) => t
  let remove: (t, elt) => t
  let union: (t, t) => t
  let intersect: (t, t) => t
  let size: t => int
  let toList: t => list<elt>
  let fromList: list<elt> => t
  let toArray: t => array<elt>
  let fromArray: array<elt> => t
}

module Map: {
  type key = t
  type t<'v>

  let toJson: (t<'v>, 'v => Js.Json.t) => Js.Json.t
  let fromJson: (Js.Json.t, Js.Json.t => Or_error.t<'v>) => Or_error.t<t<'v>>

  let empty: unit => t<'v>
  let isEmpty: t<'v> => bool
  let has: (t<'v>, key) => bool
  let set: (t<'v>, key, 'v) => t<'v>
  let get: (t<'v>, key) => option<'v>
  let remove: (t<'v>, key) => t<'v>
  let update: (t<'v>, key, option<'v> => option<'v>) => t<'v>
  let map: (t<'v>, 'v => 'w) => t<'w>
  let mapWithKey: (t<'v>, (key, 'v) => 'w) => t<'w>
  let forEach: (t<'v>, (key, 'v) => unit) => unit
  let merge: (t<'x>, t<'y>, (key, option<'x>, option<'y>) => option<'z>) => t<'z>
  let keys: t<'v> => array<key>
  let values: t<'v> => array<'v>
  let toList: t<'v> => list<(key, 'v)>
  let toArray: t<'v> => array<(key, 'v)>
  let fromList: list<(key, 'v)> => t<'v>
  let fromArray: array<(key, 'v)> => t<'v>
}
