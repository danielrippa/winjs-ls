
  do ->

    { now-ms: now } = dependency 'Timestamp'
    { new-instance } = dependency 'Instance'
    { Num, Fn } = dependency 'PrimitiveTypes'

    ##

    new-schedule = (duration = 0, callback) ->

      Num duration ; Fn callback

      scheduled-on = now!

      elapsed = -> now! - @scheduled-on

      is-due = -> @elapsed! > @duration

      { duration, callback, scheduled-on, elapsed, is-due }

    ##

    new-interval = (duration = 0, callback) ->

      Num duration ; Fn callback

      interval = new-schedule duration, callback

      interval.is-due = ->

        due = @elapsed! > @duration

        if due
          @scheduled-on = @scheduled-on + duration

        due

      interval

    ##

    new-scheduler = ->

      do ->

        schedule-id = 0

        next-id = -> "is#{ schedule-id := schedule-id + 1 }"

        intervals = {} ; timeouts = {}

        schedule = (schedules, schedule-instance) -> id = next-id! ; schedules[id] := schedule-instance ; id

        cancel = -> delete &0[&1]

        ##

        new-instance do

          schedule-interval: member: (ms, callback) -> Num ms ; Fn callback ; schedule intervals, new-interval ms, callback
          schedule-timeout:  member: (ms, callback) -> Num ms ; Fn callback ; schedule timeouts,  new-schedule ms, callback

          cancel-schedule: member: -> cancel intervals, it ; cancel timeouts, it

          tick: member: !->

            for id, interval of intervals

              interval => if ..is-due! => ..callback @

            for id, timeout of timeouts

              timeout => if ..is-due! => ..callback @ ; @cancel-schedule id

    {
      new-scheduler
    }