@react.component
let make: (
  ~id: string,
  ~style: ReactDOM.Style.t,
  ~toggle: (~hidden: bool) => React.element,
  ~ref_: ReactDOM.domRef=?,
  ~className: string=?,
  ~children: React.element,
) => React.element
