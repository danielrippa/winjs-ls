
  do ->

    { camelize } = dependency 'NativeString'

    array-as-object = (array) -> { [ (camelize value), value ] for value in array }

    arrays-as-object = (names, values) -> { [ name, values[index] ] for name, index in names }

    map-array = (array, fn) -> [ (fn item) for item in array ]

    filter-array = (array, fn) -> [ value for value, index in array when fn value, index ]

    fold-array = (array, memento, fn) ->

      for value, index in array => memento = fn array, memento, value, index
      memento

    id = -> it

    find-in-array = (array, pred, fn = id) ->

      for value, index in array when pred value, index => return fn value, index
      void

    {
      array-as-object, arrays-as-object,
      map-array,
      filter-array,
      fold-array,
      find-in-array
    }