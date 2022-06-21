module Make: (
  D: {
    type t
    let name: t => string
  },
) =>
{
  @react.component
  let make: (
    ~id: string,
    ~title: string,
    ~version: string,
    ~data: FileTree.t<(Gid.t, D.t)>,
    ~active: option<Gid.t>,
    ~importExtensions: array<string>,
    ~onCreate: FileTree.Path.t => unit,
    ~onCreateFolder: FileTree.Path.t => unit,
    ~onDelete: Gid.t => unit,
    ~onDeleteFolder: Gid.t => unit,
    ~onSelect: option<Gid.t> => unit,
    ~onDuplicate: Gid.t => unit,
    ~onChangedName: (Gid.t, string) => unit,
    ~onChangedFolderName: (Gid.t, string) => unit,
    ~onReorder: FileTree.t<Gid.t> => unit,
    ~onImport: (array<File.t>, FileTree.Path.t) => unit,
    ~onExport: Gid.t => unit,
  ) => React.element
}
