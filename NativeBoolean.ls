
  do ->

    { array-as-object } = dependency 'NativeString'

    true-value-names = <[ on yes true ]>
    false-value-names = <[ off no false ]>

    bool-value = array-as-object true-value-names ++ false-value-names

    string-as-boolean = (value) ->

      if value in true-value-names
        return true

      if value in false-value-names
        return false

    {
      string-as-boolean
    }

