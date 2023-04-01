
  do ->

    { new-enumeration } = dependency 'Enumeration'
    { camelize } = dependency 'NativeString'

    camelized = -> [ (camelize item) for item in it ]

    percussion-names = camelized <[
      acoustic-bass-drum
      bass-drum1
      side-stick
      acoustic-snare
      hand-clap
      electric-snare
      low-floortom
      closed-hi-hat
      high-floor-tom
      pedal-high-hat
      low-tom
      open-high-hat
      low-mid-tom
      high-midtom
      crash-cymbal1
      hightom
      ride-cymbal1
      chinese-cymbal
      ride-bell
      tambourine
      splash-cymbal
      cow-bell
      crash-cymbal2
      vibraslap
      ride-cymbal2
      high-bongo
      low-bongo
      mute-high-conga
      open-high-conga
      low-conga
      high-timbale
      low-timbale
      high-agogo
      low-agogo
      cabasa
      maracas
      short-whistle
      longW-wistle
      short-guiro
      long-guiro
      claves
      highWood-block
      lowWood-block
      mute-cuica
      open-cuica
      mute-triangle
      open-triangle
    ]>

    percussion = new-enumeration percussion-names, 35

    {
      percussion
    }