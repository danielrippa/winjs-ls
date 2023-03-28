
  do ->

    { Str, MaybeStr, MaybeNum } = dependency 'PrimitiveTypes'
    { execute-process } = dependency 'Process'
    { text-as-list, not-empty } = dependency 'Str'
    { call } = dependency 'NativeFunction'
    { filter-list } = dependency 'List'

    { sleep: process-sleep } = process

    exec = -> call execute-process, arguments

    sleep = (ms) -> MaybeNum ms ; if ms is void => return ; process-sleep ms

    fail = (message, error-code = 1) -> winjs.throw-exception message, error-code

    stdout = !-> process.io.stdout [ (String arg) for arg in arguments  ] * ' '

    stderr = !-> process.io.stderr [ (String arg) for arg in arguments  ] * ' '

    log = !-> stdout '\n' ; stdout.apply null, arguments

    find-file = (pattern = '', location = '', recursive = no, quiet = no) ->

      if pattern is ''
        throw "(Shell.find-file) Pattern cannot be empty"

      r = if recursive
        if location is ''
          throw "(Shell.find-file) Location cannot be empty if recursive is true"
        "/r #location"
      else
        ''

      if not recursive
        if location isnt ''

          pattern = "#location:#pattern"

      q = if quiet then '/q' else ''

      { stdout, exit-status } = execute-process 'where.exe', "#r #q #pattern"

      if exit-status isnt 0
        []
      else
        text-as-list stdout |> filter-list _ , not-empty

    {
      exec, sleep, fail,
      stdout, stderr, log,
      find-file
    }
