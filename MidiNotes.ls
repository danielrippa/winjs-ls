
  do ->

    { new-enumeration } = dependency 'Enumeration'
    { arrays-as-object } = dependency 'NativeObject'

    basic-note-names = <[ C Db D Eb E F Gb G Ab A Bb B ]>

    note-names = []

    for octave from 0 to 9

      for note in basic-note-names

        note-names[*] = "#note#octave"

    notes = new-enumeration note-names, 12

    alternate-note-names = <[ Cs Ds Fs Gs As ]>

    alternate-notes = arrays-as-object alternate-note-names, [ 13 15 18 20 22 ]

    delta = 12

    for octave from 0 to 9

      for note, midi of alternate-notes

        notes["#note#octave"] = midi + (delta * octave)

    {
      notes
    }
