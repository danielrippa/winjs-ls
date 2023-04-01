
  do ->

    seconds-as-ms = -> it * 1000
    minutes-as-ms = -> 60 * seconds-as-ms it
    hours-as-ms = -> 60 * minutes-as-ms it

    days-as-ms = -> 24 * hours-as-ms it

    new-time-duration = (days = 0, hours = 0, minutes = 0, seconds = 0, milliseconds = 0) ->

      as-milliseconds = ->

        milliseconds \
        + (seconds-as-ms seconds) \
        + (minutes-as-ms minutes) \
        + (hours-as-ms hours) \
        + (days-as-ms days)

      { hours, minutes, seconds, milliseconds, as-milliseconds }

    {
      new-time-duration
    }