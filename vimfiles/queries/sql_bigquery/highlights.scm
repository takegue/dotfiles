; constant
[
    "NULL"
] @constant.builtin

[
    "TRUE"
    "FALSE"
] @boolean

(string) @string
(like_pattern) @string
(privilege_user) @string
(privilege_role) @string
(number) @number
(comment) @comment


; functions
(function_call function: (identifier) @function.call)
((argument (identifier) @variable.parameter))

(call_statement routine_name: (identifier) @function)

; types
(struct) @type.builtin
(array) @type.builtin
(interval) @type.builtin
(type_identifier) @type.builtin
(datetime_part) @type.builtin

(option_item key: (identifier) @variable.parameter)
(type) @type.builtin
(column_type) @type.builtin

;bigquery resource
; (identifier) @variable
((identifier) @constant.builtin (#any-of? @constant.builtin "_TABLE_SUFFIX" "_PARTITOINTIME" "_PARTITIONDATE" "_PARTITIONDATETIME"))
((from_item table_name: (identifier)) @constant.builtin)
((cte alias_name: (identifier) @constant.builtin))

(as_alias
  alias_name: (identifier) @property)

[
  ";"
  "."
  ","
] @punctuation.delimiter


(query_parameter) @variable.parameter
(system_variable) @variable.system


; (#lua-match? @constant "^_TABLE_SUFFIX$")

[
  "("
  ")"
  "["
  "]"
  "<"
  ">"
] @punctuation.bracket

[
  "DATE"
  "TIME"
  "DATETIME"
  "TIMESTAMP"

  "NUMERIC"
  "BIGNUMERIC"
  "DECIMAL"
  "BIGDECIMAL"

  "INTERVAL"
] @type.builtin

; operators
[
  "-"
  "*"
  "/"
  "^"
  "+"
  "<"
  "="
  "!="
  "<>"
  ">"
  ">>"
  "<<"
  "||"
  "~"
] @operator

; keywords
[
 "ALL"
 "ALTER"
 "CLONE"
 "ALTER_SCHEMA"
 "WITH_DIFFERENTIAL_PRIVACY"
 (with_recursive_keyword)
 "UNPIVOT"
 "PIVOT"
 "AND"
 "AS"
 "ASC"
 "ASSERT"
 "BETWEEN"
 "CASE"
 "CAST"
 "CREATE"
 "CREATE_SCHEMA"
 "DESC"
 "DISTINCT"
 "DROP_SCHEMA"
 "ELSE"
 "END"
 "EXCEPT"
 "EXPORT_DATA"
 "FOLLOWING"
 "FOR"
 "FROM"
 "FULL"
 "GRANT"
 "GROUP_BY"
 "HAVING"
 "IF_EXISTS"
 "IF_NOT_EXISTS"
 "IGNORE"
 "IN"
 "INNER"
 "INSERT"
 "INTERVAL"
 "INTO"
 "IS"
 "JOIN"
 "LEFT"
 "LIKE"
 "LIMIT"
 "MAX"
 "MERGE"
 "MIN"
 "NOT"
 "NULLS"
 "ON"
 "OPTIONS"
 "OR"
 "ORDER_BY"
 "OR_REPLACE"
 "OUTER"
 "OVER"
 "PARTITION_BY"
 "PRECEDING"
 "QUALIFY"
 "RANGE"
 "RIGHT"
 "ROLLUP"
 "ROWS"
 "SCHEMA"
 "SELECT"
 "SET"
 "TABLE"
 "THEN"
 "TO"
 "UNION_ALL"
 "INTERSECT_DISTINCT"
 "EXCEPT_DISTINCT"
 "GROUPING_SETS"
 "CUBE"
 "NULLS_FIRST"
 "NULLS_LAST"
 "UNION_DISTINCT"
 "UNNEST"
 "ANY"
 "SOME"
 "USING"
 "VALUES"
 "VIEW"
 "WHEN"
 "WHEN_NOT_MATCHED"
 "WHERE"
 "TEMP"
 "FUNCTION"
 "RETURNS"
 "LANGUAGE"
 "WINDOW"
 "WITH"
 "EXECUTE_IMMEDIATE"
] @keyword
