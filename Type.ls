
  do ->

    { primitive-type-name, primitive-type: p } = dependency 'PrimitiveType'

    must-be = (value, [ predicate, message ]) !->

      throw "Value (#{ primitive-type-name value }) #value must be #message" \
        unless predicate

    text = -> if (primitive-type-name it) is p.List then it.join ' ' else it

    Type = (descriptor, value) -> type = text descriptor ; value `must-be` [ (type is primitive-type-name value), "of type #type" ]

    Either = (types-descriptor, value) ->

      types = types-descriptor |> text |> (.split ' ')

      actual-type = void
      value-type = primitive-type-name value

      for type in types

        if type is value-type
          actual-type = type
          break

      value `must-be` [ (actual-type isnt void), "any of #{ types.join ',' }" ]

    Maybe = (descriptor, value) -> Either [ descriptor, p.Void ], value

    {
      Type, Either, Maybe
    }