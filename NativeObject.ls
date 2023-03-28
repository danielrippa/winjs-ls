
  do ->

    arrays-as-object = (names, values) -> { [ name, values[index] ] for name,index in names }

    {
      arrays-as-object
    }