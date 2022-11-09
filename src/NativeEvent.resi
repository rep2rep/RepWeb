type t<'a>
type handle

let create: (string, 'a) => t<'a>
let listen: (string, 'a => unit) => handle
let remove: handle => unit
let dispatch: t<'a> => unit
