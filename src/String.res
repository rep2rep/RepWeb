include Js.String2

module Map = Belt.Map.String
module Set = Belt.Set.String

let t_rpc = Rpc.Datatype.string_

let hash = Hash.fromString

let toJson = Js.Json.string
let fromJson = j =>
  j->Js.Json.decodeString->Or_error.fromOption_ss(["Not a JSON string: ", make(j)])

let repeat = (t, n) =>
  if n <= 0 {
    ""
  } else {
    Array.joinWith(Array.repeat(t, n), "")
  }

@send external replaceAll: (string, string, string) => string = "replaceAll"

let padLeft = (t, ~length as l, ~fill) => {
  let currLen = length(t)
  let padBy = l - currLen
  if padBy <= 0 {
    t
  } else {
    let fillLen = length(fill)
    let fillReps = padBy / fillLen
    let fillSpill = mod(padBy, fillLen)
    repeat(fill, fillReps) ++ substrAtMost(fill, ~from=0, ~length=fillSpill) ++ t
  }
}

let padRight = (t, ~length as l, ~fill) => {
  let currLen = length(t)
  let padBy = l - currLen
  if padBy <= 0 {
    t
  } else {
    let fillLen = length(fill)
    let fillReps = padBy / fillLen
    let fillSpill = mod(padBy, fillLen)
    t ++ repeat(fill, fillReps) ++ substrAtMost(fill, ~from=0, ~length=fillSpill)
  }
}

let approxWidths = Belt.Map.String.fromArray([
  (" ", 0.3),
  ("!", 0.33),
  (".", 0.33),
  (",", 0.33),
  (";", 0.33),
  (":", 0.33),
  ("\"", 0.4),
  ("'", 0.25),
  ("/", 0.35),
  ("\\", 0.35),
  ("@", 1.2),
  ("#", 0.66),
  ("$", 0.66),
  ("£", 0.66),
  ("&", 0.8),
  ("*", 0.45),
  ("(", 0.4),
  (")", 0.4),
  ("[", 0.4),
  ("]", 0.4),
  ("{", 0.4),
  ("}", 0.4),
  ("|", 0.3),
  ("+", 0.7),
  ("-", 0.4),
  ("–", 0.66),
  ("—", 1.15),
  ("=", 0.7),
  ("_", 0.66),
  ("0", 0.66),
  ("1", 0.6),
  ("2", 0.66),
  ("3", 0.66),
  ("4", 0.66),
  ("5", 0.66),
  ("6", 0.66),
  ("7", 0.66),
  ("8", 0.66),
  ("9", 0.66),
  ("a", 0.66),
  ("b", 0.66),
  ("c", 0.6),
  ("d", 0.66),
  ("e", 0.66),
  ("f", 0.33),
  ("g", 0.66),
  ("h", 0.66),
  ("i", 0.25),
  ("j", 0.25),
  ("k", 0.66),
  ("l", 0.25),
  ("m", 1.00),
  ("n", 0.66),
  ("o", 0.66),
  ("p", 0.66),
  ("q", 0.66),
  ("r", 0.40),
  ("s", 0.66),
  ("t", 0.33),
  ("u", 0.66),
  ("v", 0.65),
  ("w", 0.90),
  ("x", 0.66),
  ("y", 0.66),
  ("z", 0.66),
  ("A", 0.80),
  ("B", 0.80),
  ("C", 0.85),
  ("D", 0.85),
  ("E", 0.80),
  ("F", 0.75),
  ("G", 0.95),
  ("H", 0.85),
  ("I", 0.33),
  ("J", 0.6),
  ("K", 0.80),
  ("L", 0.66),
  ("M", 1.00),
  ("N", 0.85),
  ("O", 0.95),
  ("P", 0.80),
  ("Q", 0.95),
  ("R", 0.85),
  ("S", 0.80),
  ("T", 0.65),
  ("U", 0.85),
  ("V", 0.80),
  ("W", 1.15),
  ("X", 0.80),
  ("Y", 0.80),
  ("Z", 0.75),
])

let approximateEmWidth = t => {
  t
  ->castToArrayLike
  ->Js.Array2.fromMap(c => approxWidths->Belt.Map.String.getWithDefault(c, 1.))
  ->Array.reduce(0., (a, b) => a +. b)
}
