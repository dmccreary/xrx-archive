let $login-result := xmldb:login('/db', 'admin', 'admin123')
let $reindex-result := xmldb:reindex('/db/apps/books/data')

return
<results>
  <reindex-result>{$reindex-result}</reindex-result>
</results>
