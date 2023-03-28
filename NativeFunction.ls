
  do ->

    function-as-string = (fn) ->

      code = fn.to-string!

        range-start = ..index-of '{'
        range-end   = ..last-index-of '}'

      code.slice range-start + 1, range-end - 1

    strings-as-function = ->

      if &1 is void
        parameters = ''
        statements = &0
      else
        parameters = &0
        statements = &1

      " (#parameters) => { #{ statements.join ' ; ' } ; } ; "

    call = (fn, parameters) -> fn.apply null, parameters

    {
      function-as-string,
      strings-as-function,
      call
    }