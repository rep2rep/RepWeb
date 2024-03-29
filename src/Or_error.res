type t<'a> =
  | Ok('a, array<Error.Tag.t>)
  | Err(Error.t)

let isOk = t =>
  switch t {
  | Ok(_, _) => true
  | Err(_) => false
  }
let isError = t => !isOk(t)

let create = a => Ok(a, [])
let error = err => Err(err)
let error_s = s => Err(Error.fromString(s))
let error_ss = ss => Err(Error.fromStrings(ss))

let pretag = (t, tags') =>
  switch t {
  | Ok(a, tags) => Ok(a, Js.Array2.concat(tags', tags))
  | Err(e) => Error._pretag(e, tags')->error
  }

let tag = (t, tag) =>
  switch t {
  | Ok(a, tags) => Ok(a, Js.Array2.concat(tags, [Error.Tag.fromString(tag)]))
  | Err(e) => Error.tag(e, tag)->error
  }

let tags = t =>
  switch t {
  | Ok(_, tags) => tags
  | Err(e) => Error.tags(e)
  }

let messages = t =>
  switch t {
  | Ok(_, _) => None
  | Err(e) => Some(Error.messages(e))
  }

let map = (t, f) =>
  switch t {
  | Ok(a, tags) => Ok(f(a), tags)
  | Err(e) => Err(e)
  }

let flatMap = (t, f) =>
  switch t {
  | Ok(a, tags) => f(a)->pretag(tags)
  | Err(e) => Err(e)
  }

let flatten = tt => flatMap(tt, t => t)

let iter = (t, f) =>
  switch t {
  | Ok(a, _) => f(a)
  | Err(_) => ()
  }

let okExn = t =>
  switch t {
  | Ok(a, _) => a
  | Err(e) => Error.raise_(e)
  }

let okExnWithTags = t =>
  switch t {
  | Ok(a, _) => a
  | Err(e) => Error.raiseWithTags(e)
  }

let valOf = t =>
  switch t {
  | Ok(a, _) => Some(a)
  | Err(_) => None
  }

let getWithDefault = (t, default) =>
  switch t {
  | Ok(a, _) => a
  | Err(_) => default
  }

let throwIfError = t =>
  switch t {
  | Ok(_, _) => t
  | Err(e) => Error.raise_(e)
  }

let both = ts =>
  switch ts {
  | (Ok(a, tags), Ok(b, tags')) => Ok((a, b), Js.Array2.concat(tags, tags'))
  | (Err(e), Err(e')) => Err(Error.join(e, e'))
  | (Err(e), Ok(_, tags)) => Err(Error._posttag(e, tags))
  | (Ok(_, tags), Err(e)) => Err(Error._pretag(e, tags))
  }

let rec all = ts =>
  switch ts {
  | list{} => Ok(list{}, [])
  | list{a, ...rest} =>
    switch both((a, all(rest))) {
    | Ok((a, rest), tags) => Ok(Belt.List.add(rest, a), tags)
    | Err(e) => Err(e)
    }
  }

let allArray = ts =>
  ts->Belt.Array.reduce(Ok([], []), (ys, x) =>
    both((ys, x))->map(((ys, x)) => Belt.Array.concat(ys, [x]))
  )

let rec allUnit = ts =>
  switch ts {
  | list{} => Ok((), [])
  | list{a, ...rest} =>
    switch both((a, allUnit(rest))) {
    | Ok(((), ()), tags) => Ok((), tags)
    | Err(e) => Err(e)
    }
  }

let toOption = valOf
let fromOption = (opt, err) =>
  switch opt {
  | Some(a) => Ok(a, [])
  | None => Err(err)
  }

let fromOption_s = (opt, err_s) => fromOption(opt, Error.fromString(err_s))
let fromOption_ss = (opt, err_ss) => fromOption(opt, Error.fromStrings(err_ss))

let toBool = t => Some() == valOf(t)
let fromBool = (b, err) =>
  if b {
    Ok((), [])
  } else {
    Err(err)
  }

let fromBool_s = (opt, err_s) => fromBool(opt, Error.fromString(err_s))
let fromBool_ss = (opt, err_ss) => fromBool(opt, Error.fromStrings(err_ss))

let toResult = t =>
  switch t {
  | Ok(a, _) => Belt.Result.Ok(a)
  | Err(e) => Belt.Result.Error(e)
  }

let tags_to_json = tags => Js.Json.array(tags->Js.Array2.map(Error.Tag.toJson))
let tags_from_json = json =>
  json
  ->Js.Json.decodeArray
  ->fromOption_s("JSON tag array not array in Or_error.t")
  ->map(arr =>
    arr->Js.Array2.map(j => j->Error.Tag.fromJson->fromOption_s("JSON is not a Tag in Or_error.t"))
  )
  ->flatMap(a => a->Belt.List.fromArray->all->map(Belt.List.toArray))

let toJson = (t, jsonify) =>
  switch t {
  | Ok(a, tags) => Js.Json.array([Js.Json.string("Ok"), jsonify(a), tags_to_json(tags)])
  | Err(err) => Js.Json.array([Js.Json.string("Err"), Error.toJson(err), Js.Json.array([])])
  }

let fromJson = (json, decode) => {
  let decode_err = Error.fromString("JSON not a valid Or_error.t")
  switch Js.Json.decodeArray(json) {
  | Some([s, j, m]) =>
    switch Js.Json.decodeString(s) {
    | Some("Ok") => both((decode(j), tags_from_json(m)))->map(((v, t)) => Ok(v, t))
    | Some("Err") => Error.fromJson(j)->fromOption(decode_err)->map(error)
    | _ => error(decode_err)
    }
  | _ => error(decode_err)
  }
}

let toString = (t, stringify) =>
  switch t {
  | Ok(a, _) => stringify(a)
  | Err(e) => Error.toString(e)
  }

let both3 = ts =>
  switch ts {
  | (Ok(a, t1), Ok(b, t2), Ok(c, t3)) => Ok((a, b, c), Js.Array2.concatMany(t1, [t2, t3]))
  | (Err(e1), Err(e2), Err(e3)) => Err(Error.concat(list{e1, e2, e3}))
  | (Err(e1), Err(e2), Ok(_, t3)) => Err(Error.join(e1, e2)->Error._posttag(t3))
  | (Err(e1), Ok(_, t2), Err(e3)) => Err(Error.join(Error._posttag(e1, t2), e3))
  | (Ok(_, t1), Err(e2), Err(e3)) => Err(Error.join(e2, e3)->Error._pretag(t1))
  | (Err(e), Ok(_, t2), Ok(_, t3)) => Err(Error._posttag(e, Js.Array2.concat(t2, t3)))
  | (Ok(_, t1), Err(e), Ok(_, t3)) => Err(Error._pretag(e, t1)->Error._posttag(t3))
  | (Ok(_, t1), Ok(_, t2), Err(e)) => Err(Error._pretag(e, Js.Array2.concat(t1, t2)))
  }

let both4 = ((a, b, c, d)) =>
  both((both((a, b)), both((c, d))))->map((((a, b), (c, d))) => (a, b, c, d))

let both5 = ((a, b, c, d, e)) =>
  both((both((a, b)), both3((c, d, e))))->map((((a, b), (c, d, e))) => (a, b, c, d, e))

let both6 = ((a, b, c, d, e, f)) =>
  both((both3((a, b, c)), both3((d, e, f))))->map((((a, b, c), (d, e, f))) => (a, b, c, d, e, f))

let both7 = ((a, b, c, d, e, f, g)) =>
  both((both3((a, b, c)), both4((d, e, f, g))))->map((((a, b, c), (d, e, f, g))) => (
    a,
    b,
    c,
    d,
    e,
    f,
    g,
  ))

let both8 = ((a, b, c, d, e, f, g, h)) =>
  both((both4((a, b, c, d)), both4((e, f, g, h))))->map((((a, b, c, d), (e, f, g, h))) => (
    a,
    b,
    c,
    d,
    e,
    f,
    g,
    h,
  ))

let both9 = ((a, b, c, d, e, f, g, h, i)) =>
  both((both4((a, b, c, d)), both5((e, f, g, h, i))))->map((((a, b, c, d), (e, f, g, h, i))) => (
    a,
    b,
    c,
    d,
    e,
    f,
    g,
    h,
    i,
  ))

let both10 = ((a, b, c, d, e, f, g, h, i, j)) =>
  both((both5((a, b, c, d, e)), both5((f, g, h, i, j))))->map(((
    (a, b, c, d, e),
    (f, g, h, i, j),
  )) => (a, b, c, d, e, f, g, h, i, j))

let both11 = ((a, b, c, d, e, f, g, h, i, j, k)) =>
  both3((both4((a, b, c, d)), both4((e, f, g, h)), both3((i, j, k))))->map(((
    (a, b, c, d),
    (e, f, g, h),
    (i, j, k),
  )) => (a, b, c, d, e, f, g, h, i, j, k))

let both12 = ((a, b, c, d, e, f, g, h, i, j, k, l)) =>
  both3((both4((a, b, c, d)), both4((e, f, g, h)), both4((i, j, k, l))))->map(((
    (a, b, c, d),
    (e, f, g, h),
    (i, j, k, l),
  )) => (a, b, c, d, e, f, g, h, i, j, k, l))

let both13 = ((a, b, c, d, e, f, g, h, i, j, k, l, m)) =>
  both3((both4((a, b, c, d)), both4((e, f, g, h)), both5((i, j, k, l, m))))->map(((
    (a, b, c, d),
    (e, f, g, h),
    (i, j, k, l, m),
  )) => (a, b, c, d, e, f, g, h, i, j, k, l, m))

module Match = {
  type match<'a> =
    | Ok('a)
    | Err(Error.t)
}

let match = t =>
  switch t {
  | Ok(a, _) => Match.Ok(a)
  | Err(e) => Match.Err(e)
  }

include Match
