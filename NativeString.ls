
  do ->

    is-empty = -> it.length is 0

    to-case = (.["to#{&1}Case"]!)

    ucase = -> it `to-case` 'Upper'
    lcase = -> it `to-case` 'Lower'

    #

    trim-regex = /^[\s\uFEFF\xA0]+|[\s\uFEFF\xA0]+$/g
    trim = -> trim-regex `it.replace` ''

    #

    camel = -> ucase &1 ? ''
    camel-regex = /[-_]+(.)?/g

    camelize = -> camel-regex `it.replace` camel

    #

    upper-lower-regex = /([^-A-Z])([A-Z]+)/g
    upper-regex = /^([A-Z]+)/

    dash-lower-upper = (, lower, upper) -> "#{ lower }-#{ if upper.length > 1 then upper else lcase upper }"
    replace-upper-lower = -> upper-lower-regex `it.replace` dash-lower-upper
    dash-upper = (, upper) -> if upper.length > 1 then "#upper-" else lcase upper
    replace-upper = -> upper-regex `it.replace` dash-upper

    dasherize = -> it |> replace-upper-lower |> replace-upper

    #

    circumfix = (stem, [ prefix = '', suffix = '' ]) -> "#prefix#stem#suffix"
    affix = (stem, adfix) -> stem `circumfix` [ adfix, adfix ]

    {
      is-empty,
      to-case, lcase, ucase,
      trim,
      camelize, dasherize,
      circumfix, affix
    }