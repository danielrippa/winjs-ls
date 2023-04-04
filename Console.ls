
  do ->

    { screen-buffer } = winjs.load-library 'WinjsConsole.dll'
    { get-stdout-handle, get-cursor-location, set-cursor-location, write, set-cursor-visibility, get-cursor-size, set-cursor-size } = screen-buffer
    { new-instance } = dependency 'Instance'
    { Num } = dependency 'PrimitiveTypes'

    console = new-instance do

      handle: getter: -> get-stdout-handle!

      hide-cursor: member: -> set-cursor-visibility @handle, off
      show-cursor: member: -> set-cursor-visibility @handle, on

      cursor-size:
        getter: -> get-cursor-size @handle
        setter: -> Num it ; set-cursor-size @handle, it

      goto: member: (row, column) -> set-cursor-location @handle, row, column

      row:
        getter: -> get-cursor-location @handle .row
        setter: -> Num it ; set-cursor-location @handle, it, @column

      column:
        getter: -> get-cursor-location @handle .column
        setter: -> Num it ; set-cursor-location @handle, @row, it

      write: member: -> write @handle, [ (String arg) for arg in arguments ] * ' '

      writeln: member: -> @goto @row + 1, 0 ; @write ...

    {
      console
    }