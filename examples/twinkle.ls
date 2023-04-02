
  { new-channel, instruments, notes } = dependency 'Midi'
  { log, write } = dependency 'Console'
  { new-scheduler } = dependency 'Scheduler'
  { Num } = dependency 'PrimitiveTypes'

  metronome = new-scheduler!

  bpm = -> Num it ; 60 * 1000 / it

  rhodes = new-channel 1, instruments.piano.rhodes

  score =

    * <[ C C G G A A G . ]>
      <[ F F E E D D C . ]>
      <[ G G F F E E D . ]>
      <[ G G F F E E D . ]>
      <[ C C G G A A G . ]>
      <[ F F E E D D C . ]>

  lyrics =

    * <[ twin kle twin kle li ttle star ]>
      <[ how i won der what you are ]>
      <[ up a bove the world so high ]>
      <[ like a dia mond in the sky ]>
      <[ twin kle twin kle li ttle star ]>
      <[ how i won der what you are ]>

  octave = 3

  verse = 0

  nth-note = 0

  finished = no

  play-score = !->

    note = "#{ score[verse][nth-note] }"

    silence = note is '.'

    note = "#note#octave"

    if not silence
      syllabe = lyrics[verse][nth-note]
      write "#syllabe "
      rhodes.play notes[note]

    if nth-note >= score[verse].length - 1
      nth-note := 0
      verse := verse + 1
      log!
    else
      nth-note := nth-note + 1

    finished := verse > score.length - 1

  metronome.schedule-interval (bpm 100), play-score

  loop

    metronome.tick!

    break if finished

  process.sleep 1500
