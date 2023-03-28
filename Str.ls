
  do ->

    { Str, List, MaybeStr } = dependency 'PrimitiveTypes'
    { Either } = dependency 'Type'

    NativeString = dependency 'NativeString'

    empty = -> Str it ; NativeString.is-empty it

    not-empty = -> not empty it

    char = utf16-as-char = -> String.from-char-code it
    char-as-utf16 = -> it.char-code-at 0

    #

    control-code-names = <[ nul soh stx etx eot enq ack bel bs ht lf vt ff cr so si dle dc1 dc2 dc3 dc4 nak syn etb can em sub esc fs gs rs us ]>
    cc = ascii-control-code = { [ name, char index ] for name,index in control-code-names } <<< del: char 127

    { cr, lf, ff } = ascii-control-code

    crlf = "#cr#lf"

    ascii-control-code <<< { crlf }

    #

    ss = ascii-string-separator =

      unit: cc.us
      record: cc.rs
      group: cc.gs
      file: cc.fs

    replace = (string, [pattern, replacement]) -> pattern `string.replace` replacement

    replace-all = (string, pattern, replacement) ->

      loop

        break if (string.index-of pattern) is -1
        string = replace string, [ pattern, replacement ]

      string

    rep = -> it `replace` [ &1, cc.rs ]

    replace-crlf = -> it `rep` /\r\n/g
    replace-lf   = -> it `rep` /\n/g
    replace-cr   = -> it `rep` /\r/g
    replace-ff   = -> it `rep` /\f/g

    ``// Text is a Str that may contain crlf, lf, cr, ff``
    ``// Records is a Str that may contain unit, record, group, file``

    text-as-records = -> Str it ; it |> replace-crlf |> replace-lf |> replace-cr |> replace-ff
    records-as-list  = -> Str it ; it.split cc.rs

    text-as-list   = -> Str it ; it |> text-as-records |> records-as-list
    list-as-text = (list, separator = crlf) -> List list ; Str separator ; list.join separator

    #

    ns = NativeString

    ucase = -> Str it ; it |> ns.ucase
    lcase = -> Str it ; it |> ns.lcase

    camelize = -> Str it ; it |> ns.camelize
    dasherize = -> Str it ; it |> ns.dasherize

    {
      empty, not-empty,
      Str, MaybeStr,
      utf16-as-char, char-as-utf16,
      ascii-control-code, ascii-string-separator,
      cr, lf, ff, crlf,
      replace-all,
      text-as-records, records-as-list,
      text-as-list, list-as-text,
      ucase, lcase,
      camelize, dasherize
    }