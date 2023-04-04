
  do ->

    { new-braille-char } = dependency 'BrailleChar'

    max-strings-length = (strings) ->

      max-length = 0

      for string in strings

        if (string.length - 1) > max-length
          max-length = string.length - 1

      max-length

    new-braille-string = (length) ->

      chars = [ (new-braille-char!) for til length ]

      index = -> Math.floor it / 2

      get-char = (y) -> chars[index y]
      get-char-y = (y) -> y - (index y) * 2

      ##

      get: (x, y) -> char = get-char y ; char.get x, get-char-y y

      set: (x, y, bit = on) -> char = get-char y ; char.set x, (get-char-y y), bit

      unset: (x, y) -> @set x, y, off

      to-string: -> chars.join ''

    from-string-list = (strings) ->

      result = new-braille-string max-strings-length strings

      for row from 0 to 3

        string = strings[row]

        break if row >= strings.length

        for char, column in string.split ''

          if char is '*'

            result.set row, column

      result

    {
      new-braille-string,
      from-string-list
    }