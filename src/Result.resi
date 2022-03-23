include module type of Belt.Result

let mapError: (t<'a, 'b>, 'b => 'c) => t<'a, 'c>

let fromOption: (option<'a>, unit => 'b) => t<'a, 'b>
let toOption: t<'a, _> => option<'a>
