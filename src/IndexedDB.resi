type t

let open_: (~name: string, ~version: int, ~onUpgradeNeeded: t => unit) => Promise.t<t>
let createObjectStore: (t, string) => unit
let onError: (t, 'event => unit) => unit

let add: (t, ~store: string, ~key: string, 'a) => Promise.t<'a>
let put: (t, ~store: string, ~key: string, 'a) => Promise.t<'a>
let get: (t, ~store: string, ~key: string) => Promise.t<'a>
let delete: (t, ~store: string, ~key: string) => Promise.t<unit>
