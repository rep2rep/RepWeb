@val external alert: string => unit = "alert"
@val external confirm: string => bool = "confirm"
@val external _prompt: (. string, string) => Js.Nullable.t<string> = "prompt"

let prompt = (~description, ~default) => _prompt(. description, default)->Js.Nullable.toOption
