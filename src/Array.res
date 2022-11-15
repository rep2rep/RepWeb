include Belt.Array

let t_rpc = Rpc.Datatype.array_

let hash = Hash.fromArray

let toJson = (t, jsonify) => t->map(jsonify)->Js.Json.array
let fromJson = (j, decode) =>
  j
  ->Js.Json.decodeArray
  ->Or_error.fromOption_s("JSON is not a valid array (reading array)")
  ->Or_error.flatMap(arr =>
    arr->reduce(Or_error.create([]), (xs, x) =>
      xs->Or_error.flatMap(xs => decode(x)->Or_error.map(x => concat(xs, [x])))
    )
  )

let singleton = a => [a]
@new external _makeArrayOfSize: int => array<'a> = "Array"
let repeat = (a, n) => {
  let t = _makeArrayOfSize(n)
  Js.Array2.fillInPlace(t, a)
}
let joinWith = Js.Array2.joinWith
let filter = Js.Array2.filter
let find = Js.Array2.find
let includes = Js.Array2.includes
let flatMap = (t, f) => map(t, f)->concatMany
let flatMapWithIndex = (t, f) => mapWithIndex(t, f)->concatMany
let mapPartial = (t, f) =>
  t->reduce([], (arr, x) =>
    switch f(x) {
    | Some(y) => concat(arr, [y])
    | None => arr
    }
  )
let dedup = %raw("a => [...new Set(a)]")
let splitAt = (t, x) => {
  let before = t->slice(~offset=0, ~len=x)
  let after = t->sliceToEnd(x)
  (before, after)
}

let push = (t, a) => concat(t, [a])
let pop = t => (t->getUnsafe(t->length - 1), t->slice(~offset=0, ~len=t->length - 1))
let last = t => t->getUnsafe(t->length - 1)
