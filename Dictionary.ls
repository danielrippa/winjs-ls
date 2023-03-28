
  do ->

    { Str, List } = dependency 'PrimitiveTypes'
    { map-list, head-and-tail } = dependency 'List'
    { camelize } = dependency 'Str'

    word-definition = (str, index) ->

      * str.slice 0, index
        str.slice index + 1

    str-as-word-definition = (str) -> index = str.index-of ' ' ; if index is -1 then [ str, '' ] else word-definition str, index

    str-list-as-dictionary = (str-list) -> List str-list ; str-list `map-list` str-as-word-definition

    dictionary-as-fieldset = (dictionary) -> List dictionary ; { [ (camelize definition.0), definition.1 ] for definition in dictionary }

    str-list-as-fieldset = -> it |> str-list-as-dictionary |> dictionary-as-fieldset

    {
      str-list-as-dictionary,
      dictionary-as-fieldset,
      str-list-as-fieldset
    }