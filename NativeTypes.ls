
  do ->

    { array-as-object } = dependency 'NativeArray'

    native-type-name = (value) -> {} |> (.to-string) |> (.call value) |> (.slice 8, -1)

    native-type = array-as-object <[ String Object Number Array Arguments Boolean Function Undefined Error ]>

    {
      native-type-name,
      native-type
    }