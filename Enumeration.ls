
  do ->

    { List, Num } = dependency 'PrimitiveTypes'

    new-enumeration = (names, initial = 0) -> List names ; Num initial ; { [ name, initial++ ] for name in names }

    {
      new-enumeration
    }