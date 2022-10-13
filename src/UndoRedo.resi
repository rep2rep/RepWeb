type t<'a>

let create: ('a, ~atTime: float) => t<'a>
let state: t<'a> => 'a

let canUndo: t<'a> => bool
let canRedo: t<'a> => bool

let step: (t<'a>, 'a, ~atTime: float) => t<'a>
let replace: (t<'a>, 'a) => t<'a>
let undo: t<'a> => t<'a>
let redo: t<'a> => t<'a>
