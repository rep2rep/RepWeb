type handle

// useModal returns a handle, a function to show the modal, and a function to close the modal.
let useModal: unit => (handle, React.element => unit, unit => unit)

// Insert the <Modal handle /> element at the end of the main screen.
@react.component
let make: (~handle: handle, ~style: ReactDOM.Style.t=?) => React.element
