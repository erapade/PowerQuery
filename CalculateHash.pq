(x as text) as text =>
  Binary.ToText(
    Binary.FromList(
      List.FirstN(
        List.LastN(
          Binary.ToList(Binary.Compress(Text.ToBinary(x, BinaryEncoding.Base64), Compression.GZip)),
          8
        ),
        4
      )
    ),
    BinaryEncoding.Hex
  )
