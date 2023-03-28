
  do ->

    { List, MaybeStr, Fn, MaybeFn, Num } = dependency 'PrimitiveTypes'
    { filter-array, fold-array, find-in-array } = dependency 'NativeArray'

    map-list = (list, fn) -> List list ; Fn fn ; [ (fn item,index) for item,index in list ]

    head = (list, head-size = 1) -> List list ; Num head-size ; if head-size > list.length then list else list.slice 0, head-size

    tail = (list, head-size) -> List list ; Num head-size ; if head-size > list.length then [] else list.slice head-size

    head-and-tail = (list, head-size) -> [ ( list `head` head-size ), (list `tail` head-size) ]

    filter-list = (list, fn) -> List list ; Fn fn ; filter-array list, fn

    fold-list = (list, memento, fn) -> List list ; Fn fn ; fold-array list, memento, fn

    find-in-list = (list, pred, fn) -> List list ; Fn pred ; MaybeFn fn ; find-in-array list, pred, fn

    {
      List, MaybeStr,
      map-list,
      head, tail, head-and-tail,
      filter-list, fold-list, find-in-list
    }