include module type of Js.String2

let t_rpc: Rpc.Datatype.t<string>

let hash: string => Hash.t

let toJson: string => Js.Json.t
let fromJson: Js.Json.t => Or_error.t<string>

let approximateEmWidth: string => float

let repeat: (string, int) => string

let padLeft: (string, ~length: int, ~fill: string) => string
let padRight: (string, ~length: int, ~fill: string) => string

module Map: module type of Belt.Map.String
module Set: module type of Belt.Set.String
