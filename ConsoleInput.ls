
  do ->

    # TODO: implement echo-input-enabled, insert-mode-enabled, line-input-enabled, mouse-input-enabled, processed-input-enabled, window-input-enabled

    { new-instance } = dependency 'Instance'
    { camelize } = dependency 'NativeString'

    { input: wci } = winjs.load-library 'WinjsConsole.dll'

    notification-types = <[

      on-window-focus on-window-resized

      on-key-pressed on-key-released

      on-mouse-moved
      on-single-click on-double-click
      on-button-released
      on-vertical-wheel on-horizontal-wheel

    ]>

    new-console-input = ->

      new-instance do

        quick-edit:
          getter: -> wci.is-quick-edit-mode-enabled!
          setter: !-> Bool it ; wci.set-quick-edit-mode it

        input: notifier: notification-types

        notify: member: ->

          input-type = wci.get-input-event-type!
          return if input-type is 'None'

          @input [ camelize "on-#input-type" ], wci.[ camelize "get-#{input-type}-event" ]!

    console-input = new-console-input!

    {
      new-console-input,
      console-input
    }