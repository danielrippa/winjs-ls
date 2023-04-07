
  { wasm } = dependency 'Wasm'
  { console } = dependency 'Console'

  { index-one, byte-array } = wasm 'wasm-example.wasm'

  console.writeln index-one!

  byte-array[1] = 15

  console.writeln index-one!