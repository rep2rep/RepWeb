type t<'a>

let hash: (t<'a>, 'a => Hash.t) => Hash.t

module Path: {
  type t

  let root: t
  let extend: (t, Gid.t) => t

  module Stable: {
    module V1: {
      type t = t
      let toJson: t => Js.Json.t
      let fromJson: Js.Json.t => Or_error.t<t>
    }
  }
}

let empty: unit => t<'a>

let isEmpty: t<'a> => bool

let map: (t<'a>, 'a => 'b) => t<'b>
let flatten: t<'a> => array<'a>

let insertFile: (t<'a>, ~path: Path.t, ~position: int, 'a) => option<t<'a>>
let removeFile: (t<'a>, 'a => bool) => t<'a>

let newFolder: (t<'a>, ~path: Path.t, ~position: int, ~name: string, ~id: Gid.t) => option<t<'a>>
let folderIsEmpty: (t<'a>, Gid.t) => option<bool>
let folderContents: (t<'a>, Gid.t) => option<t<'a>>
let renameFolder: (t<'a>, Gid.t, string) => t<'a>
let removeFolder: (t<'a>, Gid.t) => t<'a>
let removeFolderAndContents: (t<'a>, Gid.t) => (t<'a>, array<'a>)

let getFilePathAndPosition: (t<'a>, 'a => bool) => option<(Path.t, int)>
let getFolderPathAndPosition: (t<'a>, Gid.t) => option<(Path.t, int)>

module FileOrFolder: {
  type t<'a> =
    | File('a)
    | Folder(string, Gid.t)
    | EndFolder(string, Gid.t)
}

let asFlat: t<'a> => array<FileOrFolder.t<'a>>
let fromFlat: array<FileOrFolder.t<'a>> => t<'a>

module Stable: {
  module V1: {
    type t<'a>

    let toJson: (t<'a>, 'a => Js.Json.t) => Js.Json.t
    let fromJson: (Js.Json.t, Js.Json.t => Or_error.t<'a>) => Or_error.t<t<'a>>
  }

  module V2: {
    type t<'a> = t<'a>

    let toJson: (t<'a>, 'a => Js.Json.t) => Js.Json.t
    let fromJson: (Js.Json.t, Js.Json.t => Or_error.t<'a>) => Or_error.t<t<'a>>
  }
}
