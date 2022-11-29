type window
@val external window: window = "window"

module Make = (
  T: {
    type t
  },
) => {
  type t<'a>
  type handle

  @new external _create: (string, {"detail": T.t}) => t<T.t> = "CustomEvent"
  @send external _addEventListener: (window, string, t<T.t> => unit) => unit = "addEventListener"
  @send
  external _removeEventListener: (window, string, t<T.t> => unit) => unit = "removeEventListener"
  @send external _dispatchEvent: (window, t<T.t>) => unit = "dispatchEvent"
  @get external detail: t<T.t> => T.t = "detail"

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
}
