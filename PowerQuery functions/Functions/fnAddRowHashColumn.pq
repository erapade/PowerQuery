(Source as table, optional columnName as text) as table =>
  let
    CalculateHash = (x as text) as text =>
      Binary.ToText(
        Binary.FromList(
          List.FirstN(
            List.LastN(
              Binary.ToList(
                Binary.Compress(Text.ToBinary(x, BinaryEncoding.Base64), Compression.GZip)
              ),
              8
            ),
            4
          )
        ),
        BinaryEncoding.Hex
      ),
    TableWithRowHash = Table.AddColumn(
      Source,
      if columnName = null then "RowHash" else columnName,
      each CalculateHash(
        Text.Combine(

          //Contatenate all columns as text                                 
          List.Transform(Record.ToList(_), Text.From)
        )
      ),
      type text
    )
  in
    TableWithRowHash
