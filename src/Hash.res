type t = int

type internal = {mutable counter: int}

let internal = {counter: Js.Date.now()->Belt.Float.toInt}
let create = () => {
  let value = internal.counter
  internal.counter = internal.counter + 1
  value
}

let combine = ts => ts->Js.Array2.reduce((a, b) => 2 * a + b, 0)

let s_const = create()
let fromString = s =>
  s
  ->Js.String2.split("")
  ->Js.Array2.reduce(
    (hash, chr) => hash * 31 + chr->Js.String2.charCodeAt(0)->Belt.Int.fromFloat,
    s_const,
  )

@inline
let _read = (t, name) => t->Obj.magic->Js.Dict.unsafeGet(name)

let record1 = (name, f) => {
  let const = create()
  t => [const, fromString(name), t->_read(name)->f]->combine
}
let record2 = ((name1, f1), (name2, f2)) => {
  let const = create()
  t =>
    [const, fromString(name1), t->_read(name1)->f1, fromString(name2), t->_read(name2)->f2]->combine
}
let record3 = ((n1, f1), (n2, f2), (n3, f3)) => {
  let const = create()
  t =>
    [
      const,
      fromString(n1),
      t->_read(n1)->f1,
      fromString(n2),
      t->_read(n2)->f2,
      fromString(n3),
      t->_read(n3)->f3,
    ]->combine
}
let record4 = ((n1, f1), (n2, f2), (n3, f3), (n4, f4)) => {
  let const = create()
  t =>
    [
      const,
      fromString(n1),
      t->_read(n1)->f1,
      fromString(n2),
      t->_read(n2)->f2,
      fromString(n3),
      t->_read(n3)->f3,
      fromString(n4),
      t->_read(n4)->f4,
    ]->combine
}
let record5 = ((n1, f1), (n2, f2), (n3, f3), (n4, f4), (n5, f5)) => {
  let const = create()
  t =>
    [
      const,
      fromString(n1),
      t->_read(n1)->f1,
      fromString(n2),
      t->_read(n2)->f2,
      fromString(n3),
      t->_read(n3)->f3,
      fromString(n4),
      t->_read(n4)->f4,
      fromString(n5),
      t->_read(n5)->f5,
    ]->combine
}
let record6 = ((n1, f1), (n2, f2), (n3, f3), (n4, f4), (n5, f5), (n6, f6)) => {
  let const = create()
  t =>
    [
      const,
      fromString(n1),
      t->_read(n1)->f1,
      fromString(n2),
      t->_read(n2)->f2,
      fromString(n3),
      t->_read(n3)->f3,
      fromString(n4),
      t->_read(n4)->f4,
      fromString(n5),
      t->_read(n5)->f5,
      fromString(n6),
      t->_read(n6)->f6,
    ]->combine
}
let record7 = ((n1, f1), (n2, f2), (n3, f3), (n4, f4), (n5, f5), (n6, f6), (n7, f7)) => {
  let const = create()
  t =>
    [
      const,
      fromString(n1),
      t->_read(n1)->f1,
      fromString(n2),
      t->_read(n2)->f2,
      fromString(n3),
      t->_read(n3)->f3,
      fromString(n4),
      t->_read(n4)->f4,
      fromString(n5),
      t->_read(n5)->f5,
      fromString(n6),
      t->_read(n6)->f6,
      fromString(n7),
      t->_read(n7)->f7,
    ]->combine
}

let record11 = (
  (n1, f1),
  (n2, f2),
  (n3, f3),
  (n4, f4),
  (n5, f5),
  (n6, f6),
  (n7, f7),
  (n8, f8),
  (n9, f9),
  (n10, f10),
  (n11, f11),
) => {
  let const = create()
  t =>
    [
      const,
      fromString(n1),
      t->_read(n1)->f1,
      fromString(n2),
      t->_read(n2)->f2,
      fromString(n3),
      t->_read(n3)->f3,
      fromString(n4),
      t->_read(n4)->f4,
      fromString(n5),
      t->_read(n5)->f5,
      fromString(n6),
      t->_read(n6)->f6,
      fromString(n7),
      t->_read(n7)->f7,
      fromString(n8),
      t->_read(n8)->f8,
      fromString(n9),
      t->_read(n9)->f9,
      fromString(n10),
      t->_read(n10)->f10,
      fromString(n11),
      t->_read(n11)->f11,
    ]->combine
}

let fromInt = i => i
let fromFloat = f => Belt.Int.fromFloat(f)
let fromArray = (arr, f) => arr->Belt.Array.map(f)->combine

let unique = create
