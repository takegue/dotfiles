; string
(
 (string) @injection.content
 (#set! injection.language "javascript")
 (#set! injection.combined)
 (#set! injection.language "sql_bigquery")
);

; comment
((comment) @injection.content
  (#set! injection.language "comment"))

; javascript UDF
(
 (language)
 (create_function_body (string) @injection.content)
 (#set! injection.language "javascript")
);

