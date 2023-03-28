
  do ->

    { Str, text-as-list } = dependency 'Str'

    { text-file } = winjs.load-library 'WinjsFileSystem.dll'

    { read: fs-read-textfile } = text-file

    file-as-str = (filename) -> Str filename ; filename |> fs-read-textfile

    file-as-str-list = (filename) -> Str filename ; filename |> file-as-str |> text-as-list

    append-line = -> Str &0 ; Str &1 ; text-file.append-line ...

    {
      file-as-str, file-as-str-list,
      append-line
    }