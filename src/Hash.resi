type t

let unique: unit => t
let combine: array<t> => t

let fromString: string => t
let fromInt: int => t
let fromFloat: float => t
let fromArray: (array<'a>, 'a => t) => t

let record1: (string, 'a => t, 'z) => t
let record2: ((string, 'a => t), (string, 'b => t), 'z) => t
let record3: ((string, 'a => t), (string, 'b => t), (string, 'c => t), 'z) => t
let record4: ((string, 'a => t), (string, 'b => t), (string, 'c => t), (string, 'd => t), 'z) => t
let record5: (
  (string, 'a => t),
  (string, 'b => t),
  (string, 'c => t),
  (string, 'd => t),
  (string, 'e => t),
  'z,
) => t
let record6: (
  (string, 'a => t),
  (string, 'b => t),
  (string, 'c => t),
  (string, 'd => t),
  (string, 'e => t),
  (string, 'f => t),
  'z,
) => t
let record7: (
  (string, 'a => t),
  (string, 'b => t),
  (string, 'c => t),
  (string, 'd => t),
  (string, 'e => t),
  (string, 'f => t),
  (string, 'g => t),
  'z,
) => t
let record11: (
  (string, 'a => t),
  (string, 'b => t),
  (string, 'c => t),
  (string, 'd => t),
  (string, 'e => t),
  (string, 'f => t),
  (string, 'g => t),
  (string, 'h => t),
  (string, 'i => t),
  (string, 'j => t),
  (string, 'k => t),
  'z,
) => t
