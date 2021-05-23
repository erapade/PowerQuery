(Table as table, optional isPrimary as logical) as list =>
  let
    TempTable = Table.FromRecords(Table.Keys(Table)),
    SelectedKeys = Table.SelectRows(
      TempTable,
      each if isPrimary <> null then [Primary] = isPrimary else true
    ),
    KeyList = List.Union(SelectedKeys[Columns])
  in
    KeyList
