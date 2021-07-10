# PowerQuery
Some Power Query code and functions that I don't want to lose
## PowerQuery functions
* **fnAddRowHashColumn.pq** - Adds a column containing the hash value of all the rows in a table. The function takes a table as the first argument and optionally a text as the second argument defining the name of the new column (default column name is RowHash)
* **fnCalculateHash.pq**  - Calculates a hash 32 bit hash value based on a text string
* **fnGetKeys.pq** - Get a list of all keys defined by using Table.AddKey(), GroupBy(), etc. The functions takes a table as the first argument and optionally a bolean as the second argument for choosing either Primary or secondary keys
* **fnReorderSubsetOfColumns** - Reorders the columns by placing explicit columns first. The table takes as the first argument a table and as a second argument a list of column names
* **fnTableSkipToRow** - This function works like the Table.Skip function but instead of taking the number of rows as an argument it takes a Value as an argument and will skipp rows untill the first accurence or Value
* **fnTableRenameHeaders** - Renames headers in a table
## PowerQuery Tables
* **DataTable - Simple** - A simple date table. Slightly modified from https://blog.crossjoin.co.uk/2013/11/19/generating-a-date-dimension-table-in-power-query.  
