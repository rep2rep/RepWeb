let alert: string => unit
let confirm: string => bool
let prompt: (~description: string, ~default: string) => option<string>
