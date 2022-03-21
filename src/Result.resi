include module type of Belt.Result

let mapError: (t<'a, 'b>, 'b => 'c) => t<'a, 'c>
