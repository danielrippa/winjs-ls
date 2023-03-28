
  do ->

    { exec } = winjs.load-library 'WinjsShell.dll'
    { Str, Num, Fn } = dependency 'PrimitiveTypes'
    { ascii-control-code: cc, text-as-list } = dependency 'Str'

    process-priority =

      high: 0
      idle: 1
      normal: 2
      realtime: 3
      below-normal: 4
      above-normal: 5

    execute-process = (executable, parameters, working-directory = '', priority = process-priority.normal, buffer-size = 0, callback = ->) ->

      Str executable ; Str parameters ; Str working-directory ; Num priority ; Num buffer-size ; Fn callback

      exec executable, parameters, working-directory, priority, buffer-size, callback

    new-line-chars = [ cc.cr, cc.lf, cc.ff ]

    emit-process-output-lines = (executable, parameters, working-directory, priority, buffer-size, callback) ->

      incomplete-line = ''

      emit-output-lines = (output) ->

        last-char-is-new-line = (output.char-at output.length - 1) in new-line-chars

        lines = text-as-list output

        if incomplete-line isnt ''
          first-line = lines.shift!
          if first-line is void
            first-line = ''

          callback "#incomplete-line#first-line"
          incomplete-line := ''

        if not last-char-is-new-line
          incomplete-line := lines[*-1]
          if incomplete-line is void
            incomplete-line := ''

          lines.splice -1, 1

        for line in lines => callback line

      execute-process executable, parameters, working-directory, priority, buffer-size, emit-output-lines

    {
      process-priority,
      execute-process,
      emit-process-output-lines
    }