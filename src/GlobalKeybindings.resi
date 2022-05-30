module KeyBinding: {
  type t
  let create: (string, unit => unit) => t
  let cmdOrCtrl: unit => string
}

let set: array<KeyBinding.t> => unit
