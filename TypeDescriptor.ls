
  do ->

    { primitive-type-name, container-type-name, primitive-type: p } = dependency 'PrimitiveType'
    { circumfix, affix } = dependency 'NativeString'
    { map-array } = dependency 'NativeArray'

    space-pad = (value = '') -> value `affix` if value is '' then '' else ' '

    square-brackets = -> it `circumfix` <[ [ ] ]>

    angle-brackets = -> it `circumfix` <[ < > ]>

    type-brackets = -> it |> space-pad |> square-brackets |> angle-brackets

    list-items-type-descriptor = (items) ->

      switch items.length
        | 0 => '*'
        else primitive-type-name items.0

    tuple-elements-type-descriptor = (elements) -> map-array elements, type-descriptor |> (.join ',')

    container-type-descriptor = (type, values) ->

      container-type = container-type-name values

      values-type-descriptor = switch container-type
        | p.List => list-items-type-descriptor values
        | p.Tuple => tuple-elements-type-descriptor values

      "#container-type#{ values-type-descriptor |> type-brackets }"

    fieldset-type-descriptor = (type, fieldset) ->

      "#type#{ object-as-array _ , member-as-type-descriptor |> (.join ',') |> type-brackets }"

    type-descriptor = (value) ->

      switch primitive-type-name value

        | p.List => container-type-descriptor that, value
        | p.Fieldset => fieldset-type-descriptor that, value

        else that

    {
      type-descriptor
    }