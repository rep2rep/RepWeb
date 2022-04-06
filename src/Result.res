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

let thenError = (t, err, reduce_errs) => {
  switch t {
  | Ok(a) => Error(err)
  | Error(e) => reduce_errs([e, err])->Error
  }
}

let all = (results, reduce_errs) => {
  let oks = []
  let errors = []
  results->Array.forEach(r =>
    switch r {
    | Ok(v) => oks->Js.Array2.push(v)->ignore
    | Error(e) => errors->Js.Array2.push(e)->ignore
    }
  )
  if Array.length(errors) !== 0 {
    Error(reduce_errs(errors))
  } else {
    Ok(oks)
  }
}

let allUnit = (results, reduce_errs) => {
  let errors = []
  results->Array.forEach(r =>
    switch r {
    | Ok(v) => ()
    | Error(e) => errors->Js.Array2.push(e)->ignore
    }
  )
  if Array.length(errors) !== 0 {
    Error(reduce_errs(errors))
  } else {
    Ok()
  }
}

let both = ((a, b), reduce_errs) => {
  switch (a, b) {
  | (Ok(a), Ok(b)) => Ok((a, b))
  | (Error(a), Error(b)) => Error(reduce_errs([a, b]))
  | (Error(a), _) => Error(a)
  | (_, Error(b)) => Error(b)
  }
}

let both3 = ((a, b, c), reduce_errs) => {
  switch (a, b, c) {
  | (Ok(a), Ok(b), Ok(c)) => Ok((a, b, c))
  | (Error(a), Error(b), Error(c)) => Error(reduce_errs([a, b, c]))
  | (Error(a), Error(b), _) => Error(reduce_errs([a, b]))
  | (Error(a), _, Error(c)) => Error(reduce_errs([a, c]))
  | (_, Error(b), Error(c)) => Error(reduce_errs([b, c]))
  | (Error(a), _, _) => Error(a)
  | (_, Error(b), _) => Error(b)
  | (_, _, Error(c)) => Error(c)
  }
}

let both4 = ((a, b, c, d), reduce_errs) =>
  [Obj.magic(a), Obj.magic(b), Obj.magic(c), Obj.magic(d)]->all(reduce_errs)->map(Obj.magic)

let both5 = ((a, b, c, d, e), reduce_errs) =>
  [Obj.magic(a), Obj.magic(b), Obj.magic(c), Obj.magic(d), Obj.magic(e)]
  ->all(reduce_errs)
  ->map(Obj.magic)

let both6 = ((a, b, c, d, e, f), reduce_errs) =>
  [Obj.magic(a), Obj.magic(b), Obj.magic(c), Obj.magic(d), Obj.magic(e), Obj.magic(f)]
  ->all(reduce_errs)
  ->map(Obj.magic)

let both7 = ((a, b, c, d, e, f, g), reduce_errs) =>
  [Obj.magic(a), Obj.magic(b), Obj.magic(c), Obj.magic(d), Obj.magic(e), Obj.magic(f), Obj.magic(g)]
  ->all(reduce_errs)
  ->map(Obj.magic)

let both8 = ((a, b, c, d, e, f, g, h), reduce_errs) =>
  [
    Obj.magic(a),
    Obj.magic(b),
    Obj.magic(c),
    Obj.magic(d),
    Obj.magic(e),
    Obj.magic(f),
    Obj.magic(g),
    Obj.magic(h),
  ]
  ->all(reduce_errs)
  ->map(Obj.magic)

let both9 = ((a, b, c, d, e, f, g, h, i), reduce_errs) =>
  [
    Obj.magic(a),
    Obj.magic(b),
    Obj.magic(c),
    Obj.magic(d),
    Obj.magic(e),
    Obj.magic(f),
    Obj.magic(g),
    Obj.magic(h),
    Obj.magic(i),
  ]
  ->all(reduce_errs)
  ->map(Obj.magic)

