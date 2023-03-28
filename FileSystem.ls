
  do ->

    { Str } = dependency 'PrimitiveTypes'

    FileSystem = winjs.load-library 'WinjsFileSystem.dll'

    { folder-separator: folder, drive-separator: drive, path-separator: path } = FileSystem

    fs = FileSystem

    separators = { folder, drive, path }

    file-exists = -> Str it ; fs.file-exists it

    get-current-folder = -> fs.get-current-folder!
    set-current-folder = -> Str it ; fs.set-current-folder it

    { file-path: fp } = FileSystem

    get-file-name = -> Str it ; fp.get-file-name it
    get-base-name = -> Str it ; fp.get-base-name it
    get-path = -> Str it ; fp.get-path it
    get-folder-path = -> Str it ; fp.get-folder-path it
    get-file-extension = -> Str it ; fp.get-file-extension it
    get-relative-path = -> Str &0 ; Str &1 ; fp.get-relative-path ...

    {
      separators,
      file-exists,
      get-file-name, get-base-name,
      get-path, get-folder-path, get-relative-path
      get-file-extension
    }