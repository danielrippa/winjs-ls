
  do ->

    { file-as-str-list } = dependency 'TextFile'
    { str-list-as-fieldset } = dependency 'Dictionary'
    { Str } = dependency 'PrimitiveTypes'

    file-as-fieldset = (filename) -> Str filename ; file-as-str-list filename |> str-list-as-fieldset

    {
      file-as-fieldset
    }