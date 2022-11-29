module Make: (
  T: {
    type t
  },
) =>
{
  type t<'a>
  type handle

  let create: (string, T.t) => t<T.t>
  let listen: (string, T.t => unit) => handle
  let remove: handle => unit
  let dispatch: t<T.t> => unit
}
