module type Intf = {
  type t
  type request
  type response

  let create: string => t
  let listen: (t, response => unit) => unit
  let post: (t, request) => unit
  let terminate: t => unit

  module WorkerThread: {
    let create: (request => response) => unit

    let listen: (request => unit) => unit
    let respond: response => unit
  }
}

module type Request_Intf = {
  type t
  let toJson: t => Js.Json.t
  let fromJson: Js.Json.t => Or_error.t<t>
}
module type Response_Intf = {
  type t
  let toJson: t => Js.Json.t
  let fromJson: Js.Json.t => Or_error.t<t>
}

module Make: (Request: Request_Intf, Response: Response_Intf) =>
(Intf with type request = Request.t and type response = Response.t) = (
  Request: Request_Intf,
  Response: Response_Intf,
) => {
  type t
  type request = Request.t
  type response = Response.t

  type message
  @get external data: message => string = "data"

  @new external create: string => t = "Worker"
  @send external addEventListener: (t, string, message => unit) => unit = "addEventListener"
  let listen = (t, callback) =>
    addEventListener(t, "message", msg =>
      msg->data->Js.Json.parseExn->Response.fromJson->Or_error.iter(callback)
    )
  @send external postMessage: (t, string) => unit = "postMessage"
  let post = (t, request) => {
    let req = Request.toJson(request)->Js.Json.stringify
    t->postMessage(req)
  }
  @send external terminate: t => unit = "terminate"

  module WorkerThread = {
    type this
    @val external this: this = "this"
    @set external onmessage: (this, message => unit) => unit = "onmessage"
    @val external postMessage: string => unit = "postMessage"

    @inline
    let listen = callback =>
      this->onmessage(msg => msg->data->Js.Json.parseExn->Request.fromJson->Or_error.iter(callback))
    @inline let respond = response => response->Response.toJson->Js.Json.stringify->postMessage

    @inline let create = callback => listen(request => request->callback->respond)
  }
}
