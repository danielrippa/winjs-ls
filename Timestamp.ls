
  do ->

    { new-time-duration } = dependency 'TimeDuration'
    { Num } = dependency 'PrimitiveTypes'

    now-ms = ->

      [ date, time ] = os.now!split ' '
      [ hours, minutes, seconds, milliseconds ] = time.split ':'

      hours = parse-int hours
      minutes = parse-int minutes
      seconds = parse-int seconds
      milliseconds = parse-int milliseconds

      now = new-time-duration 0, hours, minutes, seconds, milliseconds

      now.as-milliseconds!

    {
      now-ms
    }