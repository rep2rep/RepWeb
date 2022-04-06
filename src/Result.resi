include module type of Belt.Result

let mapError: (t<'a, 'b>, 'b => 'c) => t<'a, 'c>

let fromOption: (option<'a>, unit => 'b) => t<'a, 'b>
let toOption: t<'a, _> => option<'a>

let all: (array<t<'a, 'b>>, array<'b> => 'b) => t<array<'a>, 'b>
let allUnit: (array<t<unit, 'b>>, array<'b> => 'b) => t<unit, 'b>

let thenError: (t<'a, 'b>, 'b, array<'b> => 'b) => t<_, 'b>

let both: ((t<'a, 'z>, t<'b, 'z>), array<'z> => 'z) => t<('a, 'b), 'z>
let both3: ((t<'a, 'z>, t<'b, 'z>, t<'c, 'z>), array<'z> => 'z) => t<('a, 'b, 'c), 'z>
let both4: (
  (t<'a, 'z>, t<'b, 'z>, t<'c, 'z>, t<'d, 'z>),
  array<'z> => 'z,
) => t<('a, 'b, 'c, 'd), 'z>
let both5: (
  (t<'a, 'z>, t<'b, 'z>, t<'c, 'z>, t<'d, 'z>, t<'e, 'z>),
  array<'z> => 'z,
) => t<('a, 'b, 'c, 'd, 'e), 'z>
let both6: (
  (t<'a, 'z>, t<'b, 'z>, t<'c, 'z>, t<'d, 'z>, t<'e, 'z>, t<'f, 'z>),
  array<'z> => 'z,
) => t<('a, 'b, 'c, 'd, 'e, 'f), 'z>
let both7: (
  (t<'a, 'z>, t<'b, 'z>, t<'c, 'z>, t<'d, 'z>, t<'e, 'z>, t<'f, 'z>, t<'g, 'z>),
  array<'z> => 'z,
) => t<('a, 'b, 'c, 'd, 'e, 'f, 'g), 'z>
let both8: (
  (t<'a, 'z>, t<'b, 'z>, t<'c, 'z>, t<'d, 'z>, t<'e, 'z>, t<'f, 'z>, t<'g, 'z>, t<'h, 'z>),
  array<'z> => 'z,
) => t<('a, 'b, 'c, 'd, 'e, 'f, 'g, 'h), 'z>
let both9: (
  (
    t<'a, 'z>,
    t<'b, 'z>,
    t<'c, 'z>,
    t<'d, 'z>,
    t<'e, 'z>,
    t<'f, 'z>,
    t<'g, 'z>,
    t<'h, 'z>,
    t<'i, 'z>,
  ),
  array<'z> => 'z,
) => t<('a, 'b, 'c, 'd, 'e, 'f, 'g, 'h, 'i), 'z>
let both10: (
  (
    t<'a, 'z>,
    t<'b, 'z>,
    t<'c, 'z>,
    t<'d, 'z>,
    t<'e, 'z>,
    t<'f, 'z>,
    t<'g, 'z>,
    t<'h, 'z>,
    t<'i, 'z>,
    t<'j, 'z>,
  ),
  array<'z> => 'z,
) => t<('a, 'b, 'c, 'd, 'e, 'f, 'g, 'h, 'i, 'j), 'z>
let both11: (
  (
    t<'a, 'z>,
    t<'b, 'z>,
    t<'c, 'z>,
    t<'d, 'z>,
    t<'e, 'z>,
    t<'f, 'z>,
    t<'g, 'z>,
    t<'h, 'z>,
    t<'i, 'z>,
    t<'j, 'z>,
    t<'k, 'z>,
  ),
  array<'z> => 'z,
) => t<('a, 'b, 'c, 'd, 'e, 'f, 'g, 'h, 'i, 'j, 'k), 'z>
let both12: (
  (
    t<'a, 'z>,
    t<'b, 'z>,
    t<'c, 'z>,
    t<'d, 'z>,
    t<'e, 'z>,
    t<'f, 'z>,
    t<'g, 'z>,
    t<'h, 'z>,
    t<'i, 'z>,
    t<'j, 'z>,
    t<'k, 'z>,
    t<'l, 'z>,
  ),
  array<'z> => 'z,
) => t<('a, 'b, 'c, 'd, 'e, 'f, 'g, 'h, 'i, 'j, 'k, 'l), 'z>
let both13: (
  (
    t<'a, 'z>,
    t<'b, 'z>,
    t<'c, 'z>,
    t<'d, 'z>,
    t<'e, 'z>,
    t<'f, 'z>,
    t<'g, 'z>,
    t<'h, 'z>,
    t<'i, 'z>,
    t<'j, 'z>,
    t<'k, 'z>,
    t<'l, 'z>,
    t<'m, 'z>,
  ),
  array<'z> => 'z,
) => t<('a, 'b, 'c, 'd, 'e, 'f, 'g, 'h, 'i, 'j, 'k, 'l, 'm), 'z>
let both14: (
  (
    t<'a, 'z>,
    t<'b, 'z>,
    t<'c, 'z>,
    t<'d, 'z>,
    t<'e, 'z>,
    t<'f, 'z>,
    t<'g, 'z>,
    t<'h, 'z>,
    t<'i, 'z>,
    t<'j, 'z>,
    t<'k, 'z>,
    t<'l, 'z>,
    t<'m, 'z>,
    t<'n, 'z>,
  ),
  array<'z> => 'z,
) => t<('a, 'b, 'c, 'd, 'e, 'f, 'g, 'h, 'i, 'j, 'k, 'l, 'm, 'n), 'z>
let both15: (
  (
    t<'a, 'z>,
    t<'b, 'z>,
    t<'c, 'z>,
    t<'d, 'z>,
    t<'e, 'z>,
    t<'f, 'z>,
    t<'g, 'z>,
    t<'h, 'z>,
    t<'i, 'z>,
    t<'j, 'z>,
    t<'k, 'z>,
    t<'l, 'z>,
    t<'m, 'z>,
    t<'n, 'z>,
    t<'o, 'z>,
  ),
  array<'z> => 'z,
) => t<('a, 'b, 'c, 'd, 'e, 'f, 'g, 'h, 'i, 'j, 'k, 'l, 'm, 'n, 'o), 'z>
let both16: (
  (
    t<'a, 'z>,
    t<'b, 'z>,
    t<'c, 'z>,
    t<'d, 'z>,
    t<'e, 'z>,
    t<'f, 'z>,
    t<'g, 'z>,
    t<'h, 'z>,
    t<'i, 'z>,
    t<'j, 'z>,
    t<'k, 'z>,
    t<'l, 'z>,
    t<'m, 'z>,
    t<'n, 'z>,
    t<'o, 'z>,
    t<'p, 'z>,
  ),
  array<'z> => 'z,
) => t<('a, 'b, 'c, 'd, 'e, 'f, 'g, 'h, 'i, 'j, 'k, 'l, 'm, 'n, 'o, 'p), 'z>
