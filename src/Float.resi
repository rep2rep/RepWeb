include module type of Belt.Float

let t_rpc: Rpc.Datatype.t<float>

let hash: float => Hash.t

let toJson: float => Js.Json.t
let fromJson: Js.Json.t => Or_error.t<float>

let max: (float, float) => float
let min: (float, float) => float
