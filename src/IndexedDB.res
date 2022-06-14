type t

module Internal = {
  type outer = t

  module IDBOpenRequest = {
    type t<'a>

    type target = {
      errorCode: int,
      result: outer,
    }
    type event = {target: target}

    @set external onError: (t<'a>, event => unit) => unit = "onerror"
    @set external onSuccess: (t<'a>, event => unit) => unit = "onsuccess"
    @set external onUpgradeNeeded: (t<'a>, event => unit) => unit = "onupgradeneeded"
  }

  module IDBRequest = {
    type t<'a>

    type target<'a> = {
      errorCode: int,
      result: 'a,
    }
    type event<'a> = {target: target<'a>}

    @set external onError: (t<'a>, event<'a> => unit) => unit = "onerror"
    @set external onSuccess: (t<'a>, event<'a> => unit) => unit = "onsuccess"
  }

  type transact
  type objstore = {transaction: transact}
  module Transaction = {
    type t = transact

    @set external onComplete: (t, 'event => unit) => unit = "oncomplete"
    @set external onError: (t, 'event => unit) => unit = "onerror"
    @send external objectStore: (t, string) => objstore = "objectStore"
  }

  module ObjectStore = {
    module Index = {
      type t
      type options = {
        unique: bool,
        multiEntry: bool,
      }
    }

    type t = objstore = {transaction: Transaction.t}
    type options = {
      keyPath: string,
      autoIncrement: bool,
    }

    @send external createIndex: (string, string, option<Index.options>) => Index.t = "createIndex"
    @send external add: (t, 'a, option<string>) => IDBRequest.t<'a> = "add"
    @send external put: (t, 'a, option<string>) => IDBRequest.t<'a> = "put"
    @send external delete: (t, string) => IDBRequest.t<unit> = "delete"
    @send external get: (t, string) => IDBRequest.t<'a> = "get"
  }

  type global

  @send external open_: (global, string, int) => IDBOpenRequest.t<t> = "open"

  @set external onError: (outer, 'event => unit) => unit = "onerror"
  @send
  external createObjectStore: (outer, string, option<ObjectStore.options>) => ObjectStore.t =
    "createObjectStore"
  @send
  external transaction: (outer, array<string>, [#read | #readwrite]) => Transaction.t =
    "transaction"
}

@val external indexedDB: Internal.global = "indexedDB"

let open_ = (~name, ~version, ~onUpgradeNeeded) =>
  Promise.make((resolve, reject) => {
    let result = indexedDB->Internal.open_(name, version)
    result->Internal.IDBOpenRequest.onError(e => reject(. e.target.errorCode))
    result->Internal.IDBOpenRequest.onSuccess(e => resolve(. e.target.result))
    result->Internal.IDBOpenRequest.onUpgradeNeeded(e => e.target.result->onUpgradeNeeded)
  })

let createObjectStore = (t, name) => Internal.createObjectStore(t, name, None)->ignore

let onError = (t, f) => Internal.onError(t, f)

let add = (t, ~store, ~key, data) =>
  Promise.make((resolve, reject) => {
    let result =
      t
      ->Internal.transaction([store], #readwrite)
      ->Internal.Transaction.objectStore(store)
      ->Internal.ObjectStore.add(data, Some(key))
    result->Internal.IDBRequest.onError(e => reject(. e.target.errorCode))
    result->Internal.IDBRequest.onSuccess(e => resolve(. e.target.result))
  })

let put = (t, ~store, ~key, data) =>
  Promise.make((resolve, reject) => {
    let result =
      t
      ->Internal.transaction([store], #readwrite)
      ->Internal.Transaction.objectStore(store)
      ->Internal.ObjectStore.put(data, Some(key))
    result->Internal.IDBRequest.onError(e => reject(. e.target.errorCode))
    result->Internal.IDBRequest.onSuccess(e => resolve(. e.target.result))
  })

let get = (t, ~store, ~key) =>
  Promise.make((resolve, reject) => {
    let result =
      t
      ->Internal.transaction([store], #readwrite)
      ->Internal.Transaction.objectStore(store)
      ->Internal.ObjectStore.get(key)
    result->Internal.IDBRequest.onError(e => reject(. e.target.errorCode))
    result->Internal.IDBRequest.onSuccess(e => resolve(. e.target.result))
  })

let delete = (t, ~store, ~key) =>
  Promise.make((resolve, reject) => {
    let result =
      t
      ->Internal.transaction([store], #readwrite)
      ->Internal.Transaction.objectStore(store)
      ->Internal.ObjectStore.delete(key)
    result->Internal.IDBRequest.onError(e => reject(. e.target.errorCode))
    result->Internal.IDBRequest.onSuccess(e => resolve(. e.target.result))
  })
