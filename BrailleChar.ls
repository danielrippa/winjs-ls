
  do ->

    { new-boolean-matrix } = dependency 'BooleanMatrix'

    unicode = -> 0x2800 + it

    ##

    row-increment = (row, left-value, right-value) ->

      increment = 0

      [ left, right ] = row

      increment += left-value if left
      increment += right-value if right

      increment

    ##

    new-braille-char = ->

      var matrix

      clear = -> matrix := new-boolean-matrix 4 2

      clear!

      #

      get: (x, y) -> matrix.get x, y
      set: (x, y, value = on) !-> matrix.set x, y, value
      unset: (x, y) !-> @set x, y, off

      get-char-code: ->

        char-code = unicode 0

        for index til 4

          row =

            * @get index, 0
              @get index, 1

          increment = switch index

            | 0 => row-increment row, 0x01, 0x08
            | 1 => row-increment row, 0x02, 0x10
            | 2 => row-increment row, 0x04, 0x20
            | 3 => row-increment row, 0x40, 0x80

          char-code += increment

        char-code

      to-string: -> String.from-char-code @get-char-code!

    #

    is-braille-char-code = (char-code) ->

      return false if code < unicode 0
      return false if code > unicode 0xff

    #

    is-braille-char = (char) -> is-braille-char-code char.char-code-at 0

    #

    from-char-code = (char-code) ->

      bits = [ 0x01, 0x02, 0x04, 0x40, 0x08, 0x10, 0x20, 0x80 ]

      char-bits = []

      for bit,index in bits

        char-bits[*] = char-code .&. bit

      result = new-braille-char!

      row = 0 ; column = 0

      for bit in char-bits

        result.set row, column, bit
        row++

        if row >= 4
          column++
          row = 0

      result

    #

    from-char = (char) ->

      char-code = char.char-code-at 0
      return if not is-braille-char-code char-code

      from-char-code char-code

    from-strings = (strings) ->

      char = new-braille-char!

      for string, row in strings

        break if row >= 4

        for bit, column in string.split ''

          continue if column >= 2

          if bit is '*'

            char.set row, column

      char

    {
      new-braille-char,
      from-char, from-char-code,
      from-strings
    }
