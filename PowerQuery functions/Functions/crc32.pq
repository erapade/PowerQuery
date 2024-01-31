//The original code can be found here: https://gist.github.com/Hugoberry/42c73a587c04ef6559a8497e1c1ca97d
= (StringInput) =>
  let

    /*function for reversing the bits in a 8-bit number*/
    reverse = (x) => Number.Mod(Number.BitwiseAnd((x * 0x0202020202), 0x010884422010), 1023),
    /*function for reversing the bits in a 32-bit number*/
    reverse32 = (x) =>
      let
        b0 = Number.BitwiseAnd(x, 0xff),
        b1 = Number.BitwiseShiftRight(Number.BitwiseAnd(x, 0xff00), 8),
        b2 = Number.BitwiseShiftRight(Number.BitwiseAnd(x, 0xff0000), 16),
        b3 = Number.BitwiseShiftRight(Number.BitwiseAnd(x, 0xff000000), 24)
      in
        Number.BitwiseOr(
          Number.BitwiseOr(
            Number.BitwiseShiftLeft(reverse(b0), 24),
            Number.BitwiseShiftLeft(reverse(b1), 16)
          ),
          Number.BitwiseOr(Number.BitwiseShiftLeft(reverse(b2), 8), reverse(b3))
        ),
    /*function for precomputing the CRC32 lookup table*/
    calculateCRClookup = (divident) =>
      let

        // move divident byte into MSB of 32Bit CRC
        curByte = Number.BitwiseShiftLeft(divident, 24)
      in
        List.Accumulate(
          {0 .. 7},
          curByte,
          (_curByte, _) =>
            let

              // if MSB set, shift left and XOR with polynomial = 0x4C11DB7
              then_clause = Number.BitwiseXor(Number.BitwiseShiftLeft(_curByte, 1), 0x4C11DB7),
              // else shift one bit left
              else_clause = Number.BitwiseShiftLeft(_curByte, 1)
            in //if MSB set
              if Number.BitwiseAnd(_curByte, 0x80000000) <> 0 then then_clause else else_clause
        ),
    /*function for computing CRC32 in raw form*/
    CRCaccumulator = (crc, ch) =>
      let
        curByte = reverse(Character.ToNumber(ch)),
        // update the MSB of crc value with next input byte 
        crc_1 = Number.BitwiseXor(Number.BitwiseShiftLeft(curByte, 24), crc),
        // this MSB byte value is the index into the lookup table 
        pos = Number.BitwiseAnd(Number.BitwiseShiftRight(crc_1, 24), 0xff),
        // shift out this index
        crc_2 = Number.BitwiseShiftLeft(crc_1, 8)
      in
        // XOR-ing remainder from lookup table using the calculated index
        Number.BitwiseXor(crc_2, CRC_table{pos}),
    // precompute CRC32 lookup table
    CRC_table = List.Generate(
      () => [count = 0, crc = 0],
      each [count] < 256,  // iterate over all possible input byte values 0-255
      each [count = [count] + 1, crc = calculateCRClookup(count)],
      each [crc]
    ),
    crc_ini = 0xffffffff,  // -1 used for initializing CRC registers
    //iterate over every character and compute CRC
    crc_raw = List.Accumulate(Text.ToList(StringInput), crc_ini, CRCaccumulator),
    crc_reversed = reverse32(crc_raw),  //final reverse
    crc_final = Number.BitwiseXor(crc_reversed, crc_ini),  //final xor with -1
    out = Number.ToText(crc_final, "X", "") //print in HEX form
  in
    out
