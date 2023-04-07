
  do ->

    # https://gist.github.com/Yaffle/5458286

    string-as-bytes = (string) ->

      bytes = []

      l = string.length
      i = 0

      loop

        break unless i < l

        codepoint = string.code-point-at i

        c = 0
        bits = 0

        [ c, bits ] = match codepoint

          | (<= 0x0000007F) => [ 0,  0x00 ]
          | (<= 0x000007FF) => [ 6,  0xc0 ]
          | (<= 0x0000FFFF) => [ 12, 0xe0 ]
          | (<= 0x001FFFFF) => [ 18, 0xf0 ]

        bytes[*] = codepoint .>>. c
        c = c - 6

        loop

          break unless c >= 0

          bytes[*] = 0x80 .|. (
            (codepoint .>>. c) .&. 0xef
          )

        i = i + if codepoint >= 0x10000 then 2 else 1

      bytes

    bytes-as-string = (bytes) ->

      string = ''

      i = 0

      loop

        break unless i < bytes.length

        byte = bytes[i]

        [ needed, codepoint ] = match byte

          | (<= 0x7F) => [ 0, byte .&. 0xff ]
          | (<= 0xDF) => [ 1, byte .&. 0x1f ]
          | (<= 0xEF) => [ 2, byte .&. 0x0f ]
          | (<= 0xF4) => [ 3, byte .&. 0x07 ]

        if bytes.length - i - needed > 0

          k = 0

          loop

            break unless k < needed

            byte = bytes[ i + k + 1 ]
            codepoint = (codepoint .<<. 6) .|. (byte .&. 0x3f)
            k = k + 1

        else

          codepoint = 0xfffd
          needed = bytes.length - i

        string = "#string#{ String.from-code-point codepoint }"

        i = i + needed + 1

      string

    {
      string-as-bytes,
      bytes-as-string
    }