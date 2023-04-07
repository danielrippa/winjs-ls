
  do ->

    string-as-byte-array = (string) -> [ (char.char-code-at 0) for char in string.split '' ]

    new-wasm-instance = (filename) ->

      byte-array = string-as-byte-array winjs.load-wasm filename

      module = new WebAssembly.Module new Uint8Array byte-array

      new WebAssembly.Instance module

    wasm = ->

      result = {}

      instance = new-wasm-instance it

      result <<< instance.exports

      result <<< byte-array: new Uint8Array instance.exports.memory.buffer

    {
      new-wasm-instance,
      wasm
    }
