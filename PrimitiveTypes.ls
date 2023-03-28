
  do ->

    { Type, Maybe } = dependency 'Type'

    Str = !-> Type <[ Str ]> it
    MaybeStr = !-> Maybe <[ Str ]> it

    Num = !-> Type <[ Num ]> it
    MaybeNum = !-> Maybe <[ Num ]> it

    Fieldset = !-> Type <[ Fieldset ]> it
    MaybeFieldset = !-> Maybe <[ Fieldset ]> it

    List = !-> Type <[ List ]> it
    MaybeList = !-> Maybe <[ List ]> it

    Fn = !-> Type <[ Fn ]> it
    MaybeFn = !-> Maybe <[ Fn ]> it

    Bool = !-> Type <[ Bool ]> it
    MaybeBool = !-> Maybe <[ Bool ]> it

    {
      Str, MaybeStr,
      Num, MaybeNum,
      Fieldset, MaybeFieldset,
      List, MaybeList,
      Fn, MaybeFn,
      Bool, MaybeBool
    }
