include Belt.Result

let mapError = (t, f) =>
  switch t {
  | Ok(a) => Ok(a)
  | Error(b) => Error(f(b))
  }

let fromOption = (opt, err) =>
  switch opt {
  | Some(a) => Ok(a)
  | None => Error(err())
  }

let toOption = t =>
  switch t {
  | Ok(a) => Some(a)
  | Error(_) => None
  }
