type window
@val external window: window = "window"

type t<'a>
type handle

@new external _create: (string, {"detail": 'a}) => t<'a> = "CustomEvent"
@send external _addEventListener: (window, string, t<'a> => unit) => unit = "addEventListener"
@send
external _removeEventListener: (window, string, t<'a> => unit) => unit = "removeEventListener"
@send external _dispatchEvent: (window, t<'a>) => unit = "dispatchEvent"
@get external detail: t<'a> => 'a = "detail"

let create = (name, payload) => _create(name, {"detail": payload})

let listen = (name, callback) => {
  let cb = t => t->detail->callback
  window->_addEventListener(name, cb)
  (name, cb)->Obj.magic // Hide the type info; completely opaque!
}

let remove = handle => {
  let (name, cb) = Obj.magic(handle) // Dig into the parts for the handle, only done here.
  window->_removeEventListener(name, cb)
}

let dispatch = t => window->_dispatchEvent(t)
