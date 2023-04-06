
  do ->

    arrays-as-object = (names, values) -> { [ name, values[index] ] for name,index in names }

    map-object-values = (object, fn) -> { [ key, (fn value, key, object) ] for key, value of object }

    {
      arrays-as-object,
      map-object-values
    }