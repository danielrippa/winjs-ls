
  do ->

    { native-type: n, native-type-name: type-name } = dependency 'NativeTypes'
    { array-as-object } = dependency 'NativeArray'

    p = primitive-type = array-as-object <[ Str Null Fieldset Num NaN List Bool Fn Void Tuple Exception ]>

    primitive-type-name = (value) ->

      switch type-name value

        | n.String => p.Str
        | n.Object, n.Error =>
          switch value
            | null => p.Null
            else p.Fieldset
        | n.Number =>
          switch value
            | value => p.Num
            else p.NaN
        | n.Array, n.Arguments => p.List
        | n.Boolean => p.Bool
        | n.Function => p.Fn
        | n.Undefined => p.Void

        else that

    container-type-name = (container) ->

      type = void

      for value in container

        if type is void

          type = type-name value
          continue

        return p.Tuple \
          if type isnt type-name value

      p.List

    {
      primitive-type, primitive-type-name,
      container-type-name
    }