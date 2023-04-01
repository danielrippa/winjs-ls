
  do ->

    { notes }  = dependency 'MidiNotes'
    { percussion: percussion-instruments } = dependency 'MidiPercussion'
    { new-instance } = dependency 'Instance'
    { Num } = dependency 'PrimitiveTypes'

    { log } = dependency 'Console'

    instruments = dependency 'MidiInstruments'

    { add-channel, set-channel-instrument, play-percussion: midi-play-percussion, play-channel-note, release-channel-note } = winjs.load-library 'WinjsMidi.dll'

    percussion = do ->

      percussions = {}

      for name, instrument of percussion-instruments

        percussions[name] = Function "midiPlayPercussion(#instrument);"

      percussions

    new-channel = (number, instrument) ->

      Num number ; Num instrument

      add-channel number, instrument

      new-instance do

        number: getter: -> number
        instrument: getter: -> instrument

        play: member: (note) -> Num note ; log @number, note ; play-channel-note @number, note
        release: member: (note) -> Num note ; release-channel-note @number, note

    play-percussion = (instrument) -> Num instrument ; midi-play-percussion instrument

    {
      percussion, new-channel,
      percussion-instruments,
      play-percussion,
      instruments, notes
    }