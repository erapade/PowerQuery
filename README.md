# PowerQuery
Some Power Query code and functions that I don't want to lose
## PowerQuery functions
* AddRowHashColumn.pq - Adds a column containing the hash value of all the rows in a table. The function takes a table as the first argument and optionally a text as the second argument defining the name of the new column (default column name is RowHash)
* CalculateHash.pq  - Calculates a hash 32 bit hash value based on a text string
* GetKeys.pq - Get a list of all keys defined by using Table.AddKey(), GroupBy(), etc. The functions takes a table as the first argument and optionally a bolean as the second argument for choosing either Primary or secondary keys
* 
