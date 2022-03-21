include Belt.Result

let mapError = (t, f) =>
  switch t {
  | Ok(a) => Ok(a)
  | Error(b) => Error(f(b))
  }