let both10 = ((a, b, c, d, e, f, g, h, i, j), reduce_errs) =>
  [
    Obj.magic(a),
    Obj.magic(b),
    Obj.magic(c),
    Obj.magic(d),
    Obj.magic(e),
    Obj.magic(f),
    Obj.magic(g),
    Obj.magic(h),
    Obj.magic(i),
    Obj.magic(j),
  ]
  ->all(reduce_errs)
  ->map(Obj.magic)

let both11 = ((a, b, c, d, e, f, g, h, i, j, k), reduce_errs) =>
  [
    Obj.magic(a),
    Obj.magic(b),
    Obj.magic(c),
    Obj.magic(d),
    Obj.magic(e),
    Obj.magic(f),
    Obj.magic(g),
    Obj.magic(h),
    Obj.magic(i),
    Obj.magic(j),
    Obj.magic(k),
  ]
  ->all(reduce_errs)
  ->map(Obj.magic)

let both12 = ((a, b, c, d, e, f, g, h, i, j, k, l), reduce_errs) =>
  [
    Obj.magic(a),
    Obj.magic(b),
    Obj.magic(c),
    Obj.magic(d),
    Obj.magic(e),
    Obj.magic(f),
    Obj.magic(g),
    Obj.magic(h),
    Obj.magic(i),
    Obj.magic(j),
    Obj.magic(k),
    Obj.magic(l),
  ]
  ->all(reduce_errs)
  ->map(Obj.magic)

let both13 = ((a, b, c, d, e, f, g, h, i, j, k, l, m), reduce_errs) =>
  [
    Obj.magic(a),
    Obj.magic(b),
    Obj.magic(c),
    Obj.magic(d),
    Obj.magic(e),
    Obj.magic(f),
    Obj.magic(g),
    Obj.magic(h),
    Obj.magic(i),
    Obj.magic(j),
    Obj.magic(k),
    Obj.magic(l),
    Obj.magic(m),
  ]
  ->all(reduce_errs)
  ->map(Obj.magic)

let both14 = ((a, b, c, d, e, f, g, h, i, j, k, l, m, n), reduce_errs) =>
  [
    Obj.magic(a),
    Obj.magic(b),
    Obj.magic(c),
    Obj.magic(d),
    Obj.magic(e),
    Obj.magic(f),
    Obj.magic(g),
    Obj.magic(h),
    Obj.magic(i),
    Obj.magic(j),
    Obj.magic(k),
    Obj.magic(l),
    Obj.magic(m),
    Obj.magic(n),
  ]
  ->all(reduce_errs)
  ->map(Obj.magic)

let both15 = ((a, b, c, d, e, f, g, h, i, j, k, l, m, n, o), reduce_errs) =>
  [
    Obj.magic(a),
    Obj.magic(b),
    Obj.magic(c),
    Obj.magic(d),
    Obj.magic(e),
    Obj.magic(f),
    Obj.magic(g),
    Obj.magic(h),
    Obj.magic(i),
    Obj.magic(j),
    Obj.magic(k),
    Obj.magic(l),
    Obj.magic(m),
    Obj.magic(n),
    Obj.magic(o),
  ]
  ->all(reduce_errs)
  ->map(Obj.magic)

let both16 = ((a, b, c, d, e, f, g, h, i, j, k, l, m, n, o, p), reduce_errs) =>
  [
    Obj.magic(a),
    Obj.magic(b),
    Obj.magic(c),
    Obj.magic(d),
    Obj.magic(e),
    Obj.magic(f),
    Obj.magic(g),
    Obj.magic(h),
    Obj.magic(i),
    Obj.magic(j),
    Obj.magic(k),
    Obj.magic(l),
    Obj.magic(m),
    Obj.magic(n),
    Obj.magic(o),
    Obj.magic(p),
  ]
  ->all(reduce_errs)
  ->map(Obj.magic)
