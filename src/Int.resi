include module type of Belt.Int

let t_rpc: Rpc.Datatype.t<int>

let hash: int => Hash.t

let toJson: int => Js.Json.t
let fromJson: Js.Json.t => Or_error.t<int>

let baseEncode: (int, int) => string
let baseDecode: (string, int) => int

let max: (int, int) => int
let min: (int, int) => int
