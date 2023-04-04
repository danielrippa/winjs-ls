
  do ->

    { new-instance } = dependency 'Instance'

    new-key-input = (console-input) ->

      key-pressed = <[ on-key-pressed ]>
      key-released = <[ on-key-released ]>

      key-input = new-instance do

        pressed: notifier: key-pressed
        released: notifier: key-released

      console-input

        ..on-key-pressed (key-event) -> key-input.pressed key-pressed, key-event
        ..on-key-released (key-event) -> key-input.released key-released, key-event

      key-input

    {
      new-key-input
    }