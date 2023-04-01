
  do ->

    { new-enumeration } = dependency 'Enumeration'
    { camelize } = dependency 'NativeString'

    camelized = -> [ (camelize item) for item in it ]

    piano-names = camelized <[
      acoustic-grand
      bright-acoustic
      electric-grand
      honkyTonk
      rhodes
      chorused
      harpsicord
      clavinet
    ]>

    percussion-names = camelized <[
      celesta
      glockenspiel
      music-box
      vibraphone
      marimba
      xylophone
      tubular-bells
      dulcimer
    ]>

    organ-names = camelized <[
      hammond
      percussive
      rock
      church
      reed
      accordion
      harmonica
      tango-accordion
    ]>

    guitar-names = camelized <[
      acoustic-nylon
      acoustic-steel
      electric-jazz
      electric-clean
      electric-muted
      overdriven
      distortion
      harmonics
    ]>

    bass-names = camelized <[
      acoustic
      electric-finger
      electric-pick
      fretless
      slap1
      slap2
      synth1
      synth2
    ]>

    string-names = camelized <[
      violin
      viola
      cello
      contrabass
      tremolo
      pizzicato
      orchestral-harp
      timpani
    ]>

    ensemble-names = camelized <[
      string1
      string2
      synth1
      synth2
      choir-aahs
      voice-oohs
      synth-voice
      orchestra-hit
    ]>

    brass-names = camelized <[
      trumpet
      trombone
      tuba
      muted-trumpet
      french-horn
      brass-section
      synth1
      synth2
    ]>

    reed-names = camelized <[
      soprano-sax
      alto-sax
      tenor-sax
      baritone-sax
      oboe
      english-horn
      bassoon
      clarinet
    ]>

    pipe-names = camelized <[
      piccolo
      flute
      recorder
      pan-flute
      bottle-blow
      shakuhachi
      whistle
      ocarina
    ]>

    synth-names = camelized <[
      lead-square
      lead-sawtooth
      calliope
      chiff
      charang
      voice
      fifths
      brass-lead
    ]>

    pad-names = camelized <[
      new-age
      warm
      poly-synth
      choir
      bowed
      metallic
      halo
      sweep
    ]>

    sound-effect-names = camelized <[
      guitar-fret
      breath
      seashore
      tweet
      telephone
      helicopter
      applause
      gunshot
    ]>

    piano = new-enumeration piano-names, 0
    percussion = new-enumeration percussion-names, 8
    organ = new-enumeration organ-names, 16
    guitar = new-enumeration guitar-names, 24
    bass = new-enumeration bass-names, 32
    strings = new-enumeration string-names, 40
    ensemble = new-enumeration ensemble-names, 40
    brass = new-enumeration brass-names, 56
    reed = new-enumeration reed-names, 64
    pipe = new-enumeration pipe-names, 72
    synth = new-enumeration synth-names, 80
    pad = new-enumeration pad-names, 88
    sound-effect = new-enumeration sound-effect-names, 120

    {
      piano, percussion, organ, guitar,
      bass, strings, ensemble, brass,
      reed, pipe, synth, pad, sound-effect
    }