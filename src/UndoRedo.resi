type t<'a>

let create: 'a => t<'a>
let state: t<'a> => 'a

let canUndo: t<'a> => bool
let canRedo: t<'a> => bool

let step: (t<'a>, 'a) => t<'a>
let replace: (~updateTime:bool=?, t<'a>, 'a) => t<'a>
let undo: t<'a> => t<'a>
let redo: t<'a> => t<'a>
