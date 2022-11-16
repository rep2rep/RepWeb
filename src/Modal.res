type handle = (option<React.element>, unit => unit)

let useModal = () => {
  let (modalContent, setModalContent) = React.useState(_ => None)
  let displayModal = React.useCallback1(fill => {
    setModalContent(_ => Some(fill))
  }, [setModalContent])
  let closeModal = React.useCallback1(() => {
    setModalContent(_ => {
      None
    })
  }, [setModalContent])
  React.useMemo3(() => {
    ((modalContent, closeModal), displayModal, closeModal)
  }, (modalContent, closeModal, displayModal))
}

type window
@val external window: window = "window"
@send external addEventListener: (window, string, {..} => unit) => unit = "addEventListener"
@send external removeEventListener: (window, string, {..} => unit) => unit = "removeEventListener"

@send external preventDefault: {..} => unit = "preventDefault"
@send external stopPropagation: {..} => unit = "stopPropagation"

@react.component
let make = (~handle as (fill, closeModal), ~style=?) => {
  React.useEffect(() => {
    let rec handler = e =>
      if e["key"] == "Escape" {
        e->preventDefault
        e->stopPropagation
        window->removeEventListener("keyup", handler)
        closeModal()
      }
    window->addEventListener("keyup", handler)
    Some(() => window->removeEventListener("keyup", handler))
  })
  let shadowboxStyle = ReactDOM.Style.make(
    ~background="rgba(0,0,0,0.7)",
    ~position="fixed",
    ~top="0",
    ~left="0",
    ~width="100vw",
    ~height="100vh",
    ~zIndex="1000",
    (),
  )
  let containerStyle =
    ReactDOM.Style.make(
      ~background="white",
      ~borderRadius="3px",
      ~boxShadow="0px 5px 20px rgba(0,0,0,0.5)",
      ~padding="0.5rem",
      ~position="fixed",
      ~top="50vh",
      ~left="50vw",
      ~transform="translate(-50%, -50%)",
      ~width="400px",
      ~maxWidth="100vw",
      ~height="150px",
      ~maxHeight="100vh",
      (),
    )->ReactDOM.Style.combine(style->Option.getWithDefault(ReactDOM.Style.make()))
  switch fill {
  | None => React.null
  | Some(fill) =>
    <div onClick={_ => closeModal()} style={shadowboxStyle}>
      <div style={containerStyle} onClick={e => ReactEvent.Mouse.stopPropagation(e)}> {fill} </div>
    </div>
  }
}
